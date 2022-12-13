`default_nettype none
`timescale 1ns / 1ps

module tb_iterative;
  logic clk;
  logic rst;

  logic [2:0][7:0] row1;
  logic [2:0][7:0] col2;
  logic axiiv;

  logic axiov;
  logic [15:0] axiod;
  
  logic [2:0][2:0] mat1 [7:0];
  logic [2:0][2:0] mat2 [7:0];

  //iterative  test_iterative(.clk(clk), .rst(rst), .row1(row1), .col2(col2), .axiiv(axiiv), .axiod(axiod), .axiov(axiov));

  iter_parallel test_iter_par(.clk(clk), .rst(rst), .row1(row1), .col2(col2), .axiiv(axiiv), .axiod(axiod), .axiov(axiov));
  always begin
    #10;
    clk = !clk;
  end

  initial begin
        $dumpfile("iter_par.vcd"); //file to store value change dump (vcd)
        $dumpvars(0,tb_iterative); //store everything at the current level and below
        $display("Starting Sim"); //print nice message
        clk = 0; //initialize clk (super important)
        rst = 0; //initialize rst (super important)
  	mat1[0] = {8'h1, 8'h1, 8'h1};
	mat1[1] = {8'h1, 8'h1, 8'h1};
	mat1[2] = {8'h1, 8'h1, 8'h1};

	mat2[0] = {8'h1, 8'h1, 8'h1};
	mat2[1] = {8'h1, 8'h1, 8'h1};
	mat2[2] = {8'h1, 8'h1, 8'h1};

        #30  //wait a little bit of time at beginning
        rst = 1; //reset system
        #20; //hold high for a few clock cycles
        rst = 0;
        #20;

	for (int i = 0; i<3; i= i+1)begin
	  for(int j=0; j<3; j=j+1) begin
	    row1[0] = mat1[i][0];
	    row1[1] = mat1[i][1];
	    row1[2] = mat1[i][2];
	    col2[0] = mat2[j][0];
	    col2[1] = mat2[j][1];
	    col2[2] = mat2[j][2];
	    axiiv = 1;
	    #20;
	  end
	end
	axiiv = 0;
	#200

	rst = 1;
	#20;
	rst = 0;
	#20

	#20;
	row1 = {8'h1, 8'h2, 8'h3};
	col2 = {8'h1, 8'h2, 8'h3};
	axiiv = 1;
	#20;
        axiiv = 0;
        #200
	
	$display("Finishing Sim"); //print nice message
        $finish;
  end

endmodule  	   

`default_nettype wire
