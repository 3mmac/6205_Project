`timescale 1ns / 1ps
`default_nettype none

module strassen (
	input wire clk_in,
	input wire rst_in,
	input wire complete,
	input wire [31:0][7:0] matA_row1,
	input wire [31:0][7:0] matA_row2,
        input wire [31:0][7:0] matB_col1,
	input wire [31:0][7:0] matB_col2,
	input wire [5:0] row1_in,
	input wire [5:0] row2_in,
	input wire [5:0] col1_in,
	input wire [5:0] col2_in, 
	input wire val_rows,

	output logic [5:0] row1_req,
	output logic [5:0] row2_req,
	output logic [5:0] col1_req,
	output logic [5:0] col2_req,
	output logic new_request,

	output logic [5:0] row_out,
	output logic [5:0] col_out,
	output logic [7:0] matrix_val,
	output logic valid_out,
	output logic done
	);

	logic [5:0] addr_row1;
	logic [5:0] addr_row2;
	logic [5:0] addr_col1;
	logic [5:0] addr_col2;

	logic [31:0][7:0] row1_store;
	logic [31:0][7:0] row2_store;
	logic [31:0][7:0] col1_store;
	logic [31:0][7:0] col2_store;

	logic [15:0][7:0] M1_row;
	logic [15:0][7:0] M1_col;
	logic [15:0][7:0] M2_row;
        logic [15:0][7:0] M2_col;
	logic [15:0][7:0] M3_row;
        logic [15:0][7:0] M3_col;
	logic [15:0][7:0] M4_row;
        logic [15:0][7:0] M4_col;
	logic [15:0][7:0] M5_row;
        logic [15:0][7:0] M5_col;
	logic [15:0][7:0] M6_row;
        logic [15:0][7:0] M6_col;
	logic [15:0][7:0] M7_row;
        logic [15:0][7:0] M7_col;

	

	logic complete_old;

	logic [1:0] control_state;

	logic val_out_M1;
	logic val_out_M2;
	logic val_out_M3;
	logic val_out_M4;
	logic val_out_M5;
	logic val_out_M6;
	logic val_out_M7;

	logic compute_val;

	logic [7:0] M1_out;
	logic [7:0] M2_out;
	logic [7:0] M3_out;
	logic [7:0] M4_out;
	logic [7:0] M5_out;
	logic [7:0] M6_out;
	logic [7:0] M7_out;

	logic [2:0] M_count;
	logic [6:0][7:0] c_vals;

	iter_parallel M1 (
		.row1(M1_row),
		.col2(M1_col),
		.axiiv(compute_val),
		.clk(clk_in),
		.rst(rst_in),
		.axiov(val_out_M1),
		.axiod(M1_out));

	iter_parallel M2 (
                .row1(M2_row),
                .col2(M2_col),
                .axiiv(compute_val),
                .clk(clk_in),
                .rst(rst_in),
                .axiov(val_out_M2),
                .axiod(M2_out));

	iter_parallel M3 (
                .row1(M3_row),
                .col2(M3_col),
                .axiiv(compute_val),
                .clk(clk_in),
                .rst(rst_in),
                .axiov(val_out_M3),
                .axiod(M3_out));

	iter_parallel M4 (
                .row1(M4_row),
                .col2(M4_col),
                .axiiv(compute_val),
                .clk(clk_in),
                .rst(rst_in),
                .axiov(val_out_M4),
                .axiod(M4_out));

	iter_parallel M5 (
                .row1(M5_row),
                .col2(M5_col),
                .axiiv(compute_val),
                .clk(clk_in),
                .rst(rst_in),
                .axiov(val_out_M5),
                .axiod(M5_out));

	iter_parallel M6 (
                .row1(M6_row),
                .col2(M6_col),
                .axiiv(compute_val),
                .clk(clk_in),
                .rst(rst_in),
                .axiov(val_out_M6),
                .axiod(M6_out));

	iter_parallel M7 (
                .row1(M7_row),
                .col2(M7_col),
                .axiiv(compute_val),
                .clk(clk_in),
                .rst(rst_in),
                .axiov(val_out_M7),
                .axiod(M7_out));

	always_comb begin
	  M1_row = row1_store[31:16]+row2_store[15:0];
	  M1_col = col1_store[31:16]+col2_store[15:0];

	  M2_row = row2_store[31:16]+row2_store[15:0];
	  M2_col = col1_store[31:16];

	  M3_row = row1_store[31:16];
	  M3_col = col1_store[15:0]-col2_store[15:0];

	  M4_row = row2_store[15:0];
	  M4_col = col2_store[31:16]-col1_store[31:16];

	  M5_row = row1_store[31:16]+row1_store[15:0];
	  M5_col = col2_store[15:0];

	  M6_row = row2_store[31:16]-row1_store[31:16];
	  M6_col = col1_store[31:16]+col1_store[15:0];

	  M7_row = row1_store[15:0]-row2_store[15:0];
	  M7_col = col2_store[31:16]+col2_store[15:0];
	end	

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
		addr_row1 <= row1_in;
		addr_row2 <= row2_in;
		addr_col1 <= col1_in;
		addr_col2 <= col2_in;
		row1_store <= matA_row1;
		row2_store <= matA_row2;
		col1_store <= matB_col1;
		col2_store <= matA_col2;
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

