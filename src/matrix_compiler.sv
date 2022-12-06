`default_nettype none
`timescale 1ns / 1ps

module matrix_compiler #( parameter MAX_ELEMENT_SIZE = 8,
                        parameter MAX_ROW_SIZE_A = 32,
                        parameter MAX_COL_SIZE_A = 32,
                        parameter MAX_ROW_SIZE_B = 32,
                        parameter MAX_COL_SIZE_B = 32)

                     (  input wire inter_refclk,
                        input wire eth_refclk,
                        input wire valid_data_in,
                        input wire [clog2(MAX_ELEMENT_SIZE)-1:0] matrix_element,

                        output logic [1:0] dibit,
                        output logic valid_data_out
    );


endmodule

`default_nettype wire