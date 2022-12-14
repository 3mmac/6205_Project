`default_nettype none
`timescale 1ns / 1ps

module iter_parallel #(parameter ROW_SIZE=3)
  (input wire [ROW_SIZE-1:0][7:0] row1,
  input wire [ROW_SIZE-1:0][7:0] col2,
  input wire axiiv,
  input wire clk,
  input wire rst,

  output logic axiov,
  output logic [7:0] axiod);

  logic [5:0] count;
  logic [7:0] sum;
  logic [1:0] iter_state;

  logic [ROW_SIZE-1:0][7:0] row_buff;
  logic [ROW_SIZE:0][7:0] col_buff;

  logic [7:0] el1;
  logic [7:0] el2;
  logic [ROW_SIZE-1:0][7:0] prods;

  logic [ROW_SIZE-1:0][7:0] sums;

  always_ff @(posedge clk) begin
    if(rst) begin
      axiov <= 0;
      count <= 0;
      iter_state <= 0;
    end else begin
      if(iter_state == 0) begin
        if(axiiv) begin
	  row_buff <= row1;
	  col_buff <= col2;
	  iter_state <= 1;
	end
      end else if (iter_state == 1) begin
	for(int i=0; i<ROW_SIZE; i++) begin
          prods[i] <= row_buff[i]*col_buff[i];
        end
	iter_state <= 2;
      end else if (iter_state ==2) begin
	axiov <= 1;
	iter_state <= 3;
      end else begin
	axiov <= 0;
	count <= 0;
	iter_state <= 0;
      end
    end
  end
  
  always @(*) begin
    sums[0] = prods[0];
    for(int j=1; j<ROW_SIZE; j++) begin
      sums[j] = sums[j-1]+prods[j];
    end
  end
  assign axiod = sums[ROW_SIZE-1];
 
endmodule

`default_nettype wire


