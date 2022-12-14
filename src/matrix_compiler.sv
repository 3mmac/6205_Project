`default_nettype none
`timescale 1ns / 1ps

module matrix_compiler #( parameter MAX_ELEMENT_SIZE = 8,
                        parameter MAX_SIZE_A = 32,
                        parameter MAX_SIZE_B = 32)

                     (  input wire inter_refclk,
                        input wire eth_refclk,
                        input wire rst,
                        input wire valid_data_in,
                        input wire [$clog2(MAX_SIZE_A)-1:0] row_addr,
                        input wire [$clog2(MAX_SIZE_B)-1:0] col_addr,
                        input wire [MAX_ELEMENT_SIZE-1:0] matrix_element,
                        input wire data_request,

                        output logic compile_done,
                        output logic [7:0] byte_out,
                        output logic valid_data_out,
                        output logic led
    );

   logic [$clog2(MAX_SIZE_B*MAX_SIZE_A)-1:0] addra, addrb;
   logic [MAX_SIZE_A*MAX_SIZE_B-1:0] bram_tracker;
   logic [MAX_ELEMENT_SIZE-1:0] dina, doutb;
   logic wea, enb, regceb, bram_rst, old;

   logic downtime;
   logic loading;
   logic waiting;
   logic transmit;

   logic [1:0] output_counter;
   logic [2:0] delay;
   
   always_comb begin
      byte_out = doutb;
      bram_rst = rst | old;
   end

   logic [$clog2(MAX_ELEMENT_SIZE/2)-1:0] element_counter;
   always_ff @(posedge inter_refclk) begin
      if(rst) begin
         downtime <= 0;
         loading <= 0;
         
         wea <= 0;

         bram_tracker <= 0;
         compile_done <= 0;
         led <= 0;
      end
      else begin
         if(downtime) begin
            //new output
            if(valid_data_in) begin
               //updating state
               downtime <= 0;
               loading <= 1'b1;
               //write to BRAM
               wea <= 1'b1;
               bram_tracker[((row_addr*MAX_SIZE_B)+col_addr)+:1] <= 1'b1;
            end else begin
               wea <= 0;
            end
         end 
         else if (loading) begin
            if(valid_data_in) begin
               //write to BRAM
               wea <= 1'b1;
               dina <= matrix_element;
               addra <= (row_addr*MAX_SIZE_B)+col_addr;
               //tracking update
               bram_tracker[((row_addr*MAX_SIZE_B)+col_addr)+:1] <= 1'b1;
            end else begin
               wea <= 0;
            end
            
            //every element has been given
            if(&bram_tracker) begin
               loading <= 0;
               compile_done <= 1'b1;
            end   
         end
         else if(waiting) begin
            wea <= 0;
            bram_tracker <= 0;
            compile_done <= 0;
            led <= 1'b1;
         end
         else if (transmit) begin
            wea <= 0;
            bram_tracker <= 0;
         end else begin
            downtime <= 1'b1;
         end
      end
   end

   always_ff @(posedge eth_refclk) begin
      if(rst) begin
         enb <= 0;
         regceb <= 0;
         addrb <= 0;
         old <= 0;
         element_counter <= 0;
         valid_data_out <= 0;
         output_counter <= 0;
      end
      else if (waiting) begin
         addrb <= 0;
         output_counter <= 0;
         if (data_request) begin
            waiting <= 0;
            transmit <= 1'b1;
            delay <= 0;
         end
      end 
      else if (transmit) begin
         if(delay < 3'b101) begin
            delay <= 3'b001 + delay;
            valid_data_out <= 0;
         end else begin
            valid_data_out <= 1'b1;
         end
         output_counter <= (output_counter == 2'b11)? 0: output_counter + 1'b1;
         //requesting reading
         enb <= 1'b1;
         regceb <= 1'b1;
         addrb <= (output_counter ==  2'b11)? addrb + 1'b1: addrb;
         

         if (addrb == 10'd1023) begin
            old <= 1'b1;
            transmit <= 0;
            delay <= 0;
         end
      end
      else begin
         valid_data_out <= (delay < 3'b101)? 1'b1 : 0;
         if (delay < 3'b100) begin
            valid_data_out <= 1'b1;
            delay <= delay + 1'b1;
            enb <= 1'b1;
            regceb <= 1'b1;
         end else begin
            valid_data_out <= 0;
            enb <= 0;
            regceb <= 0;
            addrb <= 0;
            old <= 0;
         end
         output_counter <= 0;
         if (compile_done) waiting <= 1'b1;
      end

   end
 

//  Xilinx Simple Dual Port 2 Clock RAM
  xilinx_simple_dual_port_2_clock_ram #(
    .RAM_WIDTH(MAX_ELEMENT_SIZE),                       // Specify RAM data width
    .RAM_DEPTH(MAX_SIZE_A*MAX_SIZE_B),                     // Specify RAM depth (number of entries)
    .RAM_PERFORMANCE("HIGH_PERFORMANCE"), // Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
    .INIT_FILE("")                        // Specify name/location of RAM initialization file if using one (leave blank if not)
  ) matrix_output (
    .addra(addra),    // Write address bus, width determined from RAM_DEPTH
    .addrb(addrb),    // Read address bus, width determined from RAM_DEPTH
    .dina(dina),      // RAM input data, width determined from RAM_WIDTH
    .clka(inter_refclk),      // Write clock
    .clkb(eth_refclk),      // Read clock
    .wea(wea),        // Write enable
    .enb(enb),        // Read Enable, for additional power savings, disable when not in use
    .rstb(bram_rst),      // Output reset (does not affect memory contents)
    .regceb(regceb),  // Output register enable
    .doutb(doutb)     // RAM output data, width determined from RAM_WIDTH
  );

endmodule

`default_nettype wire
