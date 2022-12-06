// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
// Date        : Mon Dec  5 21:41:08 2022
// Host        : EECS-DIGITAL-28 running 64-bit Ubuntu 20.04.5 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clka,
    ena,
    wea,
    addra,
    dina,
    clkb,
    enb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [7:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [7:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;

  wire [7:0]addra;
  wire [7:0]addrb;
  wire clka;
  wire clkb;
  wire [31:0]dina;
  wire [31:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_douta_UNCONNECTED;
  wire [7:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "8" *) 
  (* C_ADDRB_WIDTH = "8" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     3.68295 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "256" *) 
  (* C_READ_DEPTH_B = "256" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "256" *) 
  (* C_WRITE_DEPTH_B = "256" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[31:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[7:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[7:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
RgPKnWr9n0dGgttm3akiFhAlfB96usOQYxnEmPhGyTGg1AbizYAjGPWLXBWl50n/d0IA71ci4aJB
wt6mtfyNADm3ZReK7D3mKu037BOgxryoEwwf1kiC6q/PllxsdAgEMfQrfHJ3E2AzSpdYjoxVYito
y0JW6CUDcWvWa4WV0EA=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
M0l6KpOGH3jL8eRt3NCD7e2USYnkg5H9GAnE1PKmnjiouFN3Y8kjWA2PZDAQLm9UW+TsC1HeVlzO
WjNCHkjR/6ubCsIcWfpPZWdIuAenlsyq8Y9l6b8vMj8JSbDEOiFF/GHSbKsn22MJdDJKEhHFK6GV
s8gR2vywRFwG69gIRE4qGhVB+WIg8GJrDpDMYH6lCjMkTrjXuKDUcNlJN3NPLuhJ7tsditwf1pr5
moJRmGpJnip/rGm0g4o4A6ev4CtePjoao8C1wFtzHkERX9oenhh7cGjDMejU5IrLv8NxFnLj1FpB
9MuF1beTU20NI5oAn6zLiLiOtXjf0ghU3AN4DA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
hAsrUfp6Qgjm8yBjNYTEtQmVQmMxzL8TE/3oiQSxSI3+yEkXAbQCXkT9mo+LCdv+fGECOB0istHd
eLtbsiYbxjxNxYkXiUrRE5O+aSxynIray+uF9DJigTEUZu8JJXUbzxK4DDUu1Lm9tpGps4+Prz1m
0gkj13RT/Y/418s2VTw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BP/54Wm/GJmb1jy0bxWJJX4aiKyiWPVh4X3VL30BQrmX4PlEsNKzBJH3Qu8IIYERfnFP0ifAgboa
vypMQ5Ed0BrMePGkWIgT6I8hxJCMFpHdkSK7m1giSKyZzFfTOrVqoNFXE+qdzLfY1J5hBWCvouYo
jllavK4N3gF9FLScH2AUWYVMcVth2QPaTAU2NLnAUNH8kgtBjBfc8/KbPPTznD1QNVqvFstzcbTA
hGQ1ETVPvINQ0KqxxAG5PRhtQD4+pC+hr/Tvk+RSvGyBOfy9zE86OXkJiYs9dSFhNiMFmCPL9DBO
se4OxNNC0/7aBtb1mkSEA9YFDYEb9jS7Jasy2A==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
SnzT9DVH3xlEN8nrr2YrlvTO5qj7L22d7WaBcuKyTaiHoIwwFHrC4HQbfs0TAwkdWcOgmJoATPSF
F6qm0KiddbrlERF3MfKUldeGBJtqLdX+zGw7+3JD7S+HB9dIMOFOHy+IiCZp1/Pz8epKpi238cel
rcVoJQKz406wmXDvOo8KsT+XhRLs9BVCrBErPGGXKYDk6NXAp0duOgQE9DbslzMU83M/kUC7uERV
tQW02240peKQFp2elEZC7Tetvgp0TaFTtJiKN45REi8GQUCKGa85JjNIk1qb/+k95TIIP1xrHirc
6iX7qbwnPetv8TVu2NjkZ0WDEK5RXdOXcxBwHA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
erkR82V0jX8ytva+9MzEs0c75Z7j7TsgxWRLNAUfbbU28i+U9YzuZlSfYU75M0f9jx1gvxtBrfKv
cNHVdkR+i5zfHDZsDwfMEEBhs8wzDCKqe+eex6BBEvlIOesCPXrr2RozQgaQ1PBh/os2Arfu+873
BjsVxFJkbhpzIqlddOo/XZV9Yi+eih7A7pXXEBR6IL7Poo4Ka49MiVQU0xJrDTm+ddOuMPDRRD7g
dsxS/uzdcBcO2myV6g/7YH/C2Ce9s6+UywJN/0JeXSqwA7bsBqqnfFicVAT0lckLopMLiuzK7dsN
EwhFeqoetciFrDIj9+o0xDMWBZhgNP1u68vURA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
R+BI65BKLT0I9hEtsxGnDyM5XY9gzULeTPOSDXvd3KWOzZJAx6C0xlbyZcFZhAEG/QIK2yd0wAi6
IUWxyF/sx3HsqKjhVi5KxnpuXDBOZVoj811O7JukedFVmDW7OHGtBkuiJ5X5irw7mfsEKRQmF/1i
V6lj9HYHZEjxtDeZjACsLY4y1QxWalSKT4HIMOHznBLL8dLbGMlS+ZmFuFn0gcwZavVl7gTkTtkf
W0gn01A9ru7NKsf+iLX0kj4dgItPu9N2g02M1vWQ9UUQEVvfV7lUc7GY1suibrD8aEkhH9S7lZ7n
bFsT4qxyvzg8ML6v4g4v7N6VuyhEtgFgNd725Q==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
jNUVKiwH68vHsU54idgvKwaVJcoxTUuxfgrQpbpmM/IpesWA3wHsGzYClwAxkKzw3KRnFyQqTWcZ
yj1EQ2CMBxlJ0kyNbZW8OK8pXzeigToZ0U6Aq3Gy+j7wBbhe83wE1Ygn82sK8dHTEulvaRLn/c5r
ispy1s7jMKIvYNzoUuZrgyBQyfaYmdqUia8XlQjFd+VwzhTXKwzvmaqHWyaHjfBKeCooO7+oUxMG
OJg83W54EVe9ronFQ8Wr9EOL8ia7qelCAgyQe/bC0HHCoMAm8apI7sX23iMR/wMiPP5V2bQzycy+
rBX/+SWkqSeIE1FLm+muFPvrE7iLwJaW8d1fzdFFjAZ5aIXArbWNfwbK8S0TczXc9lEzmpb69rwA
UJIrs4alo81qGQ32UFhjuMQjX75O9Od1HWHDj5PFaT/Ja5Ly+bK8Cc3gfO6dCE81m7d+B2JBZ/Hl
tBA19QuOAYwT2EIPOdpaVtCULb33cWODWu3qQFhZMmDzKTb3kwpcr0LL

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MnzcA2swaxH1LRacKDou0ZmiiMRETbWIdHgeBgyQz7ILronsXLoB/C20WuFNGEVSiL2/51EZ6MXZ
vMHI8fFcMQCJcuTBDBibUMKv6bXI9s8fTbtrBZppbF/R1icG5JYhqmX4aRnv4W/dxJRjI2L35nLN
Y48E9OfgfkD1sr+IRwx8WEKFmUhuk8dLe0VOK7ywe3XEcneYvrz+HhPj16bGmNfMwNnDgZ3gKKZD
hRnys+jzvAX3HyISrErWXhMKrhWMxXeTNFJCqNQ0LWAVHQYwyKnF5xVpyXSuGNSIrva+QXqOrZBG
3VNLirNVtMRiKLfwZeMaqvswkqBDAa53utlAAA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
d0xXkKtsKM8GvXhDZr16p1+oE3uBtD04BJ76eGGIEj/CFECfHVy9qsJ43oSKjas0+AJr4GFFnVb6
X7gJV6MmX/OboC9ier5joUCGz0mxVzkRZK9a+LPEDcg0K6+cLE36kr+FfxW9Uk2816EHBCMCf5mK
A4eAhSmAb5Nq74F/q0quiG416npbny7faiQ+xmPDfYYiM3UuMKaD4iE8ODlz1w5xThPllWESf3LZ
NTkw6fozyTqZ47vvE21O3dgIGAY1v+C6BwlCK24VwPJa1xs9csY+qTk31j5jjAc1ExlB6QF7t9UH
lk70qdNPWxT87OH7kFT8UvPO1D6BTC3/WkDZfA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
LYhdzKTvo93uJrAaiP5OfCDuOnu2BSvPnxlv6I7h2n1+xHtj34LNNKzWEgOg9dUV9cYDaHYUjjEt
DKdWcz6mZ61d5qyxAhpv67fc90v7JVgtOAcT94/Yb+AuLxXFcGA6Gic7uoJtUgz6JmTnb22Dxdjc
KuIewDj4IOTfP8XGXKTaF+cNp0CFrQgTAcVSQFyLFxr0I/9h3S+GZLecA7ntEeHEOfCJzPvy0ddi
7MCdQWECLb+fXC0IAn8V95TumcpINiRAX1BHi9IGJ4QoMrb3jOCrPkFhDMTJj2aiImUWdi/l/0QE
d7wcXlgIEYVeoKYUOJ4mqy+zZPUbLNeOPADUDQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20720)
`pragma protect data_block
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
T0svvyQA6nMVZoKPyILrvvP/dC9myMkfbk/ec3k=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
