`default_nettype none
`timescale 1ns / 1ps

module tb_iter_control;
  logic clk;
  logic rst;

  logic [31:0][7:0] row1;
  logic [31:0][7:0] col2;
  logic val_rows;

  logic val_out;
  logic [7:0] mat_out;
  
  logic complete;
  logic [5:0] row_in;
  logic [5:0] col_in;
  logic [5:0] row_req;
  logic [5:0] col_req;
  logic [5:0] row_out;
  logic [5:0] col_out;
 
  logic new_request;
  logic done;

  iter_control test_iter_control(.clk_in(clk), .rst_in(rst), .matA_row(row1), .matB_col(col2), .val_rows(val_rows),
				 .row_in(row_in), .col_in(col_in), .row_req(row_req), .col_req(col_req), .new_request(new_request), 
				 .row_out(row_out), .col_out(col_out), .matrix_val(mat_out),
			         .complete(complete), .done(done), .valid_out(val_out));
  
  logic [31:0][31:0] mat1 [7:0];
  logic [31:0][31:0] mat2 [7:0];

  always begin
    #10;
    clk = !clk;
  end

  initial begin
        $dumpfile("iter_control.vcd"); //file to store value change dump (vcd)
        $dumpvars(0,tb_iter_control); //store everything at the current level and below
        $display("Starting Sim"); //print nice message
        clk = 0; //initialize clk (super important)
        rst = 0; //initialize rst (super important)
        complete = 0;
	mat1[0] = {8'h1, 8'h1, 8'h1};
	mat1[1] = {8'h2, 8'h2, 8'h2};
	mat1[2] = {8'h3, 8'h3, 8'h3};
                                      
        mat2[0] = {8'h1, 8'h0, 8'h0};
        mat2[1] = {8'h0, 8'h1, 8'h0};
        mat2[2] = {8'h0, 8'h0, 8'h1}; 

        #30  //wait a little bit of time at beginning
        rst = 1; //reset system
        #20; //hold high for a few clock cycles
        rst = 0;
        #20;

	complete = 1;
	#20;
	complete = 0;
	#60

	while(~done) begin
	  if(new_request) begin
	    row_in <= row_req;
	    col_in <= col_req;
	    row1 <= {8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1};
	    col2 <= {8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1,8'h1};
	    val_rows <= 1;
	    #20;
	    val_rows <= 0;
	  end
	  #20;  
	end
	val_rows = 0;
        #200
	
	$display("Finishing Sim"); //print nice message
        $finish;
  end

endmodule  	   

`default_nettype wire


