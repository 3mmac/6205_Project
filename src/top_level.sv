`default_nettype none
`timescale 1ns / 1ps

module top_level(
    input wire clk_100mhz,
    input wire btnc,
    input wire eth_crsdv,
    input wire [1:0] eth_rxd,

    output logic eth_refclk,
    output logic eth_rstn,
    output logic [15:0] led,
    output logic ca, cb, cc, cd, ce, cf, cg,
    output logic [7:0] an
    );

    logic [1:0] axiod_eth;
    logic axiov_eth;
    logic prev_axiov_eth;

    logic [1:0] axiod_bit;
    logic axiov_bit;

    logic [1:0] axiod_fire;
    logic axiov_fire;

    logic [31:0] axiod_agg;
    logic axiov_agg;

    logic kill_out;
    logic done_out;

    logic [15:0] counter;

    logic established;
    logic [31:0] val_in;

    assign eth_rstn = ~btnc;
    assign led[13:0] = counter;
    assign led[15] = kill_out;
    assign led[14] = done_out

    //divide
    //ether my_ether(.clk(eth_refclk), .rst(btnc), .crsdv(eth_crsdv),.rxd(eth_rxd),.axiov(axiov_eth),.axiod(axiod_eth));
    //bitorder my_bitorder (.clk(eth_refclk), .rst(btnc), .axiiv(axiov_eth), .axiid(axiod_eth), .axiov(axiov_bit), .axiod(axiod_bit));
    //firewall my_firewall (.clk(eth_refclk),.rst(btnc),.axiiv(axiov_bit),.axiid(axiod_bit),.axiov(axiov_fire),.axiod(axiod_fire));
    //cksum my_cksum (.clk(eth_refclk), .rst(btnc), .axiiv(axiov_eth), .axiid(axiod_eth), .done(done_out), .kill(kill_out));
    
    //aggregate my_aggregate (.clk(eth_refclk), .rst(btnc), .axiiv(axiov_fire), .axiid(axiod_fire), .axiov(axiov_agg), .axiod(axiod_agg));
    //seven_segment_controller#(.COUNT_TO('d100_000)) my_ssc (.clk_in(eth_refclk), .rst_in(btnc), .val_in(val_in), .cat_out({cg, cf, ce, cd, cc, cb, ca}), .an_out(an)); 
    
    //divide
    //divider my_divider(.clk)
    //matrix_loader
    
    //algo_holder
    
    //matrix_compiler
    //bitorder_out
    //ether_out


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

        //val_in <= (axiov_agg)? axiod_agg: ((val_in)? val_in: 0);
    end

endmodule

`default_nettype wire