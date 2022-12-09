`default_nettype none
`timescale 1ns / 1ps

//Potential Alteration, send out addr when added and then the module can request when its addr is seen
//NEED TO ADD CHECK SYSTEM

module matrix_loader #( parameter MAX_ELEMENT_SIZE = 8,
                        parameter MAX_ROW_SIZE_A = 32,
                        parameter MAX_COL_SIZE_A = 32,
                        parameter MAX_ROW_SIZE_B = 32,
                        parameter MAX_COL_SIZE_B = 32)

                    (   input wire inter_refclk,
                        input wire eth_refclk,
                        input wire rst,
                        input wire axiiv,
                        input wire axiid,
                        input wire requested_a_row,
                        input wire requested_b_col,

                        output logic [MAX_ROW_SIZE_A*MAX_ELEMENT_SIZE-1:0] a_row_out,
                        output logic [MAX_ROW_SIZE_A*MAX_ELEMENT_SIZE-1:0] b_col_out,
                        output logic complete
                    );

    parameter HEADER_SIZE = MAX_ELEMENT_SIZE + $clog2(MAX_ROW_SIZE_A) + $clog2(MAX_COL_SIZE_B);
    parameter ADDR_LENGTH = MAX_ELEMENT_SIZE*$clog2(MAX_ROW_SIZE_A)*$clog2(MAX_COL_SIZE_B);


    logic downtime;
    logic info;
    logic loading;
    logic retrieving;
    
    logic [HEADER_SIZE-1:0] info_counter; //
    logic [MAX_ELEMENT_SIZE-1:0] element_value;
    logic 
    
    logic [$clog2(MAX_ROW_SIZE_A)] matrix_a_size; // will be loaded in
    logic [$clog2(MAX_COL_SIZE_B)] matrix_b_size; // will be loaded in

    logic [ADDR_LENGTH-1:0] A_addra; //matrix A loading address
    logic [ADDR_LENGTH-1:0] A_addrb; //matrix A recieving address
    logic [ADDR_LENGTH-1:0] B_addra; //matrix B loading address
    logic [ADDR_LENGTH-1:0] B_addrb; //matrix B recieving address
    logic [MAX_ELEMENT_SIZE*$clog2(MAX_ROW_SIZE_A)-1:0] A_dina; //matrix A element value 
    


    always_ff @(posedge eth_refclk) begin
        if (rst) begin
            downtime <= 1'b1;
            info <= 0;
            loading <= 0;
            retrieving <= 0;
            info_counter <= 0;
            element_data <== 0;
            matrix_a_size <= 0;
            matrix_b_size <= 0;

        end
        
        else if (downtime) begin
            if (axiiv) begin
                downtime <= 0;
            end

        end
        else if (info) begin
        end
        else if (loading) begin
        end
        else begin
        end
    end

    always_ff @(posedge inter_refclk) begin
        if (retrieving) begin
        end

        else begin
        end
    end


//  Xilinx Simple Dual Port 2 Clock RAM
  xilinx_simple_dual_port_2_clock_ram #(
    .RAM_WIDTH(MAX_COL_SIZE_A),                       // Specify RAM data width
    .RAM_DEPTH(MAX_ELEMENT_SIZE*MAX_ROW_SIZE_A),                     // Specify RAM depth (number of entries)
    .RAM_PERFORMANCE("HIGH_PERFORMANCE"), // Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
    .INIT_FILE("")                        // Specify name/location of RAM initialization file if using one (leave blank if not)
  ) Matrix_A_BRAM (
    .addra(A_addra),    // Write address bus, width determined from RAM_DEPTH
    .addrb(A_addrb),    // Read address bus, width determined from RAM_DEPTH
    .dina(A_dina),      // RAM input data, width determined from RAM_WIDTH
    .clka(eth_refclk),      // Write clock
    .clkb(inter_refclk),      // Read clock
    .wea(A_wea),        // Write enable
    .enb(A_enb),        // Read Enable, for additional power savings, disable when not in use
    .rstb(rst),      // Output reset (does not affect memory contents)
    .regceb(A_regceb),  // Output register enable
    .doutb(a_row_out)     // RAM output data, width determined from RAM_WIDTH
  );

//  Xilinx Simple Dual Port 2 Clock RAM
  xilinx_simple_dual_port_2_clock_ram #(
    .RAM_WIDTH(MAX_ROW_SIZE_B),                       // Specify RAM data width
    .RAM_DEPTH(MAX_ELEMENT_SIZE*MAX_COL_SIZE_B),                     // Specify RAM depth (number of entries)
    .RAM_PERFORMANCE("HIGH_PERFORMANCE"), // Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
    .INIT_FILE("")                        // Specify name/location of RAM initialization file if using one (leave blank if not)
  ) Matrix_B_BRAM (
    .addra(B_addra),    // Write address bus, width determined from RAM_DEPTH
    .addrb(B_addrb),    // Read address bus, width determined from RAM_DEPTH
    .dina(B_dina),      // RAM input data, width determined from RAM_WIDTH
    .clka(eth_refclk),      // Write clock
    .clkb(inter_refclk),      // Read clock
    .wea(B_wea),        // Write enable
    .enb(B_enb),        // Read Enable, for additional power savings, disable when not in use
    .rstb(rst),      // Output reset (does not affect memory contents)
    .regceb(B_regceb),  // Output register enable
    .doutb(b_col_out)     // RAM output data, width determined from RAM_WIDTH
  );


endmodule

`default_nettype wire