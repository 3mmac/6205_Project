`default_nettype none
`timescale 1ns / 1ps

module ether_out_tb;
    logic clk;
    logic rst;

    logic axiiv;
    logic [1:0] axiid;
    logic preamble_signal, data_request;
    logic [1:0] axiod;
    logic axiov;


    ether_out uut(
        .clk(clk),
        .rst(rst),
        .axiiv(axiiv),
        .axiid(axiid),
        .axiov(axiov),
        .axiod(axiod),
        .preamble_signal(preamble_signal),
        .data_request(data_request)
        );

    
    always begin
        #10;
        clk = !clk;         //Now #20 will wait a clock period
    end

    initial begin
        $dumpfile("ether_out.vcd");
        $dumpvars(0, ether_out_tb);
        $display("Starting Sim");
        clk = 0;
        rst = 0;
        #30;
        rst = 1;
        #20;
        rst = 0;
        //Giving preamble signal
        #20;
        #20;
        #20;
        preamble_signal = 1'b1;
        #20;
        preamble_signal = 0; 
        #20;
        #20;
        #20;
        #20;

        //MATRIX A
        for(int i = 0; i<32; i=i+1) begin
            //ROW
            for(int j = 0; j <32; j = j+1) begin
                //ELEMENT CREATION
                for(int k = 0; k<4; k=k+1) begin
                    if(i==j)begin
                        axiiv = 1'b1;
                        axiid = 0;
                    end else begin
                        axiid = 2'b11;
                        axiiv = 1'b1;
                    end
                    #20;
                end
            end
        end
        for (int i = 0; i<10000; i=i+1) begin
            axiiv <= 0;
            #20;
        end

    $display("Finishing Sim");
    $finish;
    end

endmodule

`default_nettype wire
