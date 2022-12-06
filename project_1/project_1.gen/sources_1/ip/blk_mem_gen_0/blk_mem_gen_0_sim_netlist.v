// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
// Date        : Mon Dec  5 21:41:09 2022
// Host        : EECS-DIGITAL-28 running 64-bit Ubuntu 20.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/builder/6205_Project/project_1/project_1.gen/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.1" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
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
  blk_mem_gen_0_blk_mem_gen_v8_4_5 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20704)
`pragma protect data_block
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
GOL/TUMc/eqpB5hilg==
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
