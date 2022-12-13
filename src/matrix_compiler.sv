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

                        output logic [MAX_ELEMENT_SIZE*MAX_SIZE_A-1:0] dibit,
                        output logic valid_data_out
    );

   logic [$clog2(MAX_SIZE_A)-1:0] addra, update_addr;
   logic [$clog2(MAX_SIZE_B)-1:0] addrb, fill_col;
   logic [MAX_SIZE_A*MAX_ELEMENT_SIZE-1:0] dina, row_out;
   logic wea, enb, regceb;

   
   logic [MAX_ELEMENT_SIZE*MAX_SIZE_A-1:0] data_buffer;
   logic [$clog2(MAX_SIZE_A*MAX_SIZE_B)-1:0] element_counter;

   logic downtime;
   logic loading;
   logic transmitting;

   logic fill;
   logic update;
   logic [$clog2(MAX_ELEMENT_SIZE)-1:0] fill_element;
   logic [1:0] read_addr_buffer;

   always_ff @(posedge inter_refclk) begin
      if (rst) begin
         downtime <= 1'b1;
         loading <= 0;
         transmitting <= 0;
         wea <= 0;
         enb <= 0;
         regceb <= 0;
         fill <= 0;
         update <= 0;
         element_counter <= 0;
         data_buffer <= 0;
      end

      else if (downtime) begin
         if (valid_data_in) begin
            downtime <= 0;
            loading <= 1'b1;
            data_buffer[(255-8*col_addr)-: 8] <= matrix_element;
            write <= 1'b1;
            write_addr <= row_addr;
         end
      end 
      
      else if (loading) begin
         if(write) begin
            //Making data input
            dina     
         end else begin
         end
      
      end


      // else if (loading) begin
      //    //writing if something new in buffer
      //    if (update) begin
      //       wea <= 1'b1;            //BRAM write enable
      //       addra <= update_addr;   //BRAM write address
      //       dina <= data_buffer;    //BRAM write input data
      //       if (element_counter == 10'd1023) begin
      //          transmitting <= 1'b1;
      //          loading <= 0;
      //       end
      //    end else begin
      //       wea <= 0;
      //    end
      //    //put element into buffer
      //    if(fill) begin
      //       for(int i = 0; i < 256; i++) begin
      //          if ((i > (255-8*fill_col)) | (i<(448-8*fill_col))) begin
      //             data_buffer[i] <= row_out[i];
      //          end else begin
      //             data_buffer[i] <= fill_element[(i%8)];        // else if (loading) begin
      //    //writing if something new in buffer
      //    if (update) begin
      //       wea <= 1'b1;            //BRAM write enable
      //       addra <= update_addr;   //BRAM write address
      //       dina <= data_buffer;    //BRAM write input data
      //       if (element_counter == 10'd1023) begin
      //          transmitting <= 1'b1;
      //          loading <= 0;
      //       end
      //    end else begin
      //       wea <= 0;
      //    end
      //    //put element into buffer
      //    if(fill) begin
      //       for(int i = 0; i < 256; i++) begin
      //          if ((i > (255-8*fill_col)) | (i<(448-8*fill_col))) begin
      //             data_buffer[i] <= row_out[i];
      //          end else begin
      //             data_buffer[i] <= fill_element[(i%8)];  
      //          end
      //       end
      //       update <= 1'b1;         //Update state
      //       update_addr <= addrb;   //Update state's write address
      //    end else begin
      //       update <= 0;
      //    end
      //    //read out current row
      //    if (valid_data_in) begin
      //       addrb <= row_addr;   //BRAM read address
      //       enb <= 1'b1;         //BRAM read enable
      //       regceb <= 1'b1;      //BRAM output register enable
      //       fill <= 1'b1;                    //Fill state 
      //       fill_element <= matrix_element;   //Fill state's element
      //       fill_col <= col_addr;            //Fill state's column
      //       element_counter <= element_counter + 1'b1;
      //    end else begin
      //       fill <= 0;
      //       enb <= 0;
      //    end
      // end 
      //          end
      //       end
      //       update <= 1'b1;         //Update state
      //       update_addr <= addrb;   //Update state's write address
      //    end else begin
      //       update <= 0;
      //    end
      //    //read out current row
      //    if (valid_data_in) begin
      //       addrb <= row_addr;   //BRAM read address
      //       enb <= 1'b1;         //BRAM read enable
      //       regceb <= 1'b1;      //BRAM output register enable
      //       fill <= 1'b1;                    //Fill state 
      //       fill_element <= matrix_element;   //Fill state's element
      //       fill_col <= col_addr;            //Fill state's column
      //       element_counter <= element_counter + 1'b1;
      //    end else begin
      //       fill <= 0;
      //       enb <= 0;
      //    end
      // end 
      
      else if (transmitting) begin
         wea <= 0;
      end
   end

   always_ff @(posedge eth_refclk) begin
      if (rst) begin
         addrb <= 0;
         enb <= 0;
         regceb <= 0;
      end else if (transmitting) begin
         enb <= 1'b1;
         regceb <= 1'b1;
         addrb <= addrb + 1'b1;
         dibit <= row_out;
         valid_data_out <= 1'b1;
      end
   end

//  Xilinx Simple Dual Port 2 Clock RAM
  xilinx_simple_dual_port_2_clock_ram #(
    .RAM_WIDTH(MAX_SIZE_A*MAX_ELEMENT_SIZE),                       // Specify RAM data width
    .RAM_DEPTH(MAX_SIZE_B),      // Specify RAM depth (number of entries)
    .RAM_PERFORMANCE("HIGH_PERFORMANCE"), // Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
    .INIT_FILE("")                        // Specify name/location of RAM initialization file if using one (leave blank if not)
  ) Matrix_B_BRAM (
    .addra(addra),    // Write address bus, width determined from RAM_DEPTH
    .addrb(addrb),    // Read address bus, width determined from RAM_DEPTH
    .dina(dina),      // RAM input data, width determined from RAM_WIDTH
    .clka(inter_refclk),      // Write clock
    .clkb(eth_refclk),      // Read clock
    .wea(wea),        // Write enable
    .enb(enb),        // Read Enable, for additional power savings, disable when not in use
    .rstb(rst),      // Output reset (does not affect memory contents)
    .regceb(regceb),  // Output register enable
    .doutb(row_out)     // RAM output data, width determined from RAM_WIDTH
  );

endmodule

`default_nettype wire