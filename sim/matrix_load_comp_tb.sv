`default_nettype none
`timescale 1ns / 1ps

module matrix_load_comp_tb;
    logic clk;
    logic rst;

    logic axiiv;
    logic [1:0] axiid;
    logic valid_request;
    logic [4:0] requested_a_row;
    logic [4:0] requested_b_col;
    
    logic valid_rows;
    logic [4:0] a_addr_out;
    logic [4:0] b_addr_out;
    logic [255:0] a_row_out;
    logic [255:0] b_col_out;
    logic complete;


    matrix_loader#() uut(
        .inter_refclk(clk),
        .eth_refclk(clk),
        .rst(rst),

        .axiiv(axiiv),
        .axiid(axiid),
	.valid_request(valid_request),
        .requested_a_row(requested_a_row),
        .requested_b_col(requested_b_col),

	.valid_out(valid_rows),
        .a_addr_out(a_addr_out),
        .b_addr_out(b_addr_out),
        .a_row_out(a_row_out),
        .b_col_out(b_col_out),
        .complete(complete));

    logic [7:0] output_element;
    logic [4:0] alg_row;
    logic [4:0] alg_col;
    logic alg_val;
    logic done;

    dummy_alg test_dummy(
	.clk_in(clk),
	.rst_in(rst),
	.complete(complete),
	.matA_row(a_row_out),
	.matB_col(b_col_out),
	.row_in (a_addr_out),
	.col_in (b_addr_out),
	.val_rows(valid_rows),

	.new_request(valid_request),
	.row_req(requested_a_row),
	.col_req(requested_b_col),

	.matrix_val(output_element),
	.row_out(alg_row),
	.col_out(alg_col),
	.valid_out(alg_val),
	.done(done));

    logic [1:0] dibit;
    logic valid_data_out;
    logic data_request;

    matrix_compiler#() test_comp(
	.inter_refclk(clk),
        .eth_refclk(clk),
        .rst(rst),

        .valid_data_in(alg_val),
        .row_addr(alg_row),
        .col_addr(alg_col),
        .matrix_element(output_element),

        .dibit(dibit),
        .valid_data_out(valid_data_out),
        .data_request(data_request));    

    always begin
        #10;
        clk = !clk;         //Now #20 will wait a clock period
    end

    initial begin
        $dumpfile("matrix_load_comp.vcd");
        $dumpvars(0, matrix_load_comp_tb);
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
        //MATRIX B
        for(int a = 0; a<32; a=a+1) begin
            //ROW
            for(int b = 0; b <32; b = b+1) begin
                //ELEMENT CREATION
                for(int c = 0; c<4; c=c+1) begin
                    if(a==b)begin
                        axiiv = 1'b1;
                        axiid = 2'b11;
                    end else begin
                        axiid = 0;
                        axiiv = 1'b1;
                    end
                    #20;
                end
            end
        end
        axiid = 0;
        axiiv = 0;
        #20;
        //REST
  
	for(int t=0; t<5000; t++) begin
	  #20;
	end

    $display("Finishing Sim");
    $finish;
    end

endmodule

`default_nettype wire

