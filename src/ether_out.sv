`default_nettype none
`timescale 1ns / 1ps

module ether_out (
                    input wire clk,
                    input wire rst,
                    input wire axiiv,
                    input wire [1:0] axiid,
                    input wire preamble_signal,
                    input wire data_complete, //is on for a single cycle the cycle after all data has been transmitted

                    output logic axiov,
                    output logic [1:0] axiod,
                    output logic send_data
);
    logic [175:0] HEADER;
    logic [4:0] gap_counter; // gap is 32 cycles
    logic [6:0] header_counter; //header is 88 cycles
    logic [3:0] fcs_counter; //fcs is 16 cycles

    logic transmit_header;
    logic transmit_data;
    logic transmit_fcs;
    logic transmit_gap;
    logic downtime;

    logic [1:0] fcs_in;
    logic fcs_in_valid;
    logic fcs_out_valid;
    logic [31:0] fcs_out;
    logic crc_rst;

    logic [31:0] fcs_hold;

    assign HEADER = 176'h5555_5555_5555_5557_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_9000;

    crc32 my_crc (.clk(clk), .rst(crc_rst), .axiiv(fcs_in_valid), .axiid(fcs_in), .axiov(fcs_out_valid), .axiod(fcs_out));

    always_comb begin
        if (downtime | transmit_fcs | transmit_gap) begin
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
   
    //state machine and handling outputs
    always_ff @(posedge clk) begin
        if(rst) begin
            gap_counter <= 0;
            header_counter <= 0;
            fcs_counter <= 0;

            transmit_header <= 0;
            transmit_data <= 0;
            transmit_fcs <= 0;
            transmit_gap <= 0;
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
                if (header_counter == 7'd31) begin
                    transmit_header <= 0;
                    transmit_data <= 1'b1;
                    header_counter <= 0;
                end
                else begin
                    header_counter <= header_counter + 1'b1;
                    //transmit appropriate portion of header based on counter
                    axiod <= HEADER[(175-2*header_counter)-:2]
                    axiov <= 1'b1;
                end
            end

            else if (transmit_data) begin


            end

            else if (transmit_fcs) begin
            end
            else if (transmit_gap) begin
            end
        end
    end


endmodule

`default_nettype wire