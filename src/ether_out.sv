`default_nettype none
`timescale 1ns / 1ps

module ether_out (
                    input wire clk,
                    input wire rst,
                    input wire axiiv,
                    input wire [1:0] axiid,
                    input wire preamble_signal,

                    output logic axiov,
                    output logic [1:0] axiod,

);
    logic [175:0] HEADER;
    logic [4:0] gap_counter; // gap is 32 cycles
    logic [6:0] header_counter; //header is 88 cycles
    logic [3:0] fcs_counter; //fcs is 16 cycles
    logic transmit_header;
    logic transmit_data;
    logic transmit_fcs;
    logic downtime;

    logic [1:0] fcs_in;
    logic fcs_in_valid;
    logic fcs_out_valid;
    logic [31:0] fcs_out;
    logic crc_rst;

    logic [31:0] fcs_hold;
    logic [1:0] current_header_out;

    //SA = FF:FF:FF:FF:FF:FF
    //DA = FF:FF:FF:FF:FF:FF
    //Ethertype = 0x0600 = 0b 0000_0110 _0000_0000 = 1001_0000, 0000_0000
    assign HEADER = 176'h5555_5555_5555_5557_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_9000;

    //no time crossing right now
    crc32 my_crc (.clk(clk), .rst(crc_rst), .axiiv(fcs_in_valid), .axiid(fcs_in), .axiov(fcs_out_valid), .axiod(fcs_out));

    always_comb begin
        if (downtime | transmit_fcs) begin
            crc_rst = 1'b1;
            fcs_in_valid = 0;
            fcs_in = 0;
        end
        else if (transmit_header | transmit_data) begin
            crc_rst = rst;
            fcs_in_valid = axiov;
            fcs_in = axiod;
        end
    end

    always_ff @(posedge clk) begin
        if(rst) begin
            gap_counter <= 0;
            header_counter <= 0;
            fcs_counter <= 0;

            transmit_header <= 0;
            transmit_data <= 0;
            transmit_fcs <- 0;
            downtime <= 1'b1;
        end
        else begin
            if (downtime) begin
                if (preamble_signal) begin
                    transmit_header <= 1'b1;
                    downtime <= 0;
                end
                
            end
            else if (transmit_header) begin
            end
            else if (transmit_data) begin
            end
            else if (transmit_fcs) begin
            end
        end
    end


endmodule

`default_nettype wire