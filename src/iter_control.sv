`timescale 1ns / 1ps
`default_nettype none

module iter_control (
	input wire clk_in,
	input wire rst_in,
	input wire complete,
	input wire [31:0][7:0] matA_row,
        input wire [31:0][7:0] matB_col,
	input wire [5:0] row_in,
	input wire [5:0] col_in, 
	input wire val_rows,

	output logic [5:0] row_req,
	output logic [5:0] col_req,
	output logic new_request,

	output logic [5:0] row_out,
	output logic [5:0] col_out,
	output logic [7:0] matrix_val,
	output logic valid_out,
	output logic done
	);

	logic [5:0] addr_row;
	logic [5:0] addr_col;

	logic [31:0][7:0] row_store;
	logic [31:0][7:0] col_store;


	logic complete_old;

	logic [1:0] control_state;

	logic val_out;
	logic compute_val;
	logic [7:0] element_out;


	iter_parallel dot_prod (
		.row1(row_store),
		.col2(col_store),
		.axiiv(compute_val),
		.clk(clk_in),
		.rst(rst_in),
		.axiov(val_out),
		.axiod(element_out));

	always_ff @(posedge clk_in) begin
	  complete_old <= complete;
	  if(rst_in) begin
	    addr_row <= 0;
	    addr_col <= 0;
	    row_out <= 0;
	    col_out <= 0;
	    row_req <= 0;
	    col_req <= 0;
	    done <= 0;
	    matrix_val <= 0;
	    valid_out <= 0;
	    control_state <= 0;
	  end
	  else begin
	    if(control_state==0 && !complete_old && complete) begin
	      control_state <= 1;
	      row_req <=0;
	      col_req <= 0;
	      new_request <= 1;
	    end else if (control_state==1) begin
	      valid_out <= 0;
	      if(val_rows) begin
	        control_state <= 2;
		compute_val <= 1;
		addr_row <= row_in;
		addr_col <= col_in;
		row_store <= matA_row;
		col_store <= matB_col;
		new_request <= 0;
	      end
	    end else if (control_state == 2) begin
	      compute_val <= 0;
	      if(val_out) begin
		matrix_val <= element_out;
	        valid_out <= 1;
		row_out <= addr_row;
		col_out <= addr_col;
		
		if(addr_col >= 31) begin
		  if(addr_row >= 31) begin
		    done <= 1;
		    control_state <= 0;
		  end else begin
		    row_req <= addr_row+1;
		    col_req <= 0;
		    new_request <= 1;
		    control_state <= 1;
		  end
		end else begin
		  row_req <= addr_row;
		  col_req <= addr_col + 1;
		  new_request <= 1;
		  control_state <= 1;
		end
	      end
	    end 
	  end
	end
	


endmodule

`default_nettype wire
