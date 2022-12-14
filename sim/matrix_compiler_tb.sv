`default_nettype none
`timescale 1ns / 1ps

module matrix_compiler_tb;
    logic clk;
    logic rst;

    logic valid_data_in;
    logic [4:0] row_addr;
    logic [4:0] col_addr;
    logic [7:0] matrix_element;
    logic data_request;
    
    //logic [1:0] dibit;
    logic [7:0] byte_out;
    logic valid_data_out;
    logic compile_done;


    matrix_compiler#() uut(
        .inter_refclk(clk),
        .eth_refclk(clk),
        .rst(rst),

        .valid_data_in(valid_data_in),
        .row_addr(row_addr),
        .col_addr(col_addr),
        .matrix_element(matrix_element),

        //.dibit(dibit),
        .byte_out(byte_out),
        .valid_data_out(valid_data_out),
        .data_request(data_request),
        .compile_done(compile_done));

    
    always begin
        #10;
        clk = !clk;         //Now #20 will wait a clock period
    end

    initial begin
        $dumpfile("matrix_compiler.vcd");
        $dumpvars(0, matrix_compiler_tb);
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
        data_request = 0;
        //MATRIX A
        for(int i = 0; i<32; i=i+1) begin
            //ROW
            for(int j = 0; j <32; j = j+1) begin
                //ELEMENT CREATION
                valid_data_in = 1'b1;
                matrix_element = (j%2)? 8'b1111_1111: 8'b1010_1010;
                row_addr = i;
                col_addr = j;
                #20;
                end
        end


        valid_data_in = 0;
        #20;
        #20;
        #20;
        #20;
        #20;
        #20;
        #20;
        data_request = 1'b1;
        //REST
        for (int i = 0; i<1026*4; i = i+1) begin
            #20;
            data_request = 0;
        end
    

    $display("Finishing Sim");
    $finish;
    end

endmodule

`default_nettype wire