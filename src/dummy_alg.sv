`timescale 1ns / 1ps
`default_nettype none

module dummy_alg (
	input wire clk_in,
	input wire rst_in,
	input wire complete,
	input wire [31:0][7:0] matA_row,
        input wire [31:0][7:0] matB_col,
	input wire [4:0] row_in,
	input wire [4:0] col_in, 
	input wire val_rows,

	output logic [4:0] row_req,
	output logic [4:0] col_req,
	output logic new_request,

	output logic [4:0] row_out,
	output logic [4:0] col_out,
	output logic [7:0] matrix_val,
	output logic valid_out,
	output logic done
	);


	logic complete_old;

	logic [1:0] control_state;

	always_ff @(posedge clk_in) begin
	  complete_old <= complete;
	  if(rst_in) begin
	    row_out <= 0;
	    col_out <= 0;
	    row_req <= 0;
	    col_req <= 0;
	    done <= 0;
	    matrix_val <= 0;
	    valid_out <= 0;
	    control_state <= 0;
	  end else begin
	    if(control_state==0 && !complete_old && complete) begin
	      control_state <= 1;
	      row_req <=0;
	      col_req <= 0;
	      new_request <= 1;
	      valid_out <= 0;
	    end else if (control_state==1) begin
	      if(val_rows) begin
		row_out <=  row_in;
		col_out <= col_in;
		matrix_val <= matA_row[col_in];
		valid_out <= 1;
		if(col_in >= 31) begin
		  if(row_in >= 31) begin
		    done <= 1;
		    control_state <= 0;
		  end else begin
		    row_req <= row_in + 1;
		    col_req <= 0;
		    new_request <= 1;
		  end
		end else begin
		  row_req <= row_in;
		  col_req <= col_in+1;
		  new_request <= 1;
		end
	      end
	    end
	  end
	end
	   	


endmodule

`default_nettype wire

