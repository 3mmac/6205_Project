`default_nettype none
`timescale 1ns / 1ps

`define MESSAGE	168'h4261_7272_7921_2042_7265_616b_6661_7374_2074_696d65
`define CKSUM	32'h1a3a_ccb2

module fcs_tb;
    logic clk;
    logic rst;

    logic axiiv;
    logic [1:0] axiid;
    logic done;
    logic kill;


    cksum uut(
        .clk(clk),
        .rst(rst),
        .axiiv(axiiv),
        .axiid(axiid),
        .done(done),
        .kill(kill));

    
    always begin
        #10;
        clk = !clk;         //Now #20 will wait a clock period
    end

    initial begin
        $dumpfile("fcs.vcd");
        $dumpvars(0, fcs_tb);
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
        //PREAMBLE & SFD
        for(int i = 0; i <31; i = i+1) begin
            axiiv = 1'b1;
            axiid = 2'b10;
            #20;
        end
        axiiv = 1'b1;
        axiid = 2'b11;
        #20;
        
        for(int i = 0; i<3; i= i+1) begin
            axiiv <= 0;
            #20;
        end

        axiiv <= 0;
        #20;
        #20
        #20
        #20

        //PREAMBLE & SFD
        for(int i = 0; i <31; i = i+1) begin
            axiiv = 1'b1;
            axiid = 2'b10;
            #20;
        end
        axiiv = 1'b1;
        axiid = 2'b11;
        #20;
        
        for(int i = 0; i<3; i= i+1) begin
            axiiv <= 0;
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