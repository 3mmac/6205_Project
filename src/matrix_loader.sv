`default_nettype none
`timescale 1ns / 1ps

module matrix_loader #( parameter MAX_ELEMENT_SIZE = 8,
                        parameter MAX_ROW_SIZE_A = 32,
                        parameter MAX_COL_SIZE_A = 32,
                        parameter MAX_ROW_SIZE_B = 32,
                        parameter MAX_COL_SIZE_B = 32)

                     (  input wire inter_refclk,
                        input wire eth_refclk,
                        input wire axiiv,
                        input wire axiid,
                        input wire requested_a_row,
                        input wire requested_b_col,

                        output logic [MAX_ROW_SIZE_A*MAX_ELEMENT_SIZE:0] a_row_out,
                        output logic [MAX_ROW_SIZE_A*MAX_ELEMENT_SIZE:0] b_col_out,
                        output logic complete

    );


endmodule

`default_nettype wire