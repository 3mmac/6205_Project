`default_nettype none
`timescale 1ns / 1ps


module cksum (
                input wire clk,
                input wire rst,
                input wire axiiv,
                input wire [1:0] axiid,

                output logic done,
                output logic kill
                );

    //states: rest (00), waiting for crc32 result(11)
    logic [31:0] CKSUM; 
    logic waiting;
    logic complete;
    logic same;
    logic prev_axiiv;
    logic axiov_out;
    logic [31:0] axiod_out;
    logic crc_rst; 
    logic packet;
    logic set;

    assign CKSUM = 32'h38_fb_22_84;

    crc32 my_crc (.clk(clk), .rst(crc_rst), .axiiv(axiiv), .axiid(axiid), .axiov(axiov_out), .axiod(axiod_out));

    always_comb begin
        done = complete;
        kill = same;
        crc_rst = rst | (~axiiv & set);
    end

    always_ff @(posedge clk) begin
        if(rst) begin
            waiting <= 0;
            complete <= 0;
            same <= 0;
            prev_axiiv <= axiiv;
            packet <= 0;
            set <= 0;
        end else begin
            prev_axiiv <= axiiv;
            if(~prev_axiiv & axiiv) begin
            //rising edge: NEW PACKET
                complete <= 0;
                same <= 0;
                packet <= 1;
            end else if (~axiiv & packet) begin
            //falling edge: PACKET DONE
                if(axiov_out) begin
                    //completed crc32
                    complete <= 1;
                    same <= ~(CKSUM == axiod_out);
                    packet <= 0;
                    set <= 1'b1;
                end 
            end else if (~axiiv & set) begin
            //BETWEEN PACKETS
                set <= 0;
            end
        end
    end

endmodule

`default_nettype wire