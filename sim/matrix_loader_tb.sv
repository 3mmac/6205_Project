default_nettype none
`timescale 1ns / 1ps

module matrix_loader_tb;
    logic eth_clk;
    logic inter_clk;
    logic rst;

    logic axiiv;
    logic [1:0] axiid;
    logic [4:0] requested_a_row;
    logic [4:0] requested_b_col;
    
    logic [4:0] addr_out;
    logic [255:0] a_row_out;
    logic [255:0] b_col_out;
    logic complete;


    matrix_loader uut(
        .inter_refclk(clk),
        .ether_refclk(clk),
        .rst(rst),

        .axiiv(axiiv),
        .axiid(axiid),
        .requested_a_row(requested_a_row),
        .requested_b_col(requested_b_col),

        .addr_out(addr_out),
        .a_row_out(a_row_out),
        .b_col_out(b_col_out),
        .complete(complete));

    
    always begin
        #10;
        clk = !clk;         //Now #20 will wait a clock period
    end

    initial begin
        $dumpfile("matrix_loader.vcd");
        $dumpvars(0, matrix_loader_tb);
        $display("Starting Sim");
        clk = 0;
        rst = 0;
        #30;
        rst = 1;
        #20;
        rst = 0;
        #20
        #20
        #20
        
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
