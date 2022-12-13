`default_nettype none
`timescale 1ns / 1ps

module iterative (
  input wire [31:0][7:0] row1,
  input wire [31:0][7:0] col2,
  input wire axiiv,
  input wire clk,
  input wire rst,

  output logic axiov,
  output logic [7:0] axiod);

  logic [5:0] count;
  logic [7:0] sum;
  logic [1:0] iter_state;

  logic [31:0][7:0] row_buff;
  logic [31:0][7:0] col_buff;


  always_ff @(posedge clk) begin
    if(rst) begin
      axiov <= 0;
      count <= 0;
      sum <= 0;
      iter_state <= 0;
    end else begin
      if(iter_state == 0) begin
        if(axiiv) begin
	  row_buff <= row1;
	  col_buff <= col2;
	  iter_state <= 1;
	end
      end else if (iter_state == 1) begin
	if(count < 32) begin
	  sum <= sum+row_buff[count]*col_buff[count];
          count <= count+1;
	end else begin
	  axiov <= 1;
	  iter_state <= 2;
	end
      end else begin
	axiov <= 0;
	count <= 0;
	iter_state <= 0;
	sum <= 0;
      end
    end
  end
 
  assign axiod = sum;  
endmodule

`default_nettype wire
