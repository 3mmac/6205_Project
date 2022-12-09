default_nettype none
`timescale 1ns / 1ps

module matrix_loader_tb;
    logic eth_clk;
    logic inter_clk;
    logic rst;

    logic axiiv;
    logic [1:0] axiod;
    logic complete;
    logic [1:0] axiod_out;


    matrix_loader uut(
        .clk(clk),
        .rst(rst),
        .crsdv(crsdv),
        .rxd(rxd),
        .axiov(axiov_out),
        .axiod(axiod_out));

    
    always begin
        #10;
        clk = !clk;         //Now #20 will wait a clock period
    end

    initial begin
        $dumpfile("ether.vcd");
        $dumpvars(0, ether_tb);
        $display("Starting Sim");
        clk = 0;
        rst = 0;
        #30;
        rst = 1;
        #20;
        rst = 0;
        //READ SIGNAL BUT BAD RXD
        crsdv = 1'b1;
        rxd= 2'b11;
        #20;
        crsdv = 1'b1;
        rxd= 2'b00;
        #20;
        crsdv = 1'b1;
        rxd= 2'b01;
        #20;
        
        //PREAMBLE & SFD
        for(int i = 0; i <31; i = i+1) begin
            crsdv = 1'b1;
            rxd = 2'b10;
            #20;
        end
        crsdv = 1'b1;
        rxd = 2'b11;
        #20;

        //REST
        for (int i = 0; i<6040; i = i+1) begin
            if(i%3 == 0) begin
                crsdv = 1'b1;
                rxd = 2'b11;               
            end else begin
                crsdv = 1'b1;
                rxd = 2'b01;
            end
            #20;
        end
        crsdv = 0;
        #20
        crsdv = 0;

    $display("Finishing Sim");
    $finish;
    end

endmodule

`default_nettype wire
