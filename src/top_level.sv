`default_nettype none
`timescale 1ns / 1ps

module top_level(
                    input wire clk_100mhz,
                    input wire btnc,
                    input wire btnu,
                    input wire eth_crsdv,
                    input wire [1:0] eth_rxd,

                    output logic eth_refclk,
                    output logic eth_rstn,
                    output logic eth_txen,
                    output logic [1:0] eth_txd,
                    output logic [15:0] led,
                    output logic ca, cb, cc, cd, ce, cf, cg,
                    output logic [7:0] an
    );
    
    parameter MAX_ELEMENT_SIZE = 8;
    parameter MAX_ROW_SIZE_A = 32;
    parameter MAX_COL_SIZE_A = 32;
    parameter MAX_ROW_SIZE_B = 32;
    parameter MAX_COL_SIZE_B = 32;
    parameter MAX_SIZE_A = 32;
    parameter MAX_SIZE_B = 32;

    logic inter_refclk;
    
    logic [1:0] axiod_eth;
    logic axiov_eth;
    logic prev_axiov_eth;

    logic [1:0] axiod_bit;
    logic axiov_bit;

    logic [1:0] axiod_fire;
    logic axiov_fire;

    logic [MAX_ELEMENT_SIZE+$clog2(MAX_ROW_SIZE_A)+$clog2(MAX_COL_SIZE_B)-1:0] axiod_agg;
    logic axiov_agg;

    logic kill_out;
    logic done_out;
   
    logic [15:0] counter;

    logic established;
    logic [31:0] val_in;

    assign eth_rstn = ~btnc;
    //assign led[13:0] = counter;
    assign led[15] = kill_out;
    assign led[14] = done_out;



    clk_wiz_0_clk_wiz my_divider (.clk_100mhz(clk_100mhz),.eth_refclk(eth_refclk),.inter_refclk(inter_refclk));

    ether my_ether(.clk(eth_refclk), .rst(btnc), .crsdv(eth_crsdv),.rxd(eth_rxd),.axiov(axiov_eth),.axiod(axiod_eth),.led(led[0]));

    bitorder my_bitorder (.clk(eth_refclk), .rst(btnc), .axiiv(axiov_eth), .axiid(axiod_eth), .axiov(axiov_bit), .axiod(axiod_bit), .led(led[1]));
    firewall my_firewall (.clk(eth_refclk),.rst(btnc),.axiiv(axiov_bit),.axiid(axiod_bit),.axiov(axiov_fire),.axiod(axiod_fire), .led(led[2]));
    
    cksum my_cksum (.clk(eth_refclk), .rst(btnc), .axiiv(axiov_eth), .axiid(axiod_eth), .done(done_out), .kill(kill_out),.led(led[3]));
    
    // //aggregate #(.MAX_ELEMENT_SIZE(MAX_ELEMENT_SIZE), .MAX_ROW_SIZE_A(MAX_ROW_SIZE_A), .MAX_COL_SIZE_A(MAX_COL_SIZE_A)) 
    // //            my_aggregate (.clk(eth_refclk), .rst(btnc), .axiiv(axiov_fire), .axiid(axiod_fire), .axiov(axiov_agg), .axiod(axiod_agg));
    
    logic valid_rows, complete;
    logic [$clog2(MAX_SIZE_A)-1:0] a_addr_out;
    logic [$clog2(MAX_SIZE_B)-1:0] b_addr_out;
    logic [MAX_SIZE_A*MAX_ELEMENT_SIZE-1:0] a_row_out;
    logic [MAX_SIZE_A*MAX_ELEMENT_SIZE-1:0] b_col_out;
    logic [$clog2(MAX_SIZE_A)-1:0] a_request;
    logic [$clog2(MAX_SIZE_B)-1:0] b_request;
    logic valid_request;

    
    matrix_loader #(.MAX_ELEMENT_SIZE(MAX_ELEMENT_SIZE), .MAX_SIZE_A(MAX_SIZE_A), .MAX_SIZE_B(MAX_SIZE_B)) 
                my_loader (.inter_refclk(inter_refclk), .eth_refclk(eth_refclk),.rst(btnc), .axiiv(axiov_fire), .axiid(axiod_fire),
                            .valid_request(valid_request), .requested_a_row(a_request), .requested_b_col(b_request), .led(led[4]),
                            .valid_out(valid_rows), .a_addr_out(a_addr_out), .b_addr_out(b_addr_out), .a_row_out(a_row_out), .b_col_out(b_col_out), .complete(complete));
    
    logic [7:0] output_element;
    logic [4:0] alg_row;
    logic [4:0] alg_col;
    logic alg_val;
    logic done;

    //dummy_alg test_dummy(
    // 	.clk_in(inter_refclk),
    //	.rst_in(btnc),
    //	.complete(complete),
    //	.matA_row(a_row_out),
    //	.matB_col(b_col_out),
    //	.row_in (a_addr_out),
    //	.col_in (b_addr_out),
    //	.val_rows(valid_rows),

    //  	.new_request(valid_request),
    //	.row_req(a_request),
    //	.col_req(b_request),

    //	.matrix_val(output_element),
    //	.row_out(alg_row),
    //	.col_out(alg_col),
    //	.valid_out(alg_val),
    //	.done(done),
    //  .led(led[5]));

    iter_control iter_alg(
     	.clk_in(inter_refclk),
  	.rst_in(btnc),
  	.complete(complete),
  	.matA_row(a_row_out),
  	.matB_col(b_col_out),
  	.row_in (a_addr_out),
  	.col_in (b_addr_out),
  	.val_rows(valid_rows),

  	.new_request(valid_request),
  	.row_req(a_request),
  	.col_req(b_request),

  	.matrix_val(output_element),
  	.row_out(alg_row),
  	.col_out(alg_col),
  	.valid_out(alg_val),
  	.done(done));
    
    logic compile_done;
    logic [7:0] byte_out;
    logic valid_data_out;

    matrix_compiler #(.MAX_ELEMENT_SIZE(MAX_ELEMENT_SIZE), .MAX_SIZE_A(MAX_SIZE_A), .MAX_SIZE_B(MAX_SIZE_B)) 
                my_compiler (.inter_refclk(inter_refclk), .eth_refclk(eth_refclk),.rst(btnc), 
                            .valid_data_in(alg_val), .row_addr(alg_row), .col_addr(alg_col), .matrix_element(output_element), 
                            .data_request(eth_out_request), .compile_done(compile_done), .byte_out(byte_out), .valid_data_out(valid_data_out),
                            .led(led[6]));
    
    logic [1:0] reordered_dibit;
    logic reordered_valid, eth_out_request;

    bitorder_out my_bitorder_out (.clk(eth_refclk), .rst(btnc), .axiiv(valid_data_out), .axiid(byte_out),
                                    .axiov(reordered_valid), .axiod(reordered_dibit), .led(led[7]));


    //ether_out my_ether_out (.clk(eth_refclk), .rst(btnu), .axiiv(reordered_valid), .axiid(reordered_dibit), .preamble_signal(compile_done),
    //                        .axiov(eth_txen), .axiod(eth_txd), .data_request(eth_out_request), .led(led[8]));

   logic [31:0] seven_seg_val;
   seven_segment_controller my_seven_seg(.clk_in(inter_refclk), .rst_in(btnc), .val_in(seven_seg_val), .cat_out({cg, cf, ce, cd, cc, cb, ca}), .an_out(an));
					 

   logic [MAX_SIZE_A-1:0][MAX_SIZE_B-1:0][MAX_ELEMENT_SIZE-1:0] out_array;
   logic [4:0] disp_row;
   logic [4:0] disp_col;
   logic [MAX_ELEMENT_SIZE-1:0] disp_val;

   always_comb begin
     disp_val = out_array[disp_row][disp_col];
     seven_seg_val[31:24] = disp_row;
     seven_seg_val[23:16] = disp_col;
     seven_seg_val[7:0] = disp_val; 
   end

   always_ff @(posedge eth_refclk) begin
       if(btnc) begin
           counter <= 0;
           val_in <= 0;
       end

       if(btnu) begin
	   if(disp_col >= MAX_SIZE_B-1) begin
	     disp_col <= 0;
	     if(disp_row >= MAX_SIZE_A-1) begin
		disp_row <= 0;
	     end else begin
		disp_row <= disp_row+1;
	     end
	   end else begin
	     disp_col <= disp_col+1;
	   end
       end

       if(alg_val) begin
         out_array[alg_row][alg_col] <= alg_val;
       end

       if ((prev_axiov_eth == 1'b1) & (axiov_eth == 0)) begin
           counter <= counter + 1'b1;
       end
       prev_axiov_eth <= axiov_eth;

       if(axiov_agg) val_in <= axiod_agg;

       val_in <= (axiov_agg)? axiod_agg: ((val_in)? val_in: 0);
   end

endmodule

`default_nettype wire
