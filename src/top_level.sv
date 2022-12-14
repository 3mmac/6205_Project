`default_nettype none
`timescale 1ns / 1ps

module top_level(
                    input wire clk_100mhz,
                    input wire btnc,
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
    assign led[13:0] = counter;
    assign led[15] = kill_out;
    assign led[14] = done_out;



    clk_wiz_0 my_divider (.clk_100mhz(clk_100mhz),.eth_refclk(eth_refclk),.inter_refclk(inter_refclk));

    ether my_ether(.clk(eth_refclk), .rst(btnc), .crsdv(eth_crsdv),.rxd(eth_rxd),.axiov(axiov_eth),.axiod(axiod_eth));

    bitorder my_bitorder (.clk(eth_refclk), .rst(btnc), .axiiv(axiov_eth), .axiid(axiod_eth), .axiov(axiov_bit), .axiod(axiod_bit));
    firewall my_firewall (.clk(eth_refclk),.rst(btnc),.axiiv(axiov_bit),.axiid(axiod_bit),.axiov(axiov_fire),.axiod(axiod_fire));
    
    cksum my_cksum (.clk(eth_refclk), .rst(btnc), .axiiv(axiov_eth), .axiid(axiod_eth), .done(done_out), .kill(kill_out));
    
    aggregate #(.MAX_ELEMENT_SIZE(MAX_ELEMENT_SIZE), .MAX_ROW_SIZE_A(MAX_ROW_SIZE_A), .MAX_COL_SIZE_A(MAX_COL_SIZE_A)) 
                my_aggregate (.clk(eth_refclk), .rst(btnc), .axiiv(axiov_fire), .axiid(axiod_fire), .axiov(axiov_agg), .axiod(axiod_agg));
    //seven_segment_controller#(.COUNT_TO('d100_000)) my_ssc (.clk_in(eth_refclk), .rst_in(btnc), .val_in(val_in), .cat_out({cg, cf, ce, cd, cc, cb, ca}), .an_out(an)); 
    
    logic valid_out, complete;
    logic [$clog2(MAX_SIZE_A)-1:0] a_addr_out;
    logic [$clog2(MAX_SIZE_B)-1:0] b_addr_out;
    logic [MAX_SIZE_A*MAX_ELEMENT_SIZE-1:0] a_row_out;
    logic [MAX_SIZE_A*MAX_ELEMENT_SIZE-1:0] b_col_out;
    
    matrix_loader #(.MAX_ELEMENT_SIZE(MAX_ELEMENT_SIZE), .MAX_SIZE_A(MAX_SIZE_A), .MAX_SIZE_B(MAX_SIZE_B)) 
                my_loader (.inter_refclk(inter_refclk), .eth_refclk(eth_refclk),.rst(btnc), .axiiv(axiov_fire), .axiid(axiod_fire),
                            .valid_request(), .requested_a_row(), .requested_b_col(),
                            .valid_out(valid_out), .a_addr_out(a_addr_out), .b_addr_out(b_addr_out), .a_row_out(a_row_out), .b_col_out(b_col_out), .complete(complete));
    
    //algo_holder
    
    logic compile_done;
    logic [1:0] dibit;
    logic valid_data_out;

    matrix_compiler #(.MAX_ELEMENT_SIZE(MAX_ELEMENT_SIZE), .MAX_SIZE_A(MAX_SIZE_A), .MAX_SIZE_B(MAX_SIZE_B)) 
                my_compiler (.inter_refclk(inter_refclk), .eth_refclk(eth_refclk),.rst(btnc), 
                            .valid_data_in(), .row_addr(), .col_addr(), .matrix_element(), .data_request(eth_out_request), 
                            .compile_done(compile_done), .dibit(dibit), .valid_data_out(valid_data_out));
    logic [1:0] reordered_dibit;
    logic reordered_valid;

    bitorder_out my_bitorder_out (.clk(eth_refclk), .rst(btnc), .axiiv(valid_data_out), .axiid(dibit),
                                    .axiov(reordered_valid), .axiod(reordered_dibit));
    
    logic ether_out_request;

    ether_out my_ether_out (.clk(eth_refclk), .(rst), .axiiv(reordered_valid), .axiid(reordered_dibit), .preamble_signal(compile_done),
                            .axiov(eth_txen), .axiod(eth_txd), .data_request(eth_out_request))


   always_ff @(posedge eth_refclk) begin
       if(btnc) begin
           counter <= 0;
           val_in <= 0;
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