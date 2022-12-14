`default_nettype none
`timescale 1ns / 1ps

module matrix_comp_out_tb;
    logic clk;
    logic rst;

    logic valid_data_in;
    logic [4:0] row_addr;
    logic [4:0] col_addr;
    logic [7:0] matrix_element;
    logic data_request;
    
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

        .byte_out(byte_out),
        .valid_data_out(valid_data_out),
        .data_request(data_request),
        .compile_done(compile_done));


    logic axiov_bit;
    logic [1:0] axiod_bit;

    bitorder_out test_bitorder(
        .clk(clk),
        .rst(rst),
        .axiiv(valid_data_out),
        .axiid(byte_out),
        .axiov(axiov_bit),
        .axiod(axiod_bit));


    logic [1:0] axiod_eth;
    logic axiov_eth;

    ether_out#() test_ether(
        .clk(clk),
        .rst(rst),
        .axiiv(axiov_bit),
        .axiid(axiod_bit),
        .axiov(axiov_eth),
        .axiod(axiod_eth),
        .preamble_signal(compile_done),
        .data_request(data_request)
        );  

    always begin
        #10;
        clk = !clk;         //Now #20 will wait a clock period
    end

    initial begin
        $dumpfile("matrix_comp_out.vcd");
        $dumpvars(0, matrix_comp_out_tb);
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
        //REST
        for (int i = 0; i<1026*10; i = i+1) begin
            #20;
        end

        $display("Finishing Sim");
        $finish;
    end

endmodule

`default_nettype wire

