// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
// Date        : Mon Dec  5 21:50:11 2022
// Host        : EECS-DIGITAL-28 running 64-bit Ubuntu 20.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/builder/6205_Project/project_1/project_1.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(eth_refclk, inter_refclk, reset, locked, 
  clk_100mhz)
/* synthesis syn_black_box black_box_pad_pin="eth_refclk,inter_refclk,reset,locked,clk_100mhz" */;
  output eth_refclk;
  output inter_refclk;
  input reset;
  output locked;
  input clk_100mhz;
endmodule
