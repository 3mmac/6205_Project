`default_nettype none
`timescale 1ns / 1ps

module bitorder_tb;
    logic clk;
    logic rst;

    logic axiiv;
    logic [1:0] axiid;
    logic axiov_out;
    logic [1:0] axiod_out;


    bitorder uut(
        .clk(clk),
        .rst(rst),
        .axiiv(axiiv),
        .axiid(axiid),
        .axiov(axiov_out),
        .axiod(axiod_out));

    
    always begin
        #10;
        clk = !clk;         //Now #20 will wait a clock period
    end

    initial begin
        $dumpfile("bitorder.vcd");
        $dumpvars(0, bitorder_tb);
        $display("Starting Sim");
        clk = 0;
        rst = 0;
        #30;
        rst = 1;
        #20;
        rst = 0;
        //READ IN FIRST BYTE
        axiiv = 1'b1;
        axiid = 2'b01;
        #20;
        axiiv = 1'b1;
        axiid = 2'b01;
        #20;
        axiiv = 1'b1;
        axiid = 2'b01;
        #20;
        axiiv = 1'b1;
        axiid = 2'b11;
        #20;
        //READ IN SECOND BYTE
        axiiv = 1'b1;
        axiid = 2'b00;
        #20;
        axiiv = 1'b1;
        axiid = 2'b11;
        #20;
        axiiv = 1'b1;
        axiid = 2'b01;
        #20;
        axiiv = 1'b1;
        axiid = 2'b10;
        #20;
        //READ IN THIRD BYTE (WITH A STALL...)
        axiiv = 1'b1;
        axiid = 2'b00;
        #20;
        axiiv = 1'b1;
        axiid = 2'b00;
        #20;
        axiiv = 1'b0;
        axiid = 2'b11;
        #20;
        axiiv = 1'b1;
        axiid = 2'b00;
        #20; 
        axiiv = 1'b1;
        axiid = 2'b00;
        #20;      
        //READ IN FOURTH BYTE  
        axiiv = 1'b1;
        axiid = 2'b01;
        #20;
        axiiv = 1'b1;
        axiid = 2'b01;
        #20;
        axiiv = 1'b1;
        axiid = 2'b01;
        #20;
        axiiv = 1'b1;
        axiid = 2'b11;
        #20;      


    $display("Finishing Sim");
    $finish;
    end

endmodule

`default_nettype wire