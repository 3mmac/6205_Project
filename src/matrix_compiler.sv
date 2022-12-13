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
                        input wire [$clog2(MAX_ELEMENT_SIZE)-1:0] matrix_element,

                        output logic [1:0] dibit,
                        output logic valid_data_out
    );

   logic [$clog2(MAX_SIZE_A)-1:0] addra;
   logic [$clog2(MAZ_SIZE_B)-1:0] addrb;
   logic [MAX_SIZE_A*MAX_ELEMENT_SIZE-1:0] dina, row_out;
   logic wea, enb, regceb;

   
   logic [MAX_ELEMENT_SIZE*MAX_SIZE_A-1:0] data_buffer;

   logic downtime;
   logic loading;
   logic transmitting;

   always_ff @(posedge inter_refclk) begin
      if (rst) begin
         downtime <= 1'b1;
         loading <= 0;
      end
      else if (downtime) begin
         if (valid_data_in) begin
            downtime <= 0;
            loading <= 1'b1;
            data_buffer[(255-8*col_addr)-: 8] <= matrix_element;
            data_buffer 
         end
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