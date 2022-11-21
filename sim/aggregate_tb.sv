`default_nettype none
`timescale 1ns / 1ps

`define MESSAGE	2000'h12345678000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

module aggregate_tb;
    logic clk;
    logic rst;

    logic axiiv;
    logic [1:0] axiid;
    logic axiov;
    logic [31:0]axiod;
    logic [31:0] in;


    aggregate uut(
        .clk(clk),
        .rst(rst),
        .axiiv(axiiv),
        .axiid(axiid),
        .axiov(axiov),
        .axiod(axiod));

    
    always begin
        #10;
        clk = !clk;         //Now #20 will wait a clock period
    end

    initial begin
        $dumpfile("aggregate.vcd");
        $dumpvars(0, aggregate_tb);
        $display("Starting Sim");
        clk = 0;
        rst = 0;
        axiiv = 0;
        axiid = 0;

        #30;
        rst = 1;
        #20;
        rst = 0;
        #20;
        for (int i = 0; i < 32; i = i +1) begin
             axiiv <= 1'b1;
             axiid <= i%4;
             #20;
        end 
        for (int i = 0; i < 100; i = i +1) begin
             if(i < 33) begin
                axiiv <= 1'b1;
                axiid <= 0;
                #20;
             end else begin
                axiiv <= 0;
                axiid <= 0;
                #20;
             end
        end 



    $display("Finishing Sim");
    $finish;
    end

endmodule

`default_nettype wire