`default_nettype none
`timescale 1ns / 1ps

module matrix_loader_tb;
    logic clk;
    logic rst;

    logic axiiv;
    logic [1:0] axiid;
    logic [4:0] requested_a_row;
    logic [4:0] requested_b_col;
    
    logic [4:0] addr_out;
    logic [255:0] a_row_out;
    logic [255:0] b_col_out;
    logic complete;


    matrix_loader#() uut(
        .inter_refclk(clk),
        .eth_refclk(clk),
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
        #20;
        #20;
        #20;
        //MATRIX
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
        axiid = 0;
        axiiv = 0;
        #20
        //REST
        for (int i = 0; i<31; i = i+1) begin
            #20;
        end


    $display("Finishing Sim");
    $finish;
    end

endmodule

`default_nettype wire
