`default_nettype none
`timescale 1ns / 1ps

module firewall_tb;
    logic clk;
    logic rst;

    logic axiiv;
    logic [1:0] axiid;
    logic axiov_out;
    logic [1:0] axiod_out;


    firewall uut(
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
        $dumpfile("firewall.vcd");
        $dumpvars(0, firewall_tb);
        $display("Starting Sim");
        clk = 0;
        rst = 0;
        #30;
        rst = 1;
        #20;
        rst = 0;
        #20;
        //DA
        for (int i = 0; i<24; i=i+1) begin
            axiiv <= 1'b1;
            axiid <= 2'b11;
            #20;
        end
        //SA
        for (int i = 0; i<24; i = i+1) begin
            axiid <= i%3;
            axiiv <= 1'b1;
            #20;
        end
        //Length
        for (int i = 0; i<8; i = i+1) begin
            axiid <= 1'b1;
            axiiv <= 1'b1;
            #20;
        end
        //RANDOM
        for (int i = 0; i<50; i = i+1) begin
            axiid <= i%3;
            axiiv <= 1'b1;
            #20;
        end

        axiiv <= 0;
        #20;
        #20

    $display("Finishing Sim");
    $finish;
    end

endmodule

`default_nettype wire