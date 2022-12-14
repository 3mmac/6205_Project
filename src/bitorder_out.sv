`default_nettype none
`timescale 1ns / 1ps


module bitorder_out (
                input wire clk,
                input wire rst,
                input wire axiiv,
                input wire [7:0] axiid,

                output logic axiov,
                output logic [1:0] axiod,
                output logic led 
                );

    //recieved in one clock cycles - [7:6],[5:4],[3:2],[1:0]
    //output in four clock cycle - 1:0 -> 3:2 -> 5:4 -> 7:6

    logic [1:0] counter_in;

    logic downtime;
    logic flipping;

    always_ff @(posedge clk) begin
        if (rst) begin
            downtime <= 1'b1;
            flipping <= 0;
            led <= 0;
        end else begin
            if(downtime) begin
                if(axiiv) begin
                    flipping <= 1'b1;
                    downtime <= 0;
                    counter_in <= 1'b1;
                    axiov <= 1'b1;
                    axiod <= axiid[1:0];
                end else begin
                    counter_in <= 0;
                    axiov <= 0;
                end
            end else if (flipping) begin
                if (axiiv) begin
                    counter_in <= (counter_in == 2'b11)? 0:counter_in +1'b1;
                    axiov <= 1'b1;
                    axiod <= axiid[(counter_in*2)+:2];
                end else begin
                    downtime <= 1'b1;
                    flipping <= 0;
                    axiov <= 0;
                end
            end
        end
    end
endmodule

`default_nettype wire