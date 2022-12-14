`default_nettype none
`timescale 1ns / 1ps

module matrix_compiler_tb;
    logic clk;
    logic rst;

    logic valid_data_in;
    logic [4:0] row_addr;
    logic [4:0] col_addr;
    logic [7:0] matrix_element;
    
    logic [1:0] dibit;
    logic valid_data_out;


    matrix_compiler#() uut(
        .inter_refclk(clk),
        .eth_refclk(clk),
        .rst(rst),

        .valid_data_in(valid_data_in),
        .row_addr(row_addr),
        .col_addr(col_addr),
        .matrix_element(matrix_element),

        .dibit(dibit),
        .valid_data_out(valid_data_out));

    
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
        //MATRIX A
        for(int i = 0; i<32; i=i+1) begin
            //ROW
            for(int j = 0; j <32; j = j+1) begin
                //ELEMENT CREATION
                valid_data_in = 1'b1;
                matrix_element = (i==j)? 8'b10101010: 8'b1111_0000;
                row_addr = i;
                col_addr = j;
                #20;
                end
        end
        // //MATRIX OUTPUT
        // for(int i = 0; i<32; i=i+1) begin
        //     //ROW
        //     if (i%2 == 0) begin
        //         for(int j = 31; j >= 0; j = j-1) begin
        //             //ELEMENT CREATION
        //             valid_data_in = 1'b1;
        //             row_addr = j;
        //             col_addr = i;
        //             matrix_element = ((i&j)==0)? 8'b1111_1111:{i,j};
        //             #20;
        //         end
        //     end
        // end
        // for(int i = 0; i<32; i=i+1) begin
        //     //ROW
        //     if (i%2 == 1'b1) begin
        //         for(int j = 31; j > -1; j = j-1) begin
        //             //ELEMENT CREATION
        //             valid_data_in = 1'b1;
        //             row_addr = j;
        //             col_addr = i;
        //             matrix_element = ((i&j)==0)? 8'b1111_1111:{i,j};
        //             #20;
        //         end
        //     end
        // end

        valid_data_in = 0;
        #20
        //REST
        for (int i = 0; i<1026*4; i = i+1) begin
            #20;
        end
    

    $display("Finishing Sim");
    $finish;
    end

endmodule

`default_nettype wire
