// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Wed Apr 29 14:00:54 2026
// Command     : write_verilog -mode funcsim axi_master.v
// Design      : axi_master
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tfgg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* DC_BLK_LEN = "4" *) (* DC_BLK_SIZE = "128" *) (* IC_BLK_LEN = "8" *) 
(* IC_BLK_SIZE = "256" *) 
(* NotValidForBitStream *)
module axi_master
   (aclk,
    areset,
    ic_dev_rrdy,
    ic_cpu_ren,
    ic_cpu_raddr,
    ic_dev_rvalid,
    ic_dev_rdata,
    dc_dev_wrdy,
    dc_cpu_wen,
    dc_cpu_waddr,
    dc_cpu_wdata,
    dc_dev_rrdy,
    dc_cpu_ren,
    dc_cpu_raddr,
    dc_dev_rvalid,
    dc_dev_rdata,
    m_axi_awaddr,
    m_axi_awlen,
    m_axi_awsize,
    m_axi_awburst,
    m_axi_awvalid,
    m_axi_awready,
    m_axi_wdata,
    m_axi_wstrb,
    m_axi_wlast,
    m_axi_wvalid,
    m_axi_wready,
    m_axi_bready,
    m_axi_bresp,
    m_axi_bvalid,
    m_axi_araddr,
    m_axi_arlen,
    m_axi_arsize,
    m_axi_arburst,
    m_axi_arvalid,
    m_axi_arready,
    m_axi_rready,
    m_axi_rdata,
    m_axi_rresp,
    m_axi_rlast,
    m_axi_rvalid);
  input aclk;
  input areset;
  output ic_dev_rrdy;
  input ic_cpu_ren;
  input [31:0]ic_cpu_raddr;
  output ic_dev_rvalid;
  output [255:0]ic_dev_rdata;
  output dc_dev_wrdy;
  input [3:0]dc_cpu_wen;
  input [31:0]dc_cpu_waddr;
  input [31:0]dc_cpu_wdata;
  output dc_dev_rrdy;
  input dc_cpu_ren;
  input [31:0]dc_cpu_raddr;
  output dc_dev_rvalid;
  output [127:0]dc_dev_rdata;
  output [31:0]m_axi_awaddr;
  output [7:0]m_axi_awlen;
  output [2:0]m_axi_awsize;
  output [1:0]m_axi_awburst;
  output m_axi_awvalid;
  input m_axi_awready;
  output [31:0]m_axi_wdata;
  output [3:0]m_axi_wstrb;
  output m_axi_wlast;
  output m_axi_wvalid;
  input m_axi_wready;
  output m_axi_bready;
  input [1:0]m_axi_bresp;
  input m_axi_bvalid;
  output [31:0]m_axi_araddr;
  output [7:0]m_axi_arlen;
  output [2:0]m_axi_arsize;
  output [1:0]m_axi_arburst;
  output m_axi_arvalid;
  input m_axi_arready;
  output m_axi_rready;
  input [31:0]m_axi_rdata;
  input [1:0]m_axi_rresp;
  input m_axi_rlast;
  input m_axi_rvalid;

  wire aclk;
  wire aclk_IBUF;
  wire aclk_IBUF_BUFG;
  wire areset;
  wire areset_IBUF;
  wire [31:0]dc_cpu_raddr;
  wire [31:0]dc_cpu_raddr_IBUF;
  wire dc_cpu_ren;
  wire dc_cpu_ren_IBUF;
  wire [31:0]dc_cpu_waddr;
  wire [31:0]dc_cpu_waddr_IBUF;
  wire [31:0]dc_cpu_wdata;
  wire [31:0]dc_cpu_wdata_IBUF;
  wire [3:0]dc_cpu_wen;
  wire [3:0]dc_cpu_wen_IBUF;
  wire [127:0]dc_dev_rdata;
  wire \dc_dev_rdata[127]_i_1_n_0 ;
  wire [127:0]dc_dev_rdata_OBUF;
  wire dc_dev_rrdy;
  wire dc_dev_rrdy_OBUF;
  wire dc_dev_rrdy_i_1_n_0;
  wire dc_dev_rvalid;
  wire dc_dev_rvalid_OBUF;
  wire dc_dev_rvalid_i_1_n_0;
  wire dc_dev_wrdy;
  wire dc_dev_wrdy_OBUF;
  wire dc_dev_wrdy_i_1_n_0;
  wire has_dc_rd_req_r;
  wire has_dc_rd_req_r_i_1_n_0;
  wire has_dc_wr_req;
  wire has_ic_rd_req_r;
  wire has_ic_rd_req_r_i_1_n_0;
  wire has_rd_req;
  wire [31:0]ic_cpu_raddr;
  wire [31:0]ic_cpu_raddr_IBUF;
  wire ic_cpu_ren;
  wire ic_cpu_ren_IBUF;
  wire [255:0]ic_dev_rdata;
  wire \ic_dev_rdata[255]_i_1_n_0 ;
  wire [255:0]ic_dev_rdata_OBUF;
  wire ic_dev_rrdy;
  wire ic_dev_rrdy_OBUF;
  wire ic_dev_rrdy_i_1_n_0;
  wire ic_dev_rvalid;
  wire ic_dev_rvalid_OBUF;
  wire ic_dev_rvalid_i_1_n_0;
  wire [31:0]m_axi_araddr;
  wire \m_axi_araddr[0]_i_1_n_0 ;
  wire \m_axi_araddr[10]_i_1_n_0 ;
  wire \m_axi_araddr[11]_i_1_n_0 ;
  wire \m_axi_araddr[12]_i_1_n_0 ;
  wire \m_axi_araddr[13]_i_1_n_0 ;
  wire \m_axi_araddr[14]_i_1_n_0 ;
  wire \m_axi_araddr[15]_i_1_n_0 ;
  wire \m_axi_araddr[16]_i_1_n_0 ;
  wire \m_axi_araddr[17]_i_1_n_0 ;
  wire \m_axi_araddr[18]_i_1_n_0 ;
  wire \m_axi_araddr[19]_i_1_n_0 ;
  wire \m_axi_araddr[1]_i_1_n_0 ;
  wire \m_axi_araddr[20]_i_1_n_0 ;
  wire \m_axi_araddr[21]_i_1_n_0 ;
  wire \m_axi_araddr[22]_i_1_n_0 ;
  wire \m_axi_araddr[23]_i_1_n_0 ;
  wire \m_axi_araddr[24]_i_1_n_0 ;
  wire \m_axi_araddr[25]_i_1_n_0 ;
  wire \m_axi_araddr[26]_i_1_n_0 ;
  wire \m_axi_araddr[27]_i_1_n_0 ;
  wire \m_axi_araddr[28]_i_1_n_0 ;
  wire \m_axi_araddr[29]_i_1_n_0 ;
  wire \m_axi_araddr[2]_i_1_n_0 ;
  wire \m_axi_araddr[30]_i_1_n_0 ;
  wire \m_axi_araddr[31]_i_2_n_0 ;
  wire \m_axi_araddr[3]_i_1_n_0 ;
  wire \m_axi_araddr[4]_i_1_n_0 ;
  wire \m_axi_araddr[5]_i_1_n_0 ;
  wire \m_axi_araddr[6]_i_1_n_0 ;
  wire \m_axi_araddr[7]_i_1_n_0 ;
  wire \m_axi_araddr[8]_i_1_n_0 ;
  wire \m_axi_araddr[9]_i_1_n_0 ;
  wire [31:0]m_axi_araddr_OBUF;
  wire [1:0]m_axi_arburst;
  wire [0:0]m_axi_arburst_OBUF;
  wire [7:0]m_axi_arlen;
  wire \m_axi_arlen[2]_i_1_n_0 ;
  wire \m_axi_arlen[2]_i_2_n_0 ;
  wire [2:2]m_axi_arlen_OBUF;
  wire m_axi_arready;
  wire m_axi_arready_IBUF;
  wire [2:0]m_axi_arsize;
  wire m_axi_arvalid;
  wire m_axi_arvalid_OBUF;
  wire m_axi_arvalid_i_1_n_0;
  wire [31:0]m_axi_awaddr;
  wire \m_axi_awaddr[31]_i_1_n_0 ;
  wire [31:0]m_axi_awaddr_OBUF;
  wire [1:0]m_axi_awburst;
  wire [0:0]m_axi_awburst_OBUF;
  wire [7:0]m_axi_awlen;
  wire m_axi_awready;
  wire m_axi_awready_IBUF;
  wire [2:0]m_axi_awsize;
  wire \m_axi_awsize[1]_i_1_n_0 ;
  wire m_axi_awvalid;
  wire m_axi_awvalid_OBUF;
  wire m_axi_awvalid_i_1_n_0;
  wire m_axi_bready;
  wire m_axi_bvalid;
  wire m_axi_bvalid_IBUF;
  wire [31:0]m_axi_rdata;
  wire [31:0]m_axi_rdata_IBUF;
  wire m_axi_rlast;
  wire m_axi_rlast_IBUF;
  wire m_axi_rready;
  wire m_axi_rready_OBUF;
  wire m_axi_rvalid;
  wire m_axi_rvalid_IBUF;
  wire [31:0]m_axi_wdata;
  wire \m_axi_wdata[31]_i_1_n_0 ;
  wire [31:0]m_axi_wdata_OBUF;
  wire m_axi_wlast;
  wire m_axi_wready;
  wire m_axi_wready_IBUF;
  wire [3:0]m_axi_wstrb;
  wire [3:0]m_axi_wstrb_OBUF;
  wire m_axi_wvalid;
  wire m_axi_wvalid_OBUF;
  wire m_axi_wvalid_i_1_n_0;
  wire p_3_in;

  BUFG aclk_IBUF_BUFG_inst
       (.I(aclk_IBUF),
        .O(aclk_IBUF_BUFG));
  IBUF aclk_IBUF_inst
       (.I(aclk),
        .O(aclk_IBUF));
  IBUF areset_IBUF_inst
       (.I(areset),
        .O(areset_IBUF));
  IBUF \dc_cpu_raddr_IBUF[0]_inst 
       (.I(dc_cpu_raddr[0]),
        .O(dc_cpu_raddr_IBUF[0]));
  IBUF \dc_cpu_raddr_IBUF[10]_inst 
       (.I(dc_cpu_raddr[10]),
        .O(dc_cpu_raddr_IBUF[10]));
  IBUF \dc_cpu_raddr_IBUF[11]_inst 
       (.I(dc_cpu_raddr[11]),
        .O(dc_cpu_raddr_IBUF[11]));
  IBUF \dc_cpu_raddr_IBUF[12]_inst 
       (.I(dc_cpu_raddr[12]),
        .O(dc_cpu_raddr_IBUF[12]));
  IBUF \dc_cpu_raddr_IBUF[13]_inst 
       (.I(dc_cpu_raddr[13]),
        .O(dc_cpu_raddr_IBUF[13]));
  IBUF \dc_cpu_raddr_IBUF[14]_inst 
       (.I(dc_cpu_raddr[14]),
        .O(dc_cpu_raddr_IBUF[14]));
  IBUF \dc_cpu_raddr_IBUF[15]_inst 
       (.I(dc_cpu_raddr[15]),
        .O(dc_cpu_raddr_IBUF[15]));
  IBUF \dc_cpu_raddr_IBUF[16]_inst 
       (.I(dc_cpu_raddr[16]),
        .O(dc_cpu_raddr_IBUF[16]));
  IBUF \dc_cpu_raddr_IBUF[17]_inst 
       (.I(dc_cpu_raddr[17]),
        .O(dc_cpu_raddr_IBUF[17]));
  IBUF \dc_cpu_raddr_IBUF[18]_inst 
       (.I(dc_cpu_raddr[18]),
        .O(dc_cpu_raddr_IBUF[18]));
  IBUF \dc_cpu_raddr_IBUF[19]_inst 
       (.I(dc_cpu_raddr[19]),
        .O(dc_cpu_raddr_IBUF[19]));
  IBUF \dc_cpu_raddr_IBUF[1]_inst 
       (.I(dc_cpu_raddr[1]),
        .O(dc_cpu_raddr_IBUF[1]));
  IBUF \dc_cpu_raddr_IBUF[20]_inst 
       (.I(dc_cpu_raddr[20]),
        .O(dc_cpu_raddr_IBUF[20]));
  IBUF \dc_cpu_raddr_IBUF[21]_inst 
       (.I(dc_cpu_raddr[21]),
        .O(dc_cpu_raddr_IBUF[21]));
  IBUF \dc_cpu_raddr_IBUF[22]_inst 
       (.I(dc_cpu_raddr[22]),
        .O(dc_cpu_raddr_IBUF[22]));
  IBUF \dc_cpu_raddr_IBUF[23]_inst 
       (.I(dc_cpu_raddr[23]),
        .O(dc_cpu_raddr_IBUF[23]));
  IBUF \dc_cpu_raddr_IBUF[24]_inst 
       (.I(dc_cpu_raddr[24]),
        .O(dc_cpu_raddr_IBUF[24]));
  IBUF \dc_cpu_raddr_IBUF[25]_inst 
       (.I(dc_cpu_raddr[25]),
        .O(dc_cpu_raddr_IBUF[25]));
  IBUF \dc_cpu_raddr_IBUF[26]_inst 
       (.I(dc_cpu_raddr[26]),
        .O(dc_cpu_raddr_IBUF[26]));
  IBUF \dc_cpu_raddr_IBUF[27]_inst 
       (.I(dc_cpu_raddr[27]),
        .O(dc_cpu_raddr_IBUF[27]));
  IBUF \dc_cpu_raddr_IBUF[28]_inst 
       (.I(dc_cpu_raddr[28]),
        .O(dc_cpu_raddr_IBUF[28]));
  IBUF \dc_cpu_raddr_IBUF[29]_inst 
       (.I(dc_cpu_raddr[29]),
        .O(dc_cpu_raddr_IBUF[29]));
  IBUF \dc_cpu_raddr_IBUF[2]_inst 
       (.I(dc_cpu_raddr[2]),
        .O(dc_cpu_raddr_IBUF[2]));
  IBUF \dc_cpu_raddr_IBUF[30]_inst 
       (.I(dc_cpu_raddr[30]),
        .O(dc_cpu_raddr_IBUF[30]));
  IBUF \dc_cpu_raddr_IBUF[31]_inst 
       (.I(dc_cpu_raddr[31]),
        .O(dc_cpu_raddr_IBUF[31]));
  IBUF \dc_cpu_raddr_IBUF[3]_inst 
       (.I(dc_cpu_raddr[3]),
        .O(dc_cpu_raddr_IBUF[3]));
  IBUF \dc_cpu_raddr_IBUF[4]_inst 
       (.I(dc_cpu_raddr[4]),
        .O(dc_cpu_raddr_IBUF[4]));
  IBUF \dc_cpu_raddr_IBUF[5]_inst 
       (.I(dc_cpu_raddr[5]),
        .O(dc_cpu_raddr_IBUF[5]));
  IBUF \dc_cpu_raddr_IBUF[6]_inst 
       (.I(dc_cpu_raddr[6]),
        .O(dc_cpu_raddr_IBUF[6]));
  IBUF \dc_cpu_raddr_IBUF[7]_inst 
       (.I(dc_cpu_raddr[7]),
        .O(dc_cpu_raddr_IBUF[7]));
  IBUF \dc_cpu_raddr_IBUF[8]_inst 
       (.I(dc_cpu_raddr[8]),
        .O(dc_cpu_raddr_IBUF[8]));
  IBUF \dc_cpu_raddr_IBUF[9]_inst 
       (.I(dc_cpu_raddr[9]),
        .O(dc_cpu_raddr_IBUF[9]));
  IBUF dc_cpu_ren_IBUF_inst
       (.I(dc_cpu_ren),
        .O(dc_cpu_ren_IBUF));
  IBUF \dc_cpu_waddr_IBUF[0]_inst 
       (.I(dc_cpu_waddr[0]),
        .O(dc_cpu_waddr_IBUF[0]));
  IBUF \dc_cpu_waddr_IBUF[10]_inst 
       (.I(dc_cpu_waddr[10]),
        .O(dc_cpu_waddr_IBUF[10]));
  IBUF \dc_cpu_waddr_IBUF[11]_inst 
       (.I(dc_cpu_waddr[11]),
        .O(dc_cpu_waddr_IBUF[11]));
  IBUF \dc_cpu_waddr_IBUF[12]_inst 
       (.I(dc_cpu_waddr[12]),
        .O(dc_cpu_waddr_IBUF[12]));
  IBUF \dc_cpu_waddr_IBUF[13]_inst 
       (.I(dc_cpu_waddr[13]),
        .O(dc_cpu_waddr_IBUF[13]));
  IBUF \dc_cpu_waddr_IBUF[14]_inst 
       (.I(dc_cpu_waddr[14]),
        .O(dc_cpu_waddr_IBUF[14]));
  IBUF \dc_cpu_waddr_IBUF[15]_inst 
       (.I(dc_cpu_waddr[15]),
        .O(dc_cpu_waddr_IBUF[15]));
  IBUF \dc_cpu_waddr_IBUF[16]_inst 
       (.I(dc_cpu_waddr[16]),
        .O(dc_cpu_waddr_IBUF[16]));
  IBUF \dc_cpu_waddr_IBUF[17]_inst 
       (.I(dc_cpu_waddr[17]),
        .O(dc_cpu_waddr_IBUF[17]));
  IBUF \dc_cpu_waddr_IBUF[18]_inst 
       (.I(dc_cpu_waddr[18]),
        .O(dc_cpu_waddr_IBUF[18]));
  IBUF \dc_cpu_waddr_IBUF[19]_inst 
       (.I(dc_cpu_waddr[19]),
        .O(dc_cpu_waddr_IBUF[19]));
  IBUF \dc_cpu_waddr_IBUF[1]_inst 
       (.I(dc_cpu_waddr[1]),
        .O(dc_cpu_waddr_IBUF[1]));
  IBUF \dc_cpu_waddr_IBUF[20]_inst 
       (.I(dc_cpu_waddr[20]),
        .O(dc_cpu_waddr_IBUF[20]));
  IBUF \dc_cpu_waddr_IBUF[21]_inst 
       (.I(dc_cpu_waddr[21]),
        .O(dc_cpu_waddr_IBUF[21]));
  IBUF \dc_cpu_waddr_IBUF[22]_inst 
       (.I(dc_cpu_waddr[22]),
        .O(dc_cpu_waddr_IBUF[22]));
  IBUF \dc_cpu_waddr_IBUF[23]_inst 
       (.I(dc_cpu_waddr[23]),
        .O(dc_cpu_waddr_IBUF[23]));
  IBUF \dc_cpu_waddr_IBUF[24]_inst 
       (.I(dc_cpu_waddr[24]),
        .O(dc_cpu_waddr_IBUF[24]));
  IBUF \dc_cpu_waddr_IBUF[25]_inst 
       (.I(dc_cpu_waddr[25]),
        .O(dc_cpu_waddr_IBUF[25]));
  IBUF \dc_cpu_waddr_IBUF[26]_inst 
       (.I(dc_cpu_waddr[26]),
        .O(dc_cpu_waddr_IBUF[26]));
  IBUF \dc_cpu_waddr_IBUF[27]_inst 
       (.I(dc_cpu_waddr[27]),
        .O(dc_cpu_waddr_IBUF[27]));
  IBUF \dc_cpu_waddr_IBUF[28]_inst 
       (.I(dc_cpu_waddr[28]),
        .O(dc_cpu_waddr_IBUF[28]));
  IBUF \dc_cpu_waddr_IBUF[29]_inst 
       (.I(dc_cpu_waddr[29]),
        .O(dc_cpu_waddr_IBUF[29]));
  IBUF \dc_cpu_waddr_IBUF[2]_inst 
       (.I(dc_cpu_waddr[2]),
        .O(dc_cpu_waddr_IBUF[2]));
  IBUF \dc_cpu_waddr_IBUF[30]_inst 
       (.I(dc_cpu_waddr[30]),
        .O(dc_cpu_waddr_IBUF[30]));
  IBUF \dc_cpu_waddr_IBUF[31]_inst 
       (.I(dc_cpu_waddr[31]),
        .O(dc_cpu_waddr_IBUF[31]));
  IBUF \dc_cpu_waddr_IBUF[3]_inst 
       (.I(dc_cpu_waddr[3]),
        .O(dc_cpu_waddr_IBUF[3]));
  IBUF \dc_cpu_waddr_IBUF[4]_inst 
       (.I(dc_cpu_waddr[4]),
        .O(dc_cpu_waddr_IBUF[4]));
  IBUF \dc_cpu_waddr_IBUF[5]_inst 
       (.I(dc_cpu_waddr[5]),
        .O(dc_cpu_waddr_IBUF[5]));
  IBUF \dc_cpu_waddr_IBUF[6]_inst 
       (.I(dc_cpu_waddr[6]),
        .O(dc_cpu_waddr_IBUF[6]));
  IBUF \dc_cpu_waddr_IBUF[7]_inst 
       (.I(dc_cpu_waddr[7]),
        .O(dc_cpu_waddr_IBUF[7]));
  IBUF \dc_cpu_waddr_IBUF[8]_inst 
       (.I(dc_cpu_waddr[8]),
        .O(dc_cpu_waddr_IBUF[8]));
  IBUF \dc_cpu_waddr_IBUF[9]_inst 
       (.I(dc_cpu_waddr[9]),
        .O(dc_cpu_waddr_IBUF[9]));
  IBUF \dc_cpu_wdata_IBUF[0]_inst 
       (.I(dc_cpu_wdata[0]),
        .O(dc_cpu_wdata_IBUF[0]));
  IBUF \dc_cpu_wdata_IBUF[10]_inst 
       (.I(dc_cpu_wdata[10]),
        .O(dc_cpu_wdata_IBUF[10]));
  IBUF \dc_cpu_wdata_IBUF[11]_inst 
       (.I(dc_cpu_wdata[11]),
        .O(dc_cpu_wdata_IBUF[11]));
  IBUF \dc_cpu_wdata_IBUF[12]_inst 
       (.I(dc_cpu_wdata[12]),
        .O(dc_cpu_wdata_IBUF[12]));
  IBUF \dc_cpu_wdata_IBUF[13]_inst 
       (.I(dc_cpu_wdata[13]),
        .O(dc_cpu_wdata_IBUF[13]));
  IBUF \dc_cpu_wdata_IBUF[14]_inst 
       (.I(dc_cpu_wdata[14]),
        .O(dc_cpu_wdata_IBUF[14]));
  IBUF \dc_cpu_wdata_IBUF[15]_inst 
       (.I(dc_cpu_wdata[15]),
        .O(dc_cpu_wdata_IBUF[15]));
  IBUF \dc_cpu_wdata_IBUF[16]_inst 
       (.I(dc_cpu_wdata[16]),
        .O(dc_cpu_wdata_IBUF[16]));
  IBUF \dc_cpu_wdata_IBUF[17]_inst 
       (.I(dc_cpu_wdata[17]),
        .O(dc_cpu_wdata_IBUF[17]));
  IBUF \dc_cpu_wdata_IBUF[18]_inst 
       (.I(dc_cpu_wdata[18]),
        .O(dc_cpu_wdata_IBUF[18]));
  IBUF \dc_cpu_wdata_IBUF[19]_inst 
       (.I(dc_cpu_wdata[19]),
        .O(dc_cpu_wdata_IBUF[19]));
  IBUF \dc_cpu_wdata_IBUF[1]_inst 
       (.I(dc_cpu_wdata[1]),
        .O(dc_cpu_wdata_IBUF[1]));
  IBUF \dc_cpu_wdata_IBUF[20]_inst 
       (.I(dc_cpu_wdata[20]),
        .O(dc_cpu_wdata_IBUF[20]));
  IBUF \dc_cpu_wdata_IBUF[21]_inst 
       (.I(dc_cpu_wdata[21]),
        .O(dc_cpu_wdata_IBUF[21]));
  IBUF \dc_cpu_wdata_IBUF[22]_inst 
       (.I(dc_cpu_wdata[22]),
        .O(dc_cpu_wdata_IBUF[22]));
  IBUF \dc_cpu_wdata_IBUF[23]_inst 
       (.I(dc_cpu_wdata[23]),
        .O(dc_cpu_wdata_IBUF[23]));
  IBUF \dc_cpu_wdata_IBUF[24]_inst 
       (.I(dc_cpu_wdata[24]),
        .O(dc_cpu_wdata_IBUF[24]));
  IBUF \dc_cpu_wdata_IBUF[25]_inst 
       (.I(dc_cpu_wdata[25]),
        .O(dc_cpu_wdata_IBUF[25]));
  IBUF \dc_cpu_wdata_IBUF[26]_inst 
       (.I(dc_cpu_wdata[26]),
        .O(dc_cpu_wdata_IBUF[26]));
  IBUF \dc_cpu_wdata_IBUF[27]_inst 
       (.I(dc_cpu_wdata[27]),
        .O(dc_cpu_wdata_IBUF[27]));
  IBUF \dc_cpu_wdata_IBUF[28]_inst 
       (.I(dc_cpu_wdata[28]),
        .O(dc_cpu_wdata_IBUF[28]));
  IBUF \dc_cpu_wdata_IBUF[29]_inst 
       (.I(dc_cpu_wdata[29]),
        .O(dc_cpu_wdata_IBUF[29]));
  IBUF \dc_cpu_wdata_IBUF[2]_inst 
       (.I(dc_cpu_wdata[2]),
        .O(dc_cpu_wdata_IBUF[2]));
  IBUF \dc_cpu_wdata_IBUF[30]_inst 
       (.I(dc_cpu_wdata[30]),
        .O(dc_cpu_wdata_IBUF[30]));
  IBUF \dc_cpu_wdata_IBUF[31]_inst 
       (.I(dc_cpu_wdata[31]),
        .O(dc_cpu_wdata_IBUF[31]));
  IBUF \dc_cpu_wdata_IBUF[3]_inst 
       (.I(dc_cpu_wdata[3]),
        .O(dc_cpu_wdata_IBUF[3]));
  IBUF \dc_cpu_wdata_IBUF[4]_inst 
       (.I(dc_cpu_wdata[4]),
        .O(dc_cpu_wdata_IBUF[4]));
  IBUF \dc_cpu_wdata_IBUF[5]_inst 
       (.I(dc_cpu_wdata[5]),
        .O(dc_cpu_wdata_IBUF[5]));
  IBUF \dc_cpu_wdata_IBUF[6]_inst 
       (.I(dc_cpu_wdata[6]),
        .O(dc_cpu_wdata_IBUF[6]));
  IBUF \dc_cpu_wdata_IBUF[7]_inst 
       (.I(dc_cpu_wdata[7]),
        .O(dc_cpu_wdata_IBUF[7]));
  IBUF \dc_cpu_wdata_IBUF[8]_inst 
       (.I(dc_cpu_wdata[8]),
        .O(dc_cpu_wdata_IBUF[8]));
  IBUF \dc_cpu_wdata_IBUF[9]_inst 
       (.I(dc_cpu_wdata[9]),
        .O(dc_cpu_wdata_IBUF[9]));
  IBUF \dc_cpu_wen_IBUF[0]_inst 
       (.I(dc_cpu_wen[0]),
        .O(dc_cpu_wen_IBUF[0]));
  IBUF \dc_cpu_wen_IBUF[1]_inst 
       (.I(dc_cpu_wen[1]),
        .O(dc_cpu_wen_IBUF[1]));
  IBUF \dc_cpu_wen_IBUF[2]_inst 
       (.I(dc_cpu_wen[2]),
        .O(dc_cpu_wen_IBUF[2]));
  IBUF \dc_cpu_wen_IBUF[3]_inst 
       (.I(dc_cpu_wen[3]),
        .O(dc_cpu_wen_IBUF[3]));
  LUT2 #(
    .INIT(4'h8)) 
    \dc_dev_rdata[127]_i_1 
       (.I0(m_axi_rvalid_IBUF),
        .I1(has_dc_rd_req_r),
        .O(\dc_dev_rdata[127]_i_1_n_0 ));
  OBUF \dc_dev_rdata_OBUF[0]_inst 
       (.I(dc_dev_rdata_OBUF[0]),
        .O(dc_dev_rdata[0]));
  OBUF \dc_dev_rdata_OBUF[100]_inst 
       (.I(dc_dev_rdata_OBUF[100]),
        .O(dc_dev_rdata[100]));
  OBUF \dc_dev_rdata_OBUF[101]_inst 
       (.I(dc_dev_rdata_OBUF[101]),
        .O(dc_dev_rdata[101]));
  OBUF \dc_dev_rdata_OBUF[102]_inst 
       (.I(dc_dev_rdata_OBUF[102]),
        .O(dc_dev_rdata[102]));
  OBUF \dc_dev_rdata_OBUF[103]_inst 
       (.I(dc_dev_rdata_OBUF[103]),
        .O(dc_dev_rdata[103]));
  OBUF \dc_dev_rdata_OBUF[104]_inst 
       (.I(dc_dev_rdata_OBUF[104]),
        .O(dc_dev_rdata[104]));
  OBUF \dc_dev_rdata_OBUF[105]_inst 
       (.I(dc_dev_rdata_OBUF[105]),
        .O(dc_dev_rdata[105]));
  OBUF \dc_dev_rdata_OBUF[106]_inst 
       (.I(dc_dev_rdata_OBUF[106]),
        .O(dc_dev_rdata[106]));
  OBUF \dc_dev_rdata_OBUF[107]_inst 
       (.I(dc_dev_rdata_OBUF[107]),
        .O(dc_dev_rdata[107]));
  OBUF \dc_dev_rdata_OBUF[108]_inst 
       (.I(dc_dev_rdata_OBUF[108]),
        .O(dc_dev_rdata[108]));
  OBUF \dc_dev_rdata_OBUF[109]_inst 
       (.I(dc_dev_rdata_OBUF[109]),
        .O(dc_dev_rdata[109]));
  OBUF \dc_dev_rdata_OBUF[10]_inst 
       (.I(dc_dev_rdata_OBUF[10]),
        .O(dc_dev_rdata[10]));
  OBUF \dc_dev_rdata_OBUF[110]_inst 
       (.I(dc_dev_rdata_OBUF[110]),
        .O(dc_dev_rdata[110]));
  OBUF \dc_dev_rdata_OBUF[111]_inst 
       (.I(dc_dev_rdata_OBUF[111]),
        .O(dc_dev_rdata[111]));
  OBUF \dc_dev_rdata_OBUF[112]_inst 
       (.I(dc_dev_rdata_OBUF[112]),
        .O(dc_dev_rdata[112]));
  OBUF \dc_dev_rdata_OBUF[113]_inst 
       (.I(dc_dev_rdata_OBUF[113]),
        .O(dc_dev_rdata[113]));
  OBUF \dc_dev_rdata_OBUF[114]_inst 
       (.I(dc_dev_rdata_OBUF[114]),
        .O(dc_dev_rdata[114]));
  OBUF \dc_dev_rdata_OBUF[115]_inst 
       (.I(dc_dev_rdata_OBUF[115]),
        .O(dc_dev_rdata[115]));
  OBUF \dc_dev_rdata_OBUF[116]_inst 
       (.I(dc_dev_rdata_OBUF[116]),
        .O(dc_dev_rdata[116]));
  OBUF \dc_dev_rdata_OBUF[117]_inst 
       (.I(dc_dev_rdata_OBUF[117]),
        .O(dc_dev_rdata[117]));
  OBUF \dc_dev_rdata_OBUF[118]_inst 
       (.I(dc_dev_rdata_OBUF[118]),
        .O(dc_dev_rdata[118]));
  OBUF \dc_dev_rdata_OBUF[119]_inst 
       (.I(dc_dev_rdata_OBUF[119]),
        .O(dc_dev_rdata[119]));
  OBUF \dc_dev_rdata_OBUF[11]_inst 
       (.I(dc_dev_rdata_OBUF[11]),
        .O(dc_dev_rdata[11]));
  OBUF \dc_dev_rdata_OBUF[120]_inst 
       (.I(dc_dev_rdata_OBUF[120]),
        .O(dc_dev_rdata[120]));
  OBUF \dc_dev_rdata_OBUF[121]_inst 
       (.I(dc_dev_rdata_OBUF[121]),
        .O(dc_dev_rdata[121]));
  OBUF \dc_dev_rdata_OBUF[122]_inst 
       (.I(dc_dev_rdata_OBUF[122]),
        .O(dc_dev_rdata[122]));
  OBUF \dc_dev_rdata_OBUF[123]_inst 
       (.I(dc_dev_rdata_OBUF[123]),
        .O(dc_dev_rdata[123]));
  OBUF \dc_dev_rdata_OBUF[124]_inst 
       (.I(dc_dev_rdata_OBUF[124]),
        .O(dc_dev_rdata[124]));
  OBUF \dc_dev_rdata_OBUF[125]_inst 
       (.I(dc_dev_rdata_OBUF[125]),
        .O(dc_dev_rdata[125]));
  OBUF \dc_dev_rdata_OBUF[126]_inst 
       (.I(dc_dev_rdata_OBUF[126]),
        .O(dc_dev_rdata[126]));
  OBUF \dc_dev_rdata_OBUF[127]_inst 
       (.I(dc_dev_rdata_OBUF[127]),
        .O(dc_dev_rdata[127]));
  OBUF \dc_dev_rdata_OBUF[12]_inst 
       (.I(dc_dev_rdata_OBUF[12]),
        .O(dc_dev_rdata[12]));
  OBUF \dc_dev_rdata_OBUF[13]_inst 
       (.I(dc_dev_rdata_OBUF[13]),
        .O(dc_dev_rdata[13]));
  OBUF \dc_dev_rdata_OBUF[14]_inst 
       (.I(dc_dev_rdata_OBUF[14]),
        .O(dc_dev_rdata[14]));
  OBUF \dc_dev_rdata_OBUF[15]_inst 
       (.I(dc_dev_rdata_OBUF[15]),
        .O(dc_dev_rdata[15]));
  OBUF \dc_dev_rdata_OBUF[16]_inst 
       (.I(dc_dev_rdata_OBUF[16]),
        .O(dc_dev_rdata[16]));
  OBUF \dc_dev_rdata_OBUF[17]_inst 
       (.I(dc_dev_rdata_OBUF[17]),
        .O(dc_dev_rdata[17]));
  OBUF \dc_dev_rdata_OBUF[18]_inst 
       (.I(dc_dev_rdata_OBUF[18]),
        .O(dc_dev_rdata[18]));
  OBUF \dc_dev_rdata_OBUF[19]_inst 
       (.I(dc_dev_rdata_OBUF[19]),
        .O(dc_dev_rdata[19]));
  OBUF \dc_dev_rdata_OBUF[1]_inst 
       (.I(dc_dev_rdata_OBUF[1]),
        .O(dc_dev_rdata[1]));
  OBUF \dc_dev_rdata_OBUF[20]_inst 
       (.I(dc_dev_rdata_OBUF[20]),
        .O(dc_dev_rdata[20]));
  OBUF \dc_dev_rdata_OBUF[21]_inst 
       (.I(dc_dev_rdata_OBUF[21]),
        .O(dc_dev_rdata[21]));
  OBUF \dc_dev_rdata_OBUF[22]_inst 
       (.I(dc_dev_rdata_OBUF[22]),
        .O(dc_dev_rdata[22]));
  OBUF \dc_dev_rdata_OBUF[23]_inst 
       (.I(dc_dev_rdata_OBUF[23]),
        .O(dc_dev_rdata[23]));
  OBUF \dc_dev_rdata_OBUF[24]_inst 
       (.I(dc_dev_rdata_OBUF[24]),
        .O(dc_dev_rdata[24]));
  OBUF \dc_dev_rdata_OBUF[25]_inst 
       (.I(dc_dev_rdata_OBUF[25]),
        .O(dc_dev_rdata[25]));
  OBUF \dc_dev_rdata_OBUF[26]_inst 
       (.I(dc_dev_rdata_OBUF[26]),
        .O(dc_dev_rdata[26]));
  OBUF \dc_dev_rdata_OBUF[27]_inst 
       (.I(dc_dev_rdata_OBUF[27]),
        .O(dc_dev_rdata[27]));
  OBUF \dc_dev_rdata_OBUF[28]_inst 
       (.I(dc_dev_rdata_OBUF[28]),
        .O(dc_dev_rdata[28]));
  OBUF \dc_dev_rdata_OBUF[29]_inst 
       (.I(dc_dev_rdata_OBUF[29]),
        .O(dc_dev_rdata[29]));
  OBUF \dc_dev_rdata_OBUF[2]_inst 
       (.I(dc_dev_rdata_OBUF[2]),
        .O(dc_dev_rdata[2]));
  OBUF \dc_dev_rdata_OBUF[30]_inst 
       (.I(dc_dev_rdata_OBUF[30]),
        .O(dc_dev_rdata[30]));
  OBUF \dc_dev_rdata_OBUF[31]_inst 
       (.I(dc_dev_rdata_OBUF[31]),
        .O(dc_dev_rdata[31]));
  OBUF \dc_dev_rdata_OBUF[32]_inst 
       (.I(dc_dev_rdata_OBUF[32]),
        .O(dc_dev_rdata[32]));
  OBUF \dc_dev_rdata_OBUF[33]_inst 
       (.I(dc_dev_rdata_OBUF[33]),
        .O(dc_dev_rdata[33]));
  OBUF \dc_dev_rdata_OBUF[34]_inst 
       (.I(dc_dev_rdata_OBUF[34]),
        .O(dc_dev_rdata[34]));
  OBUF \dc_dev_rdata_OBUF[35]_inst 
       (.I(dc_dev_rdata_OBUF[35]),
        .O(dc_dev_rdata[35]));
  OBUF \dc_dev_rdata_OBUF[36]_inst 
       (.I(dc_dev_rdata_OBUF[36]),
        .O(dc_dev_rdata[36]));
  OBUF \dc_dev_rdata_OBUF[37]_inst 
       (.I(dc_dev_rdata_OBUF[37]),
        .O(dc_dev_rdata[37]));
  OBUF \dc_dev_rdata_OBUF[38]_inst 
       (.I(dc_dev_rdata_OBUF[38]),
        .O(dc_dev_rdata[38]));
  OBUF \dc_dev_rdata_OBUF[39]_inst 
       (.I(dc_dev_rdata_OBUF[39]),
        .O(dc_dev_rdata[39]));
  OBUF \dc_dev_rdata_OBUF[3]_inst 
       (.I(dc_dev_rdata_OBUF[3]),
        .O(dc_dev_rdata[3]));
  OBUF \dc_dev_rdata_OBUF[40]_inst 
       (.I(dc_dev_rdata_OBUF[40]),
        .O(dc_dev_rdata[40]));
  OBUF \dc_dev_rdata_OBUF[41]_inst 
       (.I(dc_dev_rdata_OBUF[41]),
        .O(dc_dev_rdata[41]));
  OBUF \dc_dev_rdata_OBUF[42]_inst 
       (.I(dc_dev_rdata_OBUF[42]),
        .O(dc_dev_rdata[42]));
  OBUF \dc_dev_rdata_OBUF[43]_inst 
       (.I(dc_dev_rdata_OBUF[43]),
        .O(dc_dev_rdata[43]));
  OBUF \dc_dev_rdata_OBUF[44]_inst 
       (.I(dc_dev_rdata_OBUF[44]),
        .O(dc_dev_rdata[44]));
  OBUF \dc_dev_rdata_OBUF[45]_inst 
       (.I(dc_dev_rdata_OBUF[45]),
        .O(dc_dev_rdata[45]));
  OBUF \dc_dev_rdata_OBUF[46]_inst 
       (.I(dc_dev_rdata_OBUF[46]),
        .O(dc_dev_rdata[46]));
  OBUF \dc_dev_rdata_OBUF[47]_inst 
       (.I(dc_dev_rdata_OBUF[47]),
        .O(dc_dev_rdata[47]));
  OBUF \dc_dev_rdata_OBUF[48]_inst 
       (.I(dc_dev_rdata_OBUF[48]),
        .O(dc_dev_rdata[48]));
  OBUF \dc_dev_rdata_OBUF[49]_inst 
       (.I(dc_dev_rdata_OBUF[49]),
        .O(dc_dev_rdata[49]));
  OBUF \dc_dev_rdata_OBUF[4]_inst 
       (.I(dc_dev_rdata_OBUF[4]),
        .O(dc_dev_rdata[4]));
  OBUF \dc_dev_rdata_OBUF[50]_inst 
       (.I(dc_dev_rdata_OBUF[50]),
        .O(dc_dev_rdata[50]));
  OBUF \dc_dev_rdata_OBUF[51]_inst 
       (.I(dc_dev_rdata_OBUF[51]),
        .O(dc_dev_rdata[51]));
  OBUF \dc_dev_rdata_OBUF[52]_inst 
       (.I(dc_dev_rdata_OBUF[52]),
        .O(dc_dev_rdata[52]));
  OBUF \dc_dev_rdata_OBUF[53]_inst 
       (.I(dc_dev_rdata_OBUF[53]),
        .O(dc_dev_rdata[53]));
  OBUF \dc_dev_rdata_OBUF[54]_inst 
       (.I(dc_dev_rdata_OBUF[54]),
        .O(dc_dev_rdata[54]));
  OBUF \dc_dev_rdata_OBUF[55]_inst 
       (.I(dc_dev_rdata_OBUF[55]),
        .O(dc_dev_rdata[55]));
  OBUF \dc_dev_rdata_OBUF[56]_inst 
       (.I(dc_dev_rdata_OBUF[56]),
        .O(dc_dev_rdata[56]));
  OBUF \dc_dev_rdata_OBUF[57]_inst 
       (.I(dc_dev_rdata_OBUF[57]),
        .O(dc_dev_rdata[57]));
  OBUF \dc_dev_rdata_OBUF[58]_inst 
       (.I(dc_dev_rdata_OBUF[58]),
        .O(dc_dev_rdata[58]));
  OBUF \dc_dev_rdata_OBUF[59]_inst 
       (.I(dc_dev_rdata_OBUF[59]),
        .O(dc_dev_rdata[59]));
  OBUF \dc_dev_rdata_OBUF[5]_inst 
       (.I(dc_dev_rdata_OBUF[5]),
        .O(dc_dev_rdata[5]));
  OBUF \dc_dev_rdata_OBUF[60]_inst 
       (.I(dc_dev_rdata_OBUF[60]),
        .O(dc_dev_rdata[60]));
  OBUF \dc_dev_rdata_OBUF[61]_inst 
       (.I(dc_dev_rdata_OBUF[61]),
        .O(dc_dev_rdata[61]));
  OBUF \dc_dev_rdata_OBUF[62]_inst 
       (.I(dc_dev_rdata_OBUF[62]),
        .O(dc_dev_rdata[62]));
  OBUF \dc_dev_rdata_OBUF[63]_inst 
       (.I(dc_dev_rdata_OBUF[63]),
        .O(dc_dev_rdata[63]));
  OBUF \dc_dev_rdata_OBUF[64]_inst 
       (.I(dc_dev_rdata_OBUF[64]),
        .O(dc_dev_rdata[64]));
  OBUF \dc_dev_rdata_OBUF[65]_inst 
       (.I(dc_dev_rdata_OBUF[65]),
        .O(dc_dev_rdata[65]));
  OBUF \dc_dev_rdata_OBUF[66]_inst 
       (.I(dc_dev_rdata_OBUF[66]),
        .O(dc_dev_rdata[66]));
  OBUF \dc_dev_rdata_OBUF[67]_inst 
       (.I(dc_dev_rdata_OBUF[67]),
        .O(dc_dev_rdata[67]));
  OBUF \dc_dev_rdata_OBUF[68]_inst 
       (.I(dc_dev_rdata_OBUF[68]),
        .O(dc_dev_rdata[68]));
  OBUF \dc_dev_rdata_OBUF[69]_inst 
       (.I(dc_dev_rdata_OBUF[69]),
        .O(dc_dev_rdata[69]));
  OBUF \dc_dev_rdata_OBUF[6]_inst 
       (.I(dc_dev_rdata_OBUF[6]),
        .O(dc_dev_rdata[6]));
  OBUF \dc_dev_rdata_OBUF[70]_inst 
       (.I(dc_dev_rdata_OBUF[70]),
        .O(dc_dev_rdata[70]));
  OBUF \dc_dev_rdata_OBUF[71]_inst 
       (.I(dc_dev_rdata_OBUF[71]),
        .O(dc_dev_rdata[71]));
  OBUF \dc_dev_rdata_OBUF[72]_inst 
       (.I(dc_dev_rdata_OBUF[72]),
        .O(dc_dev_rdata[72]));
  OBUF \dc_dev_rdata_OBUF[73]_inst 
       (.I(dc_dev_rdata_OBUF[73]),
        .O(dc_dev_rdata[73]));
  OBUF \dc_dev_rdata_OBUF[74]_inst 
       (.I(dc_dev_rdata_OBUF[74]),
        .O(dc_dev_rdata[74]));
  OBUF \dc_dev_rdata_OBUF[75]_inst 
       (.I(dc_dev_rdata_OBUF[75]),
        .O(dc_dev_rdata[75]));
  OBUF \dc_dev_rdata_OBUF[76]_inst 
       (.I(dc_dev_rdata_OBUF[76]),
        .O(dc_dev_rdata[76]));
  OBUF \dc_dev_rdata_OBUF[77]_inst 
       (.I(dc_dev_rdata_OBUF[77]),
        .O(dc_dev_rdata[77]));
  OBUF \dc_dev_rdata_OBUF[78]_inst 
       (.I(dc_dev_rdata_OBUF[78]),
        .O(dc_dev_rdata[78]));
  OBUF \dc_dev_rdata_OBUF[79]_inst 
       (.I(dc_dev_rdata_OBUF[79]),
        .O(dc_dev_rdata[79]));
  OBUF \dc_dev_rdata_OBUF[7]_inst 
       (.I(dc_dev_rdata_OBUF[7]),
        .O(dc_dev_rdata[7]));
  OBUF \dc_dev_rdata_OBUF[80]_inst 
       (.I(dc_dev_rdata_OBUF[80]),
        .O(dc_dev_rdata[80]));
  OBUF \dc_dev_rdata_OBUF[81]_inst 
       (.I(dc_dev_rdata_OBUF[81]),
        .O(dc_dev_rdata[81]));
  OBUF \dc_dev_rdata_OBUF[82]_inst 
       (.I(dc_dev_rdata_OBUF[82]),
        .O(dc_dev_rdata[82]));
  OBUF \dc_dev_rdata_OBUF[83]_inst 
       (.I(dc_dev_rdata_OBUF[83]),
        .O(dc_dev_rdata[83]));
  OBUF \dc_dev_rdata_OBUF[84]_inst 
       (.I(dc_dev_rdata_OBUF[84]),
        .O(dc_dev_rdata[84]));
  OBUF \dc_dev_rdata_OBUF[85]_inst 
       (.I(dc_dev_rdata_OBUF[85]),
        .O(dc_dev_rdata[85]));
  OBUF \dc_dev_rdata_OBUF[86]_inst 
       (.I(dc_dev_rdata_OBUF[86]),
        .O(dc_dev_rdata[86]));
  OBUF \dc_dev_rdata_OBUF[87]_inst 
       (.I(dc_dev_rdata_OBUF[87]),
        .O(dc_dev_rdata[87]));
  OBUF \dc_dev_rdata_OBUF[88]_inst 
       (.I(dc_dev_rdata_OBUF[88]),
        .O(dc_dev_rdata[88]));
  OBUF \dc_dev_rdata_OBUF[89]_inst 
       (.I(dc_dev_rdata_OBUF[89]),
        .O(dc_dev_rdata[89]));
  OBUF \dc_dev_rdata_OBUF[8]_inst 
       (.I(dc_dev_rdata_OBUF[8]),
        .O(dc_dev_rdata[8]));
  OBUF \dc_dev_rdata_OBUF[90]_inst 
       (.I(dc_dev_rdata_OBUF[90]),
        .O(dc_dev_rdata[90]));
  OBUF \dc_dev_rdata_OBUF[91]_inst 
       (.I(dc_dev_rdata_OBUF[91]),
        .O(dc_dev_rdata[91]));
  OBUF \dc_dev_rdata_OBUF[92]_inst 
       (.I(dc_dev_rdata_OBUF[92]),
        .O(dc_dev_rdata[92]));
  OBUF \dc_dev_rdata_OBUF[93]_inst 
       (.I(dc_dev_rdata_OBUF[93]),
        .O(dc_dev_rdata[93]));
  OBUF \dc_dev_rdata_OBUF[94]_inst 
       (.I(dc_dev_rdata_OBUF[94]),
        .O(dc_dev_rdata[94]));
  OBUF \dc_dev_rdata_OBUF[95]_inst 
       (.I(dc_dev_rdata_OBUF[95]),
        .O(dc_dev_rdata[95]));
  OBUF \dc_dev_rdata_OBUF[96]_inst 
       (.I(dc_dev_rdata_OBUF[96]),
        .O(dc_dev_rdata[96]));
  OBUF \dc_dev_rdata_OBUF[97]_inst 
       (.I(dc_dev_rdata_OBUF[97]),
        .O(dc_dev_rdata[97]));
  OBUF \dc_dev_rdata_OBUF[98]_inst 
       (.I(dc_dev_rdata_OBUF[98]),
        .O(dc_dev_rdata[98]));
  OBUF \dc_dev_rdata_OBUF[99]_inst 
       (.I(dc_dev_rdata_OBUF[99]),
        .O(dc_dev_rdata[99]));
  OBUF \dc_dev_rdata_OBUF[9]_inst 
       (.I(dc_dev_rdata_OBUF[9]),
        .O(dc_dev_rdata[9]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[0] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[32]),
        .Q(dc_dev_rdata_OBUF[0]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[100] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[4]),
        .Q(dc_dev_rdata_OBUF[100]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[101] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[5]),
        .Q(dc_dev_rdata_OBUF[101]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[102] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[6]),
        .Q(dc_dev_rdata_OBUF[102]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[103] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[7]),
        .Q(dc_dev_rdata_OBUF[103]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[104] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[8]),
        .Q(dc_dev_rdata_OBUF[104]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[105] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[9]),
        .Q(dc_dev_rdata_OBUF[105]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[106] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[10]),
        .Q(dc_dev_rdata_OBUF[106]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[107] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[11]),
        .Q(dc_dev_rdata_OBUF[107]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[108] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[12]),
        .Q(dc_dev_rdata_OBUF[108]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[109] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[13]),
        .Q(dc_dev_rdata_OBUF[109]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[10] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[42]),
        .Q(dc_dev_rdata_OBUF[10]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[110] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[14]),
        .Q(dc_dev_rdata_OBUF[110]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[111] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[15]),
        .Q(dc_dev_rdata_OBUF[111]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[112] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[16]),
        .Q(dc_dev_rdata_OBUF[112]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[113] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[17]),
        .Q(dc_dev_rdata_OBUF[113]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[114] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[18]),
        .Q(dc_dev_rdata_OBUF[114]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[115] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[19]),
        .Q(dc_dev_rdata_OBUF[115]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[116] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[20]),
        .Q(dc_dev_rdata_OBUF[116]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[117] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[21]),
        .Q(dc_dev_rdata_OBUF[117]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[118] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[22]),
        .Q(dc_dev_rdata_OBUF[118]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[119] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[23]),
        .Q(dc_dev_rdata_OBUF[119]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[11] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[43]),
        .Q(dc_dev_rdata_OBUF[11]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[120] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[24]),
        .Q(dc_dev_rdata_OBUF[120]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[121] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[25]),
        .Q(dc_dev_rdata_OBUF[121]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[122] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[26]),
        .Q(dc_dev_rdata_OBUF[122]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[123] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[27]),
        .Q(dc_dev_rdata_OBUF[123]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[124] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[28]),
        .Q(dc_dev_rdata_OBUF[124]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[125] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[29]),
        .Q(dc_dev_rdata_OBUF[125]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[126] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[30]),
        .Q(dc_dev_rdata_OBUF[126]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[127] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[31]),
        .Q(dc_dev_rdata_OBUF[127]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[12] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[44]),
        .Q(dc_dev_rdata_OBUF[12]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[13] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[45]),
        .Q(dc_dev_rdata_OBUF[13]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[14] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[46]),
        .Q(dc_dev_rdata_OBUF[14]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[15] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[47]),
        .Q(dc_dev_rdata_OBUF[15]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[16] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[48]),
        .Q(dc_dev_rdata_OBUF[16]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[17] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[49]),
        .Q(dc_dev_rdata_OBUF[17]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[18] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[50]),
        .Q(dc_dev_rdata_OBUF[18]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[19] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[51]),
        .Q(dc_dev_rdata_OBUF[19]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[1] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[33]),
        .Q(dc_dev_rdata_OBUF[1]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[20] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[52]),
        .Q(dc_dev_rdata_OBUF[20]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[21] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[53]),
        .Q(dc_dev_rdata_OBUF[21]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[22] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[54]),
        .Q(dc_dev_rdata_OBUF[22]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[23] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[55]),
        .Q(dc_dev_rdata_OBUF[23]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[24] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[56]),
        .Q(dc_dev_rdata_OBUF[24]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[25] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[57]),
        .Q(dc_dev_rdata_OBUF[25]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[26] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[58]),
        .Q(dc_dev_rdata_OBUF[26]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[27] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[59]),
        .Q(dc_dev_rdata_OBUF[27]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[28] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[60]),
        .Q(dc_dev_rdata_OBUF[28]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[29] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[61]),
        .Q(dc_dev_rdata_OBUF[29]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[2] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[34]),
        .Q(dc_dev_rdata_OBUF[2]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[30] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[62]),
        .Q(dc_dev_rdata_OBUF[30]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[31] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[63]),
        .Q(dc_dev_rdata_OBUF[31]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[32] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[64]),
        .Q(dc_dev_rdata_OBUF[32]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[33] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[65]),
        .Q(dc_dev_rdata_OBUF[33]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[34] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[66]),
        .Q(dc_dev_rdata_OBUF[34]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[35] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[67]),
        .Q(dc_dev_rdata_OBUF[35]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[36] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[68]),
        .Q(dc_dev_rdata_OBUF[36]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[37] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[69]),
        .Q(dc_dev_rdata_OBUF[37]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[38] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[70]),
        .Q(dc_dev_rdata_OBUF[38]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[39] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[71]),
        .Q(dc_dev_rdata_OBUF[39]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[3] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[35]),
        .Q(dc_dev_rdata_OBUF[3]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[40] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[72]),
        .Q(dc_dev_rdata_OBUF[40]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[41] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[73]),
        .Q(dc_dev_rdata_OBUF[41]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[42] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[74]),
        .Q(dc_dev_rdata_OBUF[42]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[43] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[75]),
        .Q(dc_dev_rdata_OBUF[43]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[44] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[76]),
        .Q(dc_dev_rdata_OBUF[44]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[45] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[77]),
        .Q(dc_dev_rdata_OBUF[45]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[46] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[78]),
        .Q(dc_dev_rdata_OBUF[46]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[47] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[79]),
        .Q(dc_dev_rdata_OBUF[47]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[48] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[80]),
        .Q(dc_dev_rdata_OBUF[48]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[49] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[81]),
        .Q(dc_dev_rdata_OBUF[49]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[4] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[36]),
        .Q(dc_dev_rdata_OBUF[4]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[50] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[82]),
        .Q(dc_dev_rdata_OBUF[50]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[51] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[83]),
        .Q(dc_dev_rdata_OBUF[51]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[52] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[84]),
        .Q(dc_dev_rdata_OBUF[52]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[53] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[85]),
        .Q(dc_dev_rdata_OBUF[53]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[54] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[86]),
        .Q(dc_dev_rdata_OBUF[54]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[55] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[87]),
        .Q(dc_dev_rdata_OBUF[55]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[56] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[88]),
        .Q(dc_dev_rdata_OBUF[56]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[57] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[89]),
        .Q(dc_dev_rdata_OBUF[57]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[58] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[90]),
        .Q(dc_dev_rdata_OBUF[58]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[59] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[91]),
        .Q(dc_dev_rdata_OBUF[59]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[5] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[37]),
        .Q(dc_dev_rdata_OBUF[5]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[60] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[92]),
        .Q(dc_dev_rdata_OBUF[60]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[61] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[93]),
        .Q(dc_dev_rdata_OBUF[61]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[62] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[94]),
        .Q(dc_dev_rdata_OBUF[62]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[63] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[95]),
        .Q(dc_dev_rdata_OBUF[63]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[64] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[96]),
        .Q(dc_dev_rdata_OBUF[64]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[65] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[97]),
        .Q(dc_dev_rdata_OBUF[65]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[66] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[98]),
        .Q(dc_dev_rdata_OBUF[66]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[67] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[99]),
        .Q(dc_dev_rdata_OBUF[67]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[68] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[100]),
        .Q(dc_dev_rdata_OBUF[68]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[69] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[101]),
        .Q(dc_dev_rdata_OBUF[69]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[6] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[38]),
        .Q(dc_dev_rdata_OBUF[6]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[70] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[102]),
        .Q(dc_dev_rdata_OBUF[70]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[71] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[103]),
        .Q(dc_dev_rdata_OBUF[71]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[72] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[104]),
        .Q(dc_dev_rdata_OBUF[72]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[73] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[105]),
        .Q(dc_dev_rdata_OBUF[73]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[74] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[106]),
        .Q(dc_dev_rdata_OBUF[74]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[75] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[107]),
        .Q(dc_dev_rdata_OBUF[75]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[76] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[108]),
        .Q(dc_dev_rdata_OBUF[76]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[77] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[109]),
        .Q(dc_dev_rdata_OBUF[77]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[78] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[110]),
        .Q(dc_dev_rdata_OBUF[78]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[79] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[111]),
        .Q(dc_dev_rdata_OBUF[79]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[7] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[39]),
        .Q(dc_dev_rdata_OBUF[7]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[80] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[112]),
        .Q(dc_dev_rdata_OBUF[80]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[81] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[113]),
        .Q(dc_dev_rdata_OBUF[81]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[82] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[114]),
        .Q(dc_dev_rdata_OBUF[82]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[83] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[115]),
        .Q(dc_dev_rdata_OBUF[83]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[84] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[116]),
        .Q(dc_dev_rdata_OBUF[84]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[85] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[117]),
        .Q(dc_dev_rdata_OBUF[85]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[86] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[118]),
        .Q(dc_dev_rdata_OBUF[86]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[87] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[119]),
        .Q(dc_dev_rdata_OBUF[87]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[88] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[120]),
        .Q(dc_dev_rdata_OBUF[88]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[89] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[121]),
        .Q(dc_dev_rdata_OBUF[89]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[8] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[40]),
        .Q(dc_dev_rdata_OBUF[8]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[90] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[122]),
        .Q(dc_dev_rdata_OBUF[90]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[91] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[123]),
        .Q(dc_dev_rdata_OBUF[91]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[92] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[124]),
        .Q(dc_dev_rdata_OBUF[92]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[93] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[125]),
        .Q(dc_dev_rdata_OBUF[93]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[94] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[126]),
        .Q(dc_dev_rdata_OBUF[94]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[95] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[127]),
        .Q(dc_dev_rdata_OBUF[95]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[96] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[0]),
        .Q(dc_dev_rdata_OBUF[96]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[97] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[1]),
        .Q(dc_dev_rdata_OBUF[97]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[98] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[2]),
        .Q(dc_dev_rdata_OBUF[98]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[99] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[3]),
        .Q(dc_dev_rdata_OBUF[99]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[9] 
       (.C(aclk_IBUF_BUFG),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_dev_rdata_OBUF[41]),
        .Q(dc_dev_rdata_OBUF[9]));
  OBUF dc_dev_rrdy_OBUF_inst
       (.I(dc_dev_rrdy_OBUF),
        .O(dc_dev_rrdy));
  LUT4 #(
    .INIT(16'hD5C0)) 
    dc_dev_rrdy_i_1
       (.I0(has_dc_rd_req_r),
        .I1(m_axi_rvalid_IBUF),
        .I2(m_axi_rlast_IBUF),
        .I3(dc_dev_rrdy_OBUF),
        .O(dc_dev_rrdy_i_1_n_0));
  FDPE #(
    .INIT(1'b1)) 
    dc_dev_rrdy_reg
       (.C(aclk_IBUF_BUFG),
        .CE(1'b1),
        .D(dc_dev_rrdy_i_1_n_0),
        .PRE(areset_IBUF),
        .Q(dc_dev_rrdy_OBUF));
  OBUF dc_dev_rvalid_OBUF_inst
       (.I(dc_dev_rvalid_OBUF),
        .O(dc_dev_rvalid));
  LUT5 #(
    .INIT(32'h00004000)) 
    dc_dev_rvalid_i_1
       (.I0(ic_dev_rvalid_OBUF),
        .I1(m_axi_rvalid_IBUF),
        .I2(m_axi_rlast_IBUF),
        .I3(has_dc_rd_req_r),
        .I4(dc_dev_rvalid_OBUF),
        .O(dc_dev_rvalid_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    dc_dev_rvalid_reg
       (.C(aclk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(areset_IBUF),
        .D(dc_dev_rvalid_i_1_n_0),
        .Q(dc_dev_rvalid_OBUF));
  OBUF dc_dev_wrdy_OBUF_inst
       (.I(dc_dev_wrdy_OBUF),
        .O(dc_dev_wrdy));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFE0000)) 
    dc_dev_wrdy_i_1
       (.I0(dc_cpu_wen_IBUF[3]),
        .I1(dc_cpu_wen_IBUF[2]),
        .I2(dc_cpu_wen_IBUF[0]),
        .I3(dc_cpu_wen_IBUF[1]),
        .I4(dc_dev_wrdy_OBUF),
        .I5(m_axi_bvalid_IBUF),
        .O(dc_dev_wrdy_i_1_n_0));
  FDPE #(
    .INIT(1'b1)) 
    dc_dev_wrdy_reg
       (.C(aclk_IBUF_BUFG),
        .CE(dc_dev_wrdy_i_1_n_0),
        .D(m_axi_bvalid_IBUF),
        .PRE(areset_IBUF),
        .Q(dc_dev_wrdy_OBUF));
  LUT5 #(
    .INIT(32'h0FFF0888)) 
    has_dc_rd_req_r_i_1
       (.I0(dc_cpu_ren_IBUF),
        .I1(dc_dev_rrdy_OBUF),
        .I2(m_axi_rvalid_IBUF),
        .I3(m_axi_rlast_IBUF),
        .I4(has_dc_rd_req_r),
        .O(has_dc_rd_req_r_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    has_dc_rd_req_r_reg
       (.C(aclk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(areset_IBUF),
        .D(has_dc_rd_req_r_i_1_n_0),
        .Q(has_dc_rd_req_r));
  LUT5 #(
    .INIT(32'h0FFF0888)) 
    has_ic_rd_req_r_i_1
       (.I0(ic_cpu_ren_IBUF),
        .I1(ic_dev_rrdy_OBUF),
        .I2(m_axi_rvalid_IBUF),
        .I3(m_axi_rlast_IBUF),
        .I4(has_ic_rd_req_r),
        .O(has_ic_rd_req_r_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    has_ic_rd_req_r_reg
       (.C(aclk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(areset_IBUF),
        .D(has_ic_rd_req_r_i_1_n_0),
        .Q(has_ic_rd_req_r));
  IBUF \ic_cpu_raddr_IBUF[0]_inst 
       (.I(ic_cpu_raddr[0]),
        .O(ic_cpu_raddr_IBUF[0]));
  IBUF \ic_cpu_raddr_IBUF[10]_inst 
       (.I(ic_cpu_raddr[10]),
        .O(ic_cpu_raddr_IBUF[10]));
  IBUF \ic_cpu_raddr_IBUF[11]_inst 
       (.I(ic_cpu_raddr[11]),
        .O(ic_cpu_raddr_IBUF[11]));
  IBUF \ic_cpu_raddr_IBUF[12]_inst 
       (.I(ic_cpu_raddr[12]),
        .O(ic_cpu_raddr_IBUF[12]));
  IBUF \ic_cpu_raddr_IBUF[13]_inst 
       (.I(ic_cpu_raddr[13]),
        .O(ic_cpu_raddr_IBUF[13]));
  IBUF \ic_cpu_raddr_IBUF[14]_inst 
       (.I(ic_cpu_raddr[14]),
        .O(ic_cpu_raddr_IBUF[14]));
  IBUF \ic_cpu_raddr_IBUF[15]_inst 
       (.I(ic_cpu_raddr[15]),
        .O(ic_cpu_raddr_IBUF[15]));
  IBUF \ic_cpu_raddr_IBUF[16]_inst 
       (.I(ic_cpu_raddr[16]),
        .O(ic_cpu_raddr_IBUF[16]));
  IBUF \ic_cpu_raddr_IBUF[17]_inst 
       (.I(ic_cpu_raddr[17]),
        .O(ic_cpu_raddr_IBUF[17]));
  IBUF \ic_cpu_raddr_IBUF[18]_inst 
       (.I(ic_cpu_raddr[18]),
        .O(ic_cpu_raddr_IBUF[18]));
  IBUF \ic_cpu_raddr_IBUF[19]_inst 
       (.I(ic_cpu_raddr[19]),
        .O(ic_cpu_raddr_IBUF[19]));
  IBUF \ic_cpu_raddr_IBUF[1]_inst 
       (.I(ic_cpu_raddr[1]),
        .O(ic_cpu_raddr_IBUF[1]));
  IBUF \ic_cpu_raddr_IBUF[20]_inst 
       (.I(ic_cpu_raddr[20]),
        .O(ic_cpu_raddr_IBUF[20]));
  IBUF \ic_cpu_raddr_IBUF[21]_inst 
       (.I(ic_cpu_raddr[21]),
        .O(ic_cpu_raddr_IBUF[21]));
  IBUF \ic_cpu_raddr_IBUF[22]_inst 
       (.I(ic_cpu_raddr[22]),
        .O(ic_cpu_raddr_IBUF[22]));
  IBUF \ic_cpu_raddr_IBUF[23]_inst 
       (.I(ic_cpu_raddr[23]),
        .O(ic_cpu_raddr_IBUF[23]));
  IBUF \ic_cpu_raddr_IBUF[24]_inst 
       (.I(ic_cpu_raddr[24]),
        .O(ic_cpu_raddr_IBUF[24]));
  IBUF \ic_cpu_raddr_IBUF[25]_inst 
       (.I(ic_cpu_raddr[25]),
        .O(ic_cpu_raddr_IBUF[25]));
  IBUF \ic_cpu_raddr_IBUF[26]_inst 
       (.I(ic_cpu_raddr[26]),
        .O(ic_cpu_raddr_IBUF[26]));
  IBUF \ic_cpu_raddr_IBUF[27]_inst 
       (.I(ic_cpu_raddr[27]),
        .O(ic_cpu_raddr_IBUF[27]));
  IBUF \ic_cpu_raddr_IBUF[28]_inst 
       (.I(ic_cpu_raddr[28]),
        .O(ic_cpu_raddr_IBUF[28]));
  IBUF \ic_cpu_raddr_IBUF[29]_inst 
       (.I(ic_cpu_raddr[29]),
        .O(ic_cpu_raddr_IBUF[29]));
  IBUF \ic_cpu_raddr_IBUF[2]_inst 
       (.I(ic_cpu_raddr[2]),
        .O(ic_cpu_raddr_IBUF[2]));
  IBUF \ic_cpu_raddr_IBUF[30]_inst 
       (.I(ic_cpu_raddr[30]),
        .O(ic_cpu_raddr_IBUF[30]));
  IBUF \ic_cpu_raddr_IBUF[31]_inst 
       (.I(ic_cpu_raddr[31]),
        .O(ic_cpu_raddr_IBUF[31]));
  IBUF \ic_cpu_raddr_IBUF[3]_inst 
       (.I(ic_cpu_raddr[3]),
        .O(ic_cpu_raddr_IBUF[3]));
  IBUF \ic_cpu_raddr_IBUF[4]_inst 
       (.I(ic_cpu_raddr[4]),
        .O(ic_cpu_raddr_IBUF[4]));
  IBUF \ic_cpu_raddr_IBUF[5]_inst 
       (.I(ic_cpu_raddr[5]),
        .O(ic_cpu_raddr_IBUF[5]));
  IBUF \ic_cpu_raddr_IBUF[6]_inst 
       (.I(ic_cpu_raddr[6]),
        .O(ic_cpu_raddr_IBUF[6]));
  IBUF \ic_cpu_raddr_IBUF[7]_inst 
       (.I(ic_cpu_raddr[7]),
        .O(ic_cpu_raddr_IBUF[7]));
  IBUF \ic_cpu_raddr_IBUF[8]_inst 
       (.I(ic_cpu_raddr[8]),
        .O(ic_cpu_raddr_IBUF[8]));
  IBUF \ic_cpu_raddr_IBUF[9]_inst 
       (.I(ic_cpu_raddr[9]),
        .O(ic_cpu_raddr_IBUF[9]));
  IBUF ic_cpu_ren_IBUF_inst
       (.I(ic_cpu_ren),
        .O(ic_cpu_ren_IBUF));
  LUT3 #(
    .INIT(8'h20)) 
    \ic_dev_rdata[255]_i_1 
       (.I0(m_axi_rvalid_IBUF),
        .I1(has_dc_rd_req_r),
        .I2(has_ic_rd_req_r),
        .O(\ic_dev_rdata[255]_i_1_n_0 ));
  OBUF \ic_dev_rdata_OBUF[0]_inst 
       (.I(ic_dev_rdata_OBUF[0]),
        .O(ic_dev_rdata[0]));
  OBUF \ic_dev_rdata_OBUF[100]_inst 
       (.I(ic_dev_rdata_OBUF[100]),
        .O(ic_dev_rdata[100]));
  OBUF \ic_dev_rdata_OBUF[101]_inst 
       (.I(ic_dev_rdata_OBUF[101]),
        .O(ic_dev_rdata[101]));
  OBUF \ic_dev_rdata_OBUF[102]_inst 
       (.I(ic_dev_rdata_OBUF[102]),
        .O(ic_dev_rdata[102]));
  OBUF \ic_dev_rdata_OBUF[103]_inst 
       (.I(ic_dev_rdata_OBUF[103]),
        .O(ic_dev_rdata[103]));
  OBUF \ic_dev_rdata_OBUF[104]_inst 
       (.I(ic_dev_rdata_OBUF[104]),
        .O(ic_dev_rdata[104]));
  OBUF \ic_dev_rdata_OBUF[105]_inst 
       (.I(ic_dev_rdata_OBUF[105]),
        .O(ic_dev_rdata[105]));
  OBUF \ic_dev_rdata_OBUF[106]_inst 
       (.I(ic_dev_rdata_OBUF[106]),
        .O(ic_dev_rdata[106]));
  OBUF \ic_dev_rdata_OBUF[107]_inst 
       (.I(ic_dev_rdata_OBUF[107]),
        .O(ic_dev_rdata[107]));
  OBUF \ic_dev_rdata_OBUF[108]_inst 
       (.I(ic_dev_rdata_OBUF[108]),
        .O(ic_dev_rdata[108]));
  OBUF \ic_dev_rdata_OBUF[109]_inst 
       (.I(ic_dev_rdata_OBUF[109]),
        .O(ic_dev_rdata[109]));
  OBUF \ic_dev_rdata_OBUF[10]_inst 
       (.I(ic_dev_rdata_OBUF[10]),
        .O(ic_dev_rdata[10]));
  OBUF \ic_dev_rdata_OBUF[110]_inst 
       (.I(ic_dev_rdata_OBUF[110]),
        .O(ic_dev_rdata[110]));
  OBUF \ic_dev_rdata_OBUF[111]_inst 
       (.I(ic_dev_rdata_OBUF[111]),
        .O(ic_dev_rdata[111]));
  OBUF \ic_dev_rdata_OBUF[112]_inst 
       (.I(ic_dev_rdata_OBUF[112]),
        .O(ic_dev_rdata[112]));
  OBUF \ic_dev_rdata_OBUF[113]_inst 
       (.I(ic_dev_rdata_OBUF[113]),
        .O(ic_dev_rdata[113]));
  OBUF \ic_dev_rdata_OBUF[114]_inst 
       (.I(ic_dev_rdata_OBUF[114]),
        .O(ic_dev_rdata[114]));
  OBUF \ic_dev_rdata_OBUF[115]_inst 
       (.I(ic_dev_rdata_OBUF[115]),
        .O(ic_dev_rdata[115]));
  OBUF \ic_dev_rdata_OBUF[116]_inst 
       (.I(ic_dev_rdata_OBUF[116]),
        .O(ic_dev_rdata[116]));
  OBUF \ic_dev_rdata_OBUF[117]_inst 
       (.I(ic_dev_rdata_OBUF[117]),
        .O(ic_dev_rdata[117]));
  OBUF \ic_dev_rdata_OBUF[118]_inst 
       (.I(ic_dev_rdata_OBUF[118]),
        .O(ic_dev_rdata[118]));
  OBUF \ic_dev_rdata_OBUF[119]_inst 
       (.I(ic_dev_rdata_OBUF[119]),
        .O(ic_dev_rdata[119]));
  OBUF \ic_dev_rdata_OBUF[11]_inst 
       (.I(ic_dev_rdata_OBUF[11]),
        .O(ic_dev_rdata[11]));
  OBUF \ic_dev_rdata_OBUF[120]_inst 
       (.I(ic_dev_rdata_OBUF[120]),
        .O(ic_dev_rdata[120]));
  OBUF \ic_dev_rdata_OBUF[121]_inst 
       (.I(ic_dev_rdata_OBUF[121]),
        .O(ic_dev_rdata[121]));
  OBUF \ic_dev_rdata_OBUF[122]_inst 
       (.I(ic_dev_rdata_OBUF[122]),
        .O(ic_dev_rdata[122]));
  OBUF \ic_dev_rdata_OBUF[123]_inst 
       (.I(ic_dev_rdata_OBUF[123]),
        .O(ic_dev_rdata[123]));
  OBUF \ic_dev_rdata_OBUF[124]_inst 
       (.I(ic_dev_rdata_OBUF[124]),
        .O(ic_dev_rdata[124]));
  OBUF \ic_dev_rdata_OBUF[125]_inst 
       (.I(ic_dev_rdata_OBUF[125]),
        .O(ic_dev_rdata[125]));
  OBUF \ic_dev_rdata_OBUF[126]_inst 
       (.I(ic_dev_rdata_OBUF[126]),
        .O(ic_dev_rdata[126]));
  OBUF \ic_dev_rdata_OBUF[127]_inst 
       (.I(ic_dev_rdata_OBUF[127]),
        .O(ic_dev_rdata[127]));
  OBUF \ic_dev_rdata_OBUF[128]_inst 
       (.I(ic_dev_rdata_OBUF[128]),
        .O(ic_dev_rdata[128]));
  OBUF \ic_dev_rdata_OBUF[129]_inst 
       (.I(ic_dev_rdata_OBUF[129]),
        .O(ic_dev_rdata[129]));
  OBUF \ic_dev_rdata_OBUF[12]_inst 
       (.I(ic_dev_rdata_OBUF[12]),
        .O(ic_dev_rdata[12]));
  OBUF \ic_dev_rdata_OBUF[130]_inst 
       (.I(ic_dev_rdata_OBUF[130]),
        .O(ic_dev_rdata[130]));
  OBUF \ic_dev_rdata_OBUF[131]_inst 
       (.I(ic_dev_rdata_OBUF[131]),
        .O(ic_dev_rdata[131]));
  OBUF \ic_dev_rdata_OBUF[132]_inst 
       (.I(ic_dev_rdata_OBUF[132]),
        .O(ic_dev_rdata[132]));
  OBUF \ic_dev_rdata_OBUF[133]_inst 
       (.I(ic_dev_rdata_OBUF[133]),
        .O(ic_dev_rdata[133]));
  OBUF \ic_dev_rdata_OBUF[134]_inst 
       (.I(ic_dev_rdata_OBUF[134]),
        .O(ic_dev_rdata[134]));
  OBUF \ic_dev_rdata_OBUF[135]_inst 
       (.I(ic_dev_rdata_OBUF[135]),
        .O(ic_dev_rdata[135]));
  OBUF \ic_dev_rdata_OBUF[136]_inst 
       (.I(ic_dev_rdata_OBUF[136]),
        .O(ic_dev_rdata[136]));
  OBUF \ic_dev_rdata_OBUF[137]_inst 
       (.I(ic_dev_rdata_OBUF[137]),
        .O(ic_dev_rdata[137]));
  OBUF \ic_dev_rdata_OBUF[138]_inst 
       (.I(ic_dev_rdata_OBUF[138]),
        .O(ic_dev_rdata[138]));
  OBUF \ic_dev_rdata_OBUF[139]_inst 
       (.I(ic_dev_rdata_OBUF[139]),
        .O(ic_dev_rdata[139]));
  OBUF \ic_dev_rdata_OBUF[13]_inst 
       (.I(ic_dev_rdata_OBUF[13]),
        .O(ic_dev_rdata[13]));
  OBUF \ic_dev_rdata_OBUF[140]_inst 
       (.I(ic_dev_rdata_OBUF[140]),
        .O(ic_dev_rdata[140]));
  OBUF \ic_dev_rdata_OBUF[141]_inst 
       (.I(ic_dev_rdata_OBUF[141]),
        .O(ic_dev_rdata[141]));
  OBUF \ic_dev_rdata_OBUF[142]_inst 
       (.I(ic_dev_rdata_OBUF[142]),
        .O(ic_dev_rdata[142]));
  OBUF \ic_dev_rdata_OBUF[143]_inst 
       (.I(ic_dev_rdata_OBUF[143]),
        .O(ic_dev_rdata[143]));
  OBUF \ic_dev_rdata_OBUF[144]_inst 
       (.I(ic_dev_rdata_OBUF[144]),
        .O(ic_dev_rdata[144]));
  OBUF \ic_dev_rdata_OBUF[145]_inst 
       (.I(ic_dev_rdata_OBUF[145]),
        .O(ic_dev_rdata[145]));
  OBUF \ic_dev_rdata_OBUF[146]_inst 
       (.I(ic_dev_rdata_OBUF[146]),
        .O(ic_dev_rdata[146]));
  OBUF \ic_dev_rdata_OBUF[147]_inst 
       (.I(ic_dev_rdata_OBUF[147]),
        .O(ic_dev_rdata[147]));
  OBUF \ic_dev_rdata_OBUF[148]_inst 
       (.I(ic_dev_rdata_OBUF[148]),
        .O(ic_dev_rdata[148]));
  OBUF \ic_dev_rdata_OBUF[149]_inst 
       (.I(ic_dev_rdata_OBUF[149]),
        .O(ic_dev_rdata[149]));
  OBUF \ic_dev_rdata_OBUF[14]_inst 
       (.I(ic_dev_rdata_OBUF[14]),
        .O(ic_dev_rdata[14]));
  OBUF \ic_dev_rdata_OBUF[150]_inst 
       (.I(ic_dev_rdata_OBUF[150]),
        .O(ic_dev_rdata[150]));
  OBUF \ic_dev_rdata_OBUF[151]_inst 
       (.I(ic_dev_rdata_OBUF[151]),
        .O(ic_dev_rdata[151]));
  OBUF \ic_dev_rdata_OBUF[152]_inst 
       (.I(ic_dev_rdata_OBUF[152]),
        .O(ic_dev_rdata[152]));
  OBUF \ic_dev_rdata_OBUF[153]_inst 
       (.I(ic_dev_rdata_OBUF[153]),
        .O(ic_dev_rdata[153]));
  OBUF \ic_dev_rdata_OBUF[154]_inst 
       (.I(ic_dev_rdata_OBUF[154]),
        .O(ic_dev_rdata[154]));
  OBUF \ic_dev_rdata_OBUF[155]_inst 
       (.I(ic_dev_rdata_OBUF[155]),
        .O(ic_dev_rdata[155]));
  OBUF \ic_dev_rdata_OBUF[156]_inst 
       (.I(ic_dev_rdata_OBUF[156]),
        .O(ic_dev_rdata[156]));
  OBUF \ic_dev_rdata_OBUF[157]_inst 
       (.I(ic_dev_rdata_OBUF[157]),
        .O(ic_dev_rdata[157]));
  OBUF \ic_dev_rdata_OBUF[158]_inst 
       (.I(ic_dev_rdata_OBUF[158]),
        .O(ic_dev_rdata[158]));
  OBUF \ic_dev_rdata_OBUF[159]_inst 
       (.I(ic_dev_rdata_OBUF[159]),
        .O(ic_dev_rdata[159]));
  OBUF \ic_dev_rdata_OBUF[15]_inst 
       (.I(ic_dev_rdata_OBUF[15]),
        .O(ic_dev_rdata[15]));
  OBUF \ic_dev_rdata_OBUF[160]_inst 
       (.I(ic_dev_rdata_OBUF[160]),
        .O(ic_dev_rdata[160]));
  OBUF \ic_dev_rdata_OBUF[161]_inst 
       (.I(ic_dev_rdata_OBUF[161]),
        .O(ic_dev_rdata[161]));
  OBUF \ic_dev_rdata_OBUF[162]_inst 
       (.I(ic_dev_rdata_OBUF[162]),
        .O(ic_dev_rdata[162]));
  OBUF \ic_dev_rdata_OBUF[163]_inst 
       (.I(ic_dev_rdata_OBUF[163]),
        .O(ic_dev_rdata[163]));
  OBUF \ic_dev_rdata_OBUF[164]_inst 
       (.I(ic_dev_rdata_OBUF[164]),
        .O(ic_dev_rdata[164]));
  OBUF \ic_dev_rdata_OBUF[165]_inst 
       (.I(ic_dev_rdata_OBUF[165]),
        .O(ic_dev_rdata[165]));
  OBUF \ic_dev_rdata_OBUF[166]_inst 
       (.I(ic_dev_rdata_OBUF[166]),
        .O(ic_dev_rdata[166]));
  OBUF \ic_dev_rdata_OBUF[167]_inst 
       (.I(ic_dev_rdata_OBUF[167]),
        .O(ic_dev_rdata[167]));
  OBUF \ic_dev_rdata_OBUF[168]_inst 
       (.I(ic_dev_rdata_OBUF[168]),
        .O(ic_dev_rdata[168]));
  OBUF \ic_dev_rdata_OBUF[169]_inst 
       (.I(ic_dev_rdata_OBUF[169]),
        .O(ic_dev_rdata[169]));
  OBUF \ic_dev_rdata_OBUF[16]_inst 
       (.I(ic_dev_rdata_OBUF[16]),
        .O(ic_dev_rdata[16]));
  OBUF \ic_dev_rdata_OBUF[170]_inst 
       (.I(ic_dev_rdata_OBUF[170]),
        .O(ic_dev_rdata[170]));
  OBUF \ic_dev_rdata_OBUF[171]_inst 
       (.I(ic_dev_rdata_OBUF[171]),
        .O(ic_dev_rdata[171]));
  OBUF \ic_dev_rdata_OBUF[172]_inst 
       (.I(ic_dev_rdata_OBUF[172]),
        .O(ic_dev_rdata[172]));
  OBUF \ic_dev_rdata_OBUF[173]_inst 
       (.I(ic_dev_rdata_OBUF[173]),
        .O(ic_dev_rdata[173]));
  OBUF \ic_dev_rdata_OBUF[174]_inst 
       (.I(ic_dev_rdata_OBUF[174]),
        .O(ic_dev_rdata[174]));
  OBUF \ic_dev_rdata_OBUF[175]_inst 
       (.I(ic_dev_rdata_OBUF[175]),
        .O(ic_dev_rdata[175]));
  OBUF \ic_dev_rdata_OBUF[176]_inst 
       (.I(ic_dev_rdata_OBUF[176]),
        .O(ic_dev_rdata[176]));
  OBUF \ic_dev_rdata_OBUF[177]_inst 
       (.I(ic_dev_rdata_OBUF[177]),
        .O(ic_dev_rdata[177]));
  OBUF \ic_dev_rdata_OBUF[178]_inst 
       (.I(ic_dev_rdata_OBUF[178]),
        .O(ic_dev_rdata[178]));
  OBUF \ic_dev_rdata_OBUF[179]_inst 
       (.I(ic_dev_rdata_OBUF[179]),
        .O(ic_dev_rdata[179]));
  OBUF \ic_dev_rdata_OBUF[17]_inst 
       (.I(ic_dev_rdata_OBUF[17]),
        .O(ic_dev_rdata[17]));
  OBUF \ic_dev_rdata_OBUF[180]_inst 
       (.I(ic_dev_rdata_OBUF[180]),
        .O(ic_dev_rdata[180]));
  OBUF \ic_dev_rdata_OBUF[181]_inst 
       (.I(ic_dev_rdata_OBUF[181]),
        .O(ic_dev_rdata[181]));
  OBUF \ic_dev_rdata_OBUF[182]_inst 
       (.I(ic_dev_rdata_OBUF[182]),
        .O(ic_dev_rdata[182]));
  OBUF \ic_dev_rdata_OBUF[183]_inst 
       (.I(ic_dev_rdata_OBUF[183]),
        .O(ic_dev_rdata[183]));
  OBUF \ic_dev_rdata_OBUF[184]_inst 
       (.I(ic_dev_rdata_OBUF[184]),
        .O(ic_dev_rdata[184]));
  OBUF \ic_dev_rdata_OBUF[185]_inst 
       (.I(ic_dev_rdata_OBUF[185]),
        .O(ic_dev_rdata[185]));
  OBUF \ic_dev_rdata_OBUF[186]_inst 
       (.I(ic_dev_rdata_OBUF[186]),
        .O(ic_dev_rdata[186]));
  OBUF \ic_dev_rdata_OBUF[187]_inst 
       (.I(ic_dev_rdata_OBUF[187]),
        .O(ic_dev_rdata[187]));
  OBUF \ic_dev_rdata_OBUF[188]_inst 
       (.I(ic_dev_rdata_OBUF[188]),
        .O(ic_dev_rdata[188]));
  OBUF \ic_dev_rdata_OBUF[189]_inst 
       (.I(ic_dev_rdata_OBUF[189]),
        .O(ic_dev_rdata[189]));
  OBUF \ic_dev_rdata_OBUF[18]_inst 
       (.I(ic_dev_rdata_OBUF[18]),
        .O(ic_dev_rdata[18]));
  OBUF \ic_dev_rdata_OBUF[190]_inst 
       (.I(ic_dev_rdata_OBUF[190]),
        .O(ic_dev_rdata[190]));
  OBUF \ic_dev_rdata_OBUF[191]_inst 
       (.I(ic_dev_rdata_OBUF[191]),
        .O(ic_dev_rdata[191]));
  OBUF \ic_dev_rdata_OBUF[192]_inst 
       (.I(ic_dev_rdata_OBUF[192]),
        .O(ic_dev_rdata[192]));
  OBUF \ic_dev_rdata_OBUF[193]_inst 
       (.I(ic_dev_rdata_OBUF[193]),
        .O(ic_dev_rdata[193]));
  OBUF \ic_dev_rdata_OBUF[194]_inst 
       (.I(ic_dev_rdata_OBUF[194]),
        .O(ic_dev_rdata[194]));
  OBUF \ic_dev_rdata_OBUF[195]_inst 
       (.I(ic_dev_rdata_OBUF[195]),
        .O(ic_dev_rdata[195]));
  OBUF \ic_dev_rdata_OBUF[196]_inst 
       (.I(ic_dev_rdata_OBUF[196]),
        .O(ic_dev_rdata[196]));
  OBUF \ic_dev_rdata_OBUF[197]_inst 
       (.I(ic_dev_rdata_OBUF[197]),
        .O(ic_dev_rdata[197]));
  OBUF \ic_dev_rdata_OBUF[198]_inst 
       (.I(ic_dev_rdata_OBUF[198]),
        .O(ic_dev_rdata[198]));
  OBUF \ic_dev_rdata_OBUF[199]_inst 
       (.I(ic_dev_rdata_OBUF[199]),
        .O(ic_dev_rdata[199]));
  OBUF \ic_dev_rdata_OBUF[19]_inst 
       (.I(ic_dev_rdata_OBUF[19]),
        .O(ic_dev_rdata[19]));
  OBUF \ic_dev_rdata_OBUF[1]_inst 
       (.I(ic_dev_rdata_OBUF[1]),
        .O(ic_dev_rdata[1]));
  OBUF \ic_dev_rdata_OBUF[200]_inst 
       (.I(ic_dev_rdata_OBUF[200]),
        .O(ic_dev_rdata[200]));
  OBUF \ic_dev_rdata_OBUF[201]_inst 
       (.I(ic_dev_rdata_OBUF[201]),
        .O(ic_dev_rdata[201]));
  OBUF \ic_dev_rdata_OBUF[202]_inst 
       (.I(ic_dev_rdata_OBUF[202]),
        .O(ic_dev_rdata[202]));
  OBUF \ic_dev_rdata_OBUF[203]_inst 
       (.I(ic_dev_rdata_OBUF[203]),
        .O(ic_dev_rdata[203]));
  OBUF \ic_dev_rdata_OBUF[204]_inst 
       (.I(ic_dev_rdata_OBUF[204]),
        .O(ic_dev_rdata[204]));
  OBUF \ic_dev_rdata_OBUF[205]_inst 
       (.I(ic_dev_rdata_OBUF[205]),
        .O(ic_dev_rdata[205]));
  OBUF \ic_dev_rdata_OBUF[206]_inst 
       (.I(ic_dev_rdata_OBUF[206]),
        .O(ic_dev_rdata[206]));
  OBUF \ic_dev_rdata_OBUF[207]_inst 
       (.I(ic_dev_rdata_OBUF[207]),
        .O(ic_dev_rdata[207]));
  OBUF \ic_dev_rdata_OBUF[208]_inst 
       (.I(ic_dev_rdata_OBUF[208]),
        .O(ic_dev_rdata[208]));
  OBUF \ic_dev_rdata_OBUF[209]_inst 
       (.I(ic_dev_rdata_OBUF[209]),
        .O(ic_dev_rdata[209]));
  OBUF \ic_dev_rdata_OBUF[20]_inst 
       (.I(ic_dev_rdata_OBUF[20]),
        .O(ic_dev_rdata[20]));
  OBUF \ic_dev_rdata_OBUF[210]_inst 
       (.I(ic_dev_rdata_OBUF[210]),
        .O(ic_dev_rdata[210]));
  OBUF \ic_dev_rdata_OBUF[211]_inst 
       (.I(ic_dev_rdata_OBUF[211]),
        .O(ic_dev_rdata[211]));
  OBUF \ic_dev_rdata_OBUF[212]_inst 
       (.I(ic_dev_rdata_OBUF[212]),
        .O(ic_dev_rdata[212]));
  OBUF \ic_dev_rdata_OBUF[213]_inst 
       (.I(ic_dev_rdata_OBUF[213]),
        .O(ic_dev_rdata[213]));
  OBUF \ic_dev_rdata_OBUF[214]_inst 
       (.I(ic_dev_rdata_OBUF[214]),
        .O(ic_dev_rdata[214]));
  OBUF \ic_dev_rdata_OBUF[215]_inst 
       (.I(ic_dev_rdata_OBUF[215]),
        .O(ic_dev_rdata[215]));
  OBUF \ic_dev_rdata_OBUF[216]_inst 
       (.I(ic_dev_rdata_OBUF[216]),
        .O(ic_dev_rdata[216]));
  OBUF \ic_dev_rdata_OBUF[217]_inst 
       (.I(ic_dev_rdata_OBUF[217]),
        .O(ic_dev_rdata[217]));
  OBUF \ic_dev_rdata_OBUF[218]_inst 
       (.I(ic_dev_rdata_OBUF[218]),
        .O(ic_dev_rdata[218]));
  OBUF \ic_dev_rdata_OBUF[219]_inst 
       (.I(ic_dev_rdata_OBUF[219]),
        .O(ic_dev_rdata[219]));
  OBUF \ic_dev_rdata_OBUF[21]_inst 
       (.I(ic_dev_rdata_OBUF[21]),
        .O(ic_dev_rdata[21]));
  OBUF \ic_dev_rdata_OBUF[220]_inst 
       (.I(ic_dev_rdata_OBUF[220]),
        .O(ic_dev_rdata[220]));
  OBUF \ic_dev_rdata_OBUF[221]_inst 
       (.I(ic_dev_rdata_OBUF[221]),
        .O(ic_dev_rdata[221]));
  OBUF \ic_dev_rdata_OBUF[222]_inst 
       (.I(ic_dev_rdata_OBUF[222]),
        .O(ic_dev_rdata[222]));
  OBUF \ic_dev_rdata_OBUF[223]_inst 
       (.I(ic_dev_rdata_OBUF[223]),
        .O(ic_dev_rdata[223]));
  OBUF \ic_dev_rdata_OBUF[224]_inst 
       (.I(ic_dev_rdata_OBUF[224]),
        .O(ic_dev_rdata[224]));
  OBUF \ic_dev_rdata_OBUF[225]_inst 
       (.I(ic_dev_rdata_OBUF[225]),
        .O(ic_dev_rdata[225]));
  OBUF \ic_dev_rdata_OBUF[226]_inst 
       (.I(ic_dev_rdata_OBUF[226]),
        .O(ic_dev_rdata[226]));
  OBUF \ic_dev_rdata_OBUF[227]_inst 
       (.I(ic_dev_rdata_OBUF[227]),
        .O(ic_dev_rdata[227]));
  OBUF \ic_dev_rdata_OBUF[228]_inst 
       (.I(ic_dev_rdata_OBUF[228]),
        .O(ic_dev_rdata[228]));
  OBUF \ic_dev_rdata_OBUF[229]_inst 
       (.I(ic_dev_rdata_OBUF[229]),
        .O(ic_dev_rdata[229]));
  OBUF \ic_dev_rdata_OBUF[22]_inst 
       (.I(ic_dev_rdata_OBUF[22]),
        .O(ic_dev_rdata[22]));
  OBUF \ic_dev_rdata_OBUF[230]_inst 
       (.I(ic_dev_rdata_OBUF[230]),
        .O(ic_dev_rdata[230]));
  OBUF \ic_dev_rdata_OBUF[231]_inst 
       (.I(ic_dev_rdata_OBUF[231]),
        .O(ic_dev_rdata[231]));
  OBUF \ic_dev_rdata_OBUF[232]_inst 
       (.I(ic_dev_rdata_OBUF[232]),
        .O(ic_dev_rdata[232]));
  OBUF \ic_dev_rdata_OBUF[233]_inst 
       (.I(ic_dev_rdata_OBUF[233]),
        .O(ic_dev_rdata[233]));
  OBUF \ic_dev_rdata_OBUF[234]_inst 
       (.I(ic_dev_rdata_OBUF[234]),
        .O(ic_dev_rdata[234]));
  OBUF \ic_dev_rdata_OBUF[235]_inst 
       (.I(ic_dev_rdata_OBUF[235]),
        .O(ic_dev_rdata[235]));
  OBUF \ic_dev_rdata_OBUF[236]_inst 
       (.I(ic_dev_rdata_OBUF[236]),
        .O(ic_dev_rdata[236]));
  OBUF \ic_dev_rdata_OBUF[237]_inst 
       (.I(ic_dev_rdata_OBUF[237]),
        .O(ic_dev_rdata[237]));
  OBUF \ic_dev_rdata_OBUF[238]_inst 
       (.I(ic_dev_rdata_OBUF[238]),
        .O(ic_dev_rdata[238]));
  OBUF \ic_dev_rdata_OBUF[239]_inst 
       (.I(ic_dev_rdata_OBUF[239]),
        .O(ic_dev_rdata[239]));
  OBUF \ic_dev_rdata_OBUF[23]_inst 
       (.I(ic_dev_rdata_OBUF[23]),
        .O(ic_dev_rdata[23]));
  OBUF \ic_dev_rdata_OBUF[240]_inst 
       (.I(ic_dev_rdata_OBUF[240]),
        .O(ic_dev_rdata[240]));
  OBUF \ic_dev_rdata_OBUF[241]_inst 
       (.I(ic_dev_rdata_OBUF[241]),
        .O(ic_dev_rdata[241]));
  OBUF \ic_dev_rdata_OBUF[242]_inst 
       (.I(ic_dev_rdata_OBUF[242]),
        .O(ic_dev_rdata[242]));
  OBUF \ic_dev_rdata_OBUF[243]_inst 
       (.I(ic_dev_rdata_OBUF[243]),
        .O(ic_dev_rdata[243]));
  OBUF \ic_dev_rdata_OBUF[244]_inst 
       (.I(ic_dev_rdata_OBUF[244]),
        .O(ic_dev_rdata[244]));
  OBUF \ic_dev_rdata_OBUF[245]_inst 
       (.I(ic_dev_rdata_OBUF[245]),
        .O(ic_dev_rdata[245]));
  OBUF \ic_dev_rdata_OBUF[246]_inst 
       (.I(ic_dev_rdata_OBUF[246]),
        .O(ic_dev_rdata[246]));
  OBUF \ic_dev_rdata_OBUF[247]_inst 
       (.I(ic_dev_rdata_OBUF[247]),
        .O(ic_dev_rdata[247]));
  OBUF \ic_dev_rdata_OBUF[248]_inst 
       (.I(ic_dev_rdata_OBUF[248]),
        .O(ic_dev_rdata[248]));
  OBUF \ic_dev_rdata_OBUF[249]_inst 
       (.I(ic_dev_rdata_OBUF[249]),
        .O(ic_dev_rdata[249]));
  OBUF \ic_dev_rdata_OBUF[24]_inst 
       (.I(ic_dev_rdata_OBUF[24]),
        .O(ic_dev_rdata[24]));
  OBUF \ic_dev_rdata_OBUF[250]_inst 
       (.I(ic_dev_rdata_OBUF[250]),
        .O(ic_dev_rdata[250]));
  OBUF \ic_dev_rdata_OBUF[251]_inst 
       (.I(ic_dev_rdata_OBUF[251]),
        .O(ic_dev_rdata[251]));
  OBUF \ic_dev_rdata_OBUF[252]_inst 
       (.I(ic_dev_rdata_OBUF[252]),
        .O(ic_dev_rdata[252]));
  OBUF \ic_dev_rdata_OBUF[253]_inst 
       (.I(ic_dev_rdata_OBUF[253]),
        .O(ic_dev_rdata[253]));
  OBUF \ic_dev_rdata_OBUF[254]_inst 
       (.I(ic_dev_rdata_OBUF[254]),
        .O(ic_dev_rdata[254]));
  OBUF \ic_dev_rdata_OBUF[255]_inst 
       (.I(ic_dev_rdata_OBUF[255]),
        .O(ic_dev_rdata[255]));
  OBUF \ic_dev_rdata_OBUF[25]_inst 
       (.I(ic_dev_rdata_OBUF[25]),
        .O(ic_dev_rdata[25]));
  OBUF \ic_dev_rdata_OBUF[26]_inst 
       (.I(ic_dev_rdata_OBUF[26]),
        .O(ic_dev_rdata[26]));
  OBUF \ic_dev_rdata_OBUF[27]_inst 
       (.I(ic_dev_rdata_OBUF[27]),
        .O(ic_dev_rdata[27]));
  OBUF \ic_dev_rdata_OBUF[28]_inst 
       (.I(ic_dev_rdata_OBUF[28]),
        .O(ic_dev_rdata[28]));
  OBUF \ic_dev_rdata_OBUF[29]_inst 
       (.I(ic_dev_rdata_OBUF[29]),
        .O(ic_dev_rdata[29]));
  OBUF \ic_dev_rdata_OBUF[2]_inst 
       (.I(ic_dev_rdata_OBUF[2]),
        .O(ic_dev_rdata[2]));
  OBUF \ic_dev_rdata_OBUF[30]_inst 
       (.I(ic_dev_rdata_OBUF[30]),
        .O(ic_dev_rdata[30]));
  OBUF \ic_dev_rdata_OBUF[31]_inst 
       (.I(ic_dev_rdata_OBUF[31]),
        .O(ic_dev_rdata[31]));
  OBUF \ic_dev_rdata_OBUF[32]_inst 
       (.I(ic_dev_rdata_OBUF[32]),
        .O(ic_dev_rdata[32]));
  OBUF \ic_dev_rdata_OBUF[33]_inst 
       (.I(ic_dev_rdata_OBUF[33]),
        .O(ic_dev_rdata[33]));
  OBUF \ic_dev_rdata_OBUF[34]_inst 
       (.I(ic_dev_rdata_OBUF[34]),
        .O(ic_dev_rdata[34]));
  OBUF \ic_dev_rdata_OBUF[35]_inst 
       (.I(ic_dev_rdata_OBUF[35]),
        .O(ic_dev_rdata[35]));
  OBUF \ic_dev_rdata_OBUF[36]_inst 
       (.I(ic_dev_rdata_OBUF[36]),
        .O(ic_dev_rdata[36]));
  OBUF \ic_dev_rdata_OBUF[37]_inst 
       (.I(ic_dev_rdata_OBUF[37]),
        .O(ic_dev_rdata[37]));
  OBUF \ic_dev_rdata_OBUF[38]_inst 
       (.I(ic_dev_rdata_OBUF[38]),
        .O(ic_dev_rdata[38]));
  OBUF \ic_dev_rdata_OBUF[39]_inst 
       (.I(ic_dev_rdata_OBUF[39]),
        .O(ic_dev_rdata[39]));
  OBUF \ic_dev_rdata_OBUF[3]_inst 
       (.I(ic_dev_rdata_OBUF[3]),
        .O(ic_dev_rdata[3]));
  OBUF \ic_dev_rdata_OBUF[40]_inst 
       (.I(ic_dev_rdata_OBUF[40]),
        .O(ic_dev_rdata[40]));
  OBUF \ic_dev_rdata_OBUF[41]_inst 
       (.I(ic_dev_rdata_OBUF[41]),
        .O(ic_dev_rdata[41]));
  OBUF \ic_dev_rdata_OBUF[42]_inst 
       (.I(ic_dev_rdata_OBUF[42]),
        .O(ic_dev_rdata[42]));
  OBUF \ic_dev_rdata_OBUF[43]_inst 
       (.I(ic_dev_rdata_OBUF[43]),
        .O(ic_dev_rdata[43]));
  OBUF \ic_dev_rdata_OBUF[44]_inst 
       (.I(ic_dev_rdata_OBUF[44]),
        .O(ic_dev_rdata[44]));
  OBUF \ic_dev_rdata_OBUF[45]_inst 
       (.I(ic_dev_rdata_OBUF[45]),
        .O(ic_dev_rdata[45]));
  OBUF \ic_dev_rdata_OBUF[46]_inst 
       (.I(ic_dev_rdata_OBUF[46]),
        .O(ic_dev_rdata[46]));
  OBUF \ic_dev_rdata_OBUF[47]_inst 
       (.I(ic_dev_rdata_OBUF[47]),
        .O(ic_dev_rdata[47]));
  OBUF \ic_dev_rdata_OBUF[48]_inst 
       (.I(ic_dev_rdata_OBUF[48]),
        .O(ic_dev_rdata[48]));
  OBUF \ic_dev_rdata_OBUF[49]_inst 
       (.I(ic_dev_rdata_OBUF[49]),
        .O(ic_dev_rdata[49]));
  OBUF \ic_dev_rdata_OBUF[4]_inst 
       (.I(ic_dev_rdata_OBUF[4]),
        .O(ic_dev_rdata[4]));
  OBUF \ic_dev_rdata_OBUF[50]_inst 
       (.I(ic_dev_rdata_OBUF[50]),
        .O(ic_dev_rdata[50]));
  OBUF \ic_dev_rdata_OBUF[51]_inst 
       (.I(ic_dev_rdata_OBUF[51]),
        .O(ic_dev_rdata[51]));
  OBUF \ic_dev_rdata_OBUF[52]_inst 
       (.I(ic_dev_rdata_OBUF[52]),
        .O(ic_dev_rdata[52]));
  OBUF \ic_dev_rdata_OBUF[53]_inst 
       (.I(ic_dev_rdata_OBUF[53]),
        .O(ic_dev_rdata[53]));
  OBUF \ic_dev_rdata_OBUF[54]_inst 
       (.I(ic_dev_rdata_OBUF[54]),
        .O(ic_dev_rdata[54]));
  OBUF \ic_dev_rdata_OBUF[55]_inst 
       (.I(ic_dev_rdata_OBUF[55]),
        .O(ic_dev_rdata[55]));
  OBUF \ic_dev_rdata_OBUF[56]_inst 
       (.I(ic_dev_rdata_OBUF[56]),
        .O(ic_dev_rdata[56]));
  OBUF \ic_dev_rdata_OBUF[57]_inst 
       (.I(ic_dev_rdata_OBUF[57]),
        .O(ic_dev_rdata[57]));
  OBUF \ic_dev_rdata_OBUF[58]_inst 
       (.I(ic_dev_rdata_OBUF[58]),
        .O(ic_dev_rdata[58]));
  OBUF \ic_dev_rdata_OBUF[59]_inst 
       (.I(ic_dev_rdata_OBUF[59]),
        .O(ic_dev_rdata[59]));
  OBUF \ic_dev_rdata_OBUF[5]_inst 
       (.I(ic_dev_rdata_OBUF[5]),
        .O(ic_dev_rdata[5]));
  OBUF \ic_dev_rdata_OBUF[60]_inst 
       (.I(ic_dev_rdata_OBUF[60]),
        .O(ic_dev_rdata[60]));
  OBUF \ic_dev_rdata_OBUF[61]_inst 
       (.I(ic_dev_rdata_OBUF[61]),
        .O(ic_dev_rdata[61]));
  OBUF \ic_dev_rdata_OBUF[62]_inst 
       (.I(ic_dev_rdata_OBUF[62]),
        .O(ic_dev_rdata[62]));
  OBUF \ic_dev_rdata_OBUF[63]_inst 
       (.I(ic_dev_rdata_OBUF[63]),
        .O(ic_dev_rdata[63]));
  OBUF \ic_dev_rdata_OBUF[64]_inst 
       (.I(ic_dev_rdata_OBUF[64]),
        .O(ic_dev_rdata[64]));
  OBUF \ic_dev_rdata_OBUF[65]_inst 
       (.I(ic_dev_rdata_OBUF[65]),
        .O(ic_dev_rdata[65]));
  OBUF \ic_dev_rdata_OBUF[66]_inst 
       (.I(ic_dev_rdata_OBUF[66]),
        .O(ic_dev_rdata[66]));
  OBUF \ic_dev_rdata_OBUF[67]_inst 
       (.I(ic_dev_rdata_OBUF[67]),
        .O(ic_dev_rdata[67]));
  OBUF \ic_dev_rdata_OBUF[68]_inst 
       (.I(ic_dev_rdata_OBUF[68]),
        .O(ic_dev_rdata[68]));
  OBUF \ic_dev_rdata_OBUF[69]_inst 
       (.I(ic_dev_rdata_OBUF[69]),
        .O(ic_dev_rdata[69]));
  OBUF \ic_dev_rdata_OBUF[6]_inst 
       (.I(ic_dev_rdata_OBUF[6]),
        .O(ic_dev_rdata[6]));
  OBUF \ic_dev_rdata_OBUF[70]_inst 
       (.I(ic_dev_rdata_OBUF[70]),
        .O(ic_dev_rdata[70]));
  OBUF \ic_dev_rdata_OBUF[71]_inst 
       (.I(ic_dev_rdata_OBUF[71]),
        .O(ic_dev_rdata[71]));
  OBUF \ic_dev_rdata_OBUF[72]_inst 
       (.I(ic_dev_rdata_OBUF[72]),
        .O(ic_dev_rdata[72]));
  OBUF \ic_dev_rdata_OBUF[73]_inst 
       (.I(ic_dev_rdata_OBUF[73]),
        .O(ic_dev_rdata[73]));
  OBUF \ic_dev_rdata_OBUF[74]_inst 
       (.I(ic_dev_rdata_OBUF[74]),
        .O(ic_dev_rdata[74]));
  OBUF \ic_dev_rdata_OBUF[75]_inst 
       (.I(ic_dev_rdata_OBUF[75]),
        .O(ic_dev_rdata[75]));
  OBUF \ic_dev_rdata_OBUF[76]_inst 
       (.I(ic_dev_rdata_OBUF[76]),
        .O(ic_dev_rdata[76]));
  OBUF \ic_dev_rdata_OBUF[77]_inst 
       (.I(ic_dev_rdata_OBUF[77]),
        .O(ic_dev_rdata[77]));
  OBUF \ic_dev_rdata_OBUF[78]_inst 
       (.I(ic_dev_rdata_OBUF[78]),
        .O(ic_dev_rdata[78]));
  OBUF \ic_dev_rdata_OBUF[79]_inst 
       (.I(ic_dev_rdata_OBUF[79]),
        .O(ic_dev_rdata[79]));
  OBUF \ic_dev_rdata_OBUF[7]_inst 
       (.I(ic_dev_rdata_OBUF[7]),
        .O(ic_dev_rdata[7]));
  OBUF \ic_dev_rdata_OBUF[80]_inst 
       (.I(ic_dev_rdata_OBUF[80]),
        .O(ic_dev_rdata[80]));
  OBUF \ic_dev_rdata_OBUF[81]_inst 
       (.I(ic_dev_rdata_OBUF[81]),
        .O(ic_dev_rdata[81]));
  OBUF \ic_dev_rdata_OBUF[82]_inst 
       (.I(ic_dev_rdata_OBUF[82]),
        .O(ic_dev_rdata[82]));
  OBUF \ic_dev_rdata_OBUF[83]_inst 
       (.I(ic_dev_rdata_OBUF[83]),
        .O(ic_dev_rdata[83]));
  OBUF \ic_dev_rdata_OBUF[84]_inst 
       (.I(ic_dev_rdata_OBUF[84]),
        .O(ic_dev_rdata[84]));
  OBUF \ic_dev_rdata_OBUF[85]_inst 
       (.I(ic_dev_rdata_OBUF[85]),
        .O(ic_dev_rdata[85]));
  OBUF \ic_dev_rdata_OBUF[86]_inst 
       (.I(ic_dev_rdata_OBUF[86]),
        .O(ic_dev_rdata[86]));
  OBUF \ic_dev_rdata_OBUF[87]_inst 
       (.I(ic_dev_rdata_OBUF[87]),
        .O(ic_dev_rdata[87]));
  OBUF \ic_dev_rdata_OBUF[88]_inst 
       (.I(ic_dev_rdata_OBUF[88]),
        .O(ic_dev_rdata[88]));
  OBUF \ic_dev_rdata_OBUF[89]_inst 
       (.I(ic_dev_rdata_OBUF[89]),
        .O(ic_dev_rdata[89]));
  OBUF \ic_dev_rdata_OBUF[8]_inst 
       (.I(ic_dev_rdata_OBUF[8]),
        .O(ic_dev_rdata[8]));
  OBUF \ic_dev_rdata_OBUF[90]_inst 
       (.I(ic_dev_rdata_OBUF[90]),
        .O(ic_dev_rdata[90]));
  OBUF \ic_dev_rdata_OBUF[91]_inst 
       (.I(ic_dev_rdata_OBUF[91]),
        .O(ic_dev_rdata[91]));
  OBUF \ic_dev_rdata_OBUF[92]_inst 
       (.I(ic_dev_rdata_OBUF[92]),
        .O(ic_dev_rdata[92]));
  OBUF \ic_dev_rdata_OBUF[93]_inst 
       (.I(ic_dev_rdata_OBUF[93]),
        .O(ic_dev_rdata[93]));
  OBUF \ic_dev_rdata_OBUF[94]_inst 
       (.I(ic_dev_rdata_OBUF[94]),
        .O(ic_dev_rdata[94]));
  OBUF \ic_dev_rdata_OBUF[95]_inst 
       (.I(ic_dev_rdata_OBUF[95]),
        .O(ic_dev_rdata[95]));
  OBUF \ic_dev_rdata_OBUF[96]_inst 
       (.I(ic_dev_rdata_OBUF[96]),
        .O(ic_dev_rdata[96]));
  OBUF \ic_dev_rdata_OBUF[97]_inst 
       (.I(ic_dev_rdata_OBUF[97]),
        .O(ic_dev_rdata[97]));
  OBUF \ic_dev_rdata_OBUF[98]_inst 
       (.I(ic_dev_rdata_OBUF[98]),
        .O(ic_dev_rdata[98]));
  OBUF \ic_dev_rdata_OBUF[99]_inst 
       (.I(ic_dev_rdata_OBUF[99]),
        .O(ic_dev_rdata[99]));
  OBUF \ic_dev_rdata_OBUF[9]_inst 
       (.I(ic_dev_rdata_OBUF[9]),
        .O(ic_dev_rdata[9]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[0] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[32]),
        .Q(ic_dev_rdata_OBUF[0]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[100] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[132]),
        .Q(ic_dev_rdata_OBUF[100]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[101] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[133]),
        .Q(ic_dev_rdata_OBUF[101]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[102] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[134]),
        .Q(ic_dev_rdata_OBUF[102]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[103] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[135]),
        .Q(ic_dev_rdata_OBUF[103]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[104] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[136]),
        .Q(ic_dev_rdata_OBUF[104]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[105] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[137]),
        .Q(ic_dev_rdata_OBUF[105]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[106] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[138]),
        .Q(ic_dev_rdata_OBUF[106]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[107] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[139]),
        .Q(ic_dev_rdata_OBUF[107]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[108] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[140]),
        .Q(ic_dev_rdata_OBUF[108]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[109] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[141]),
        .Q(ic_dev_rdata_OBUF[109]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[10] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[42]),
        .Q(ic_dev_rdata_OBUF[10]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[110] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[142]),
        .Q(ic_dev_rdata_OBUF[110]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[111] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[143]),
        .Q(ic_dev_rdata_OBUF[111]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[112] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[144]),
        .Q(ic_dev_rdata_OBUF[112]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[113] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[145]),
        .Q(ic_dev_rdata_OBUF[113]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[114] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[146]),
        .Q(ic_dev_rdata_OBUF[114]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[115] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[147]),
        .Q(ic_dev_rdata_OBUF[115]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[116] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[148]),
        .Q(ic_dev_rdata_OBUF[116]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[117] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[149]),
        .Q(ic_dev_rdata_OBUF[117]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[118] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[150]),
        .Q(ic_dev_rdata_OBUF[118]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[119] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[151]),
        .Q(ic_dev_rdata_OBUF[119]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[11] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[43]),
        .Q(ic_dev_rdata_OBUF[11]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[120] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[152]),
        .Q(ic_dev_rdata_OBUF[120]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[121] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[153]),
        .Q(ic_dev_rdata_OBUF[121]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[122] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[154]),
        .Q(ic_dev_rdata_OBUF[122]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[123] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[155]),
        .Q(ic_dev_rdata_OBUF[123]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[124] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[156]),
        .Q(ic_dev_rdata_OBUF[124]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[125] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[157]),
        .Q(ic_dev_rdata_OBUF[125]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[126] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[158]),
        .Q(ic_dev_rdata_OBUF[126]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[127] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[159]),
        .Q(ic_dev_rdata_OBUF[127]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[128] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[160]),
        .Q(ic_dev_rdata_OBUF[128]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[129] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[161]),
        .Q(ic_dev_rdata_OBUF[129]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[12] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[44]),
        .Q(ic_dev_rdata_OBUF[12]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[130] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[162]),
        .Q(ic_dev_rdata_OBUF[130]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[131] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[163]),
        .Q(ic_dev_rdata_OBUF[131]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[132] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[164]),
        .Q(ic_dev_rdata_OBUF[132]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[133] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[165]),
        .Q(ic_dev_rdata_OBUF[133]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[134] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[166]),
        .Q(ic_dev_rdata_OBUF[134]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[135] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[167]),
        .Q(ic_dev_rdata_OBUF[135]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[136] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[168]),
        .Q(ic_dev_rdata_OBUF[136]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[137] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[169]),
        .Q(ic_dev_rdata_OBUF[137]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[138] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[170]),
        .Q(ic_dev_rdata_OBUF[138]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[139] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[171]),
        .Q(ic_dev_rdata_OBUF[139]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[13] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[45]),
        .Q(ic_dev_rdata_OBUF[13]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[140] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[172]),
        .Q(ic_dev_rdata_OBUF[140]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[141] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[173]),
        .Q(ic_dev_rdata_OBUF[141]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[142] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[174]),
        .Q(ic_dev_rdata_OBUF[142]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[143] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[175]),
        .Q(ic_dev_rdata_OBUF[143]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[144] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[176]),
        .Q(ic_dev_rdata_OBUF[144]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[145] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[177]),
        .Q(ic_dev_rdata_OBUF[145]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[146] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[178]),
        .Q(ic_dev_rdata_OBUF[146]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[147] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[179]),
        .Q(ic_dev_rdata_OBUF[147]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[148] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[180]),
        .Q(ic_dev_rdata_OBUF[148]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[149] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[181]),
        .Q(ic_dev_rdata_OBUF[149]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[14] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[46]),
        .Q(ic_dev_rdata_OBUF[14]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[150] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[182]),
        .Q(ic_dev_rdata_OBUF[150]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[151] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[183]),
        .Q(ic_dev_rdata_OBUF[151]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[152] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[184]),
        .Q(ic_dev_rdata_OBUF[152]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[153] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[185]),
        .Q(ic_dev_rdata_OBUF[153]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[154] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[186]),
        .Q(ic_dev_rdata_OBUF[154]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[155] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[187]),
        .Q(ic_dev_rdata_OBUF[155]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[156] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[188]),
        .Q(ic_dev_rdata_OBUF[156]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[157] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[189]),
        .Q(ic_dev_rdata_OBUF[157]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[158] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[190]),
        .Q(ic_dev_rdata_OBUF[158]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[159] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[191]),
        .Q(ic_dev_rdata_OBUF[159]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[15] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[47]),
        .Q(ic_dev_rdata_OBUF[15]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[160] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[192]),
        .Q(ic_dev_rdata_OBUF[160]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[161] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[193]),
        .Q(ic_dev_rdata_OBUF[161]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[162] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[194]),
        .Q(ic_dev_rdata_OBUF[162]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[163] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[195]),
        .Q(ic_dev_rdata_OBUF[163]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[164] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[196]),
        .Q(ic_dev_rdata_OBUF[164]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[165] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[197]),
        .Q(ic_dev_rdata_OBUF[165]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[166] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[198]),
        .Q(ic_dev_rdata_OBUF[166]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[167] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[199]),
        .Q(ic_dev_rdata_OBUF[167]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[168] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[200]),
        .Q(ic_dev_rdata_OBUF[168]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[169] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[201]),
        .Q(ic_dev_rdata_OBUF[169]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[16] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[48]),
        .Q(ic_dev_rdata_OBUF[16]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[170] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[202]),
        .Q(ic_dev_rdata_OBUF[170]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[171] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[203]),
        .Q(ic_dev_rdata_OBUF[171]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[172] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[204]),
        .Q(ic_dev_rdata_OBUF[172]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[173] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[205]),
        .Q(ic_dev_rdata_OBUF[173]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[174] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[206]),
        .Q(ic_dev_rdata_OBUF[174]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[175] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[207]),
        .Q(ic_dev_rdata_OBUF[175]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[176] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[208]),
        .Q(ic_dev_rdata_OBUF[176]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[177] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[209]),
        .Q(ic_dev_rdata_OBUF[177]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[178] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[210]),
        .Q(ic_dev_rdata_OBUF[178]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[179] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[211]),
        .Q(ic_dev_rdata_OBUF[179]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[17] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[49]),
        .Q(ic_dev_rdata_OBUF[17]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[180] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[212]),
        .Q(ic_dev_rdata_OBUF[180]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[181] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[213]),
        .Q(ic_dev_rdata_OBUF[181]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[182] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[214]),
        .Q(ic_dev_rdata_OBUF[182]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[183] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[215]),
        .Q(ic_dev_rdata_OBUF[183]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[184] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[216]),
        .Q(ic_dev_rdata_OBUF[184]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[185] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[217]),
        .Q(ic_dev_rdata_OBUF[185]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[186] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[218]),
        .Q(ic_dev_rdata_OBUF[186]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[187] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[219]),
        .Q(ic_dev_rdata_OBUF[187]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[188] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[220]),
        .Q(ic_dev_rdata_OBUF[188]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[189] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[221]),
        .Q(ic_dev_rdata_OBUF[189]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[18] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[50]),
        .Q(ic_dev_rdata_OBUF[18]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[190] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[222]),
        .Q(ic_dev_rdata_OBUF[190]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[191] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[223]),
        .Q(ic_dev_rdata_OBUF[191]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[192] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[224]),
        .Q(ic_dev_rdata_OBUF[192]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[193] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[225]),
        .Q(ic_dev_rdata_OBUF[193]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[194] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[226]),
        .Q(ic_dev_rdata_OBUF[194]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[195] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[227]),
        .Q(ic_dev_rdata_OBUF[195]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[196] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[228]),
        .Q(ic_dev_rdata_OBUF[196]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[197] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[229]),
        .Q(ic_dev_rdata_OBUF[197]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[198] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[230]),
        .Q(ic_dev_rdata_OBUF[198]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[199] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[231]),
        .Q(ic_dev_rdata_OBUF[199]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[19] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[51]),
        .Q(ic_dev_rdata_OBUF[19]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[1] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[33]),
        .Q(ic_dev_rdata_OBUF[1]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[200] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[232]),
        .Q(ic_dev_rdata_OBUF[200]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[201] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[233]),
        .Q(ic_dev_rdata_OBUF[201]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[202] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[234]),
        .Q(ic_dev_rdata_OBUF[202]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[203] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[235]),
        .Q(ic_dev_rdata_OBUF[203]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[204] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[236]),
        .Q(ic_dev_rdata_OBUF[204]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[205] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[237]),
        .Q(ic_dev_rdata_OBUF[205]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[206] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[238]),
        .Q(ic_dev_rdata_OBUF[206]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[207] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[239]),
        .Q(ic_dev_rdata_OBUF[207]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[208] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[240]),
        .Q(ic_dev_rdata_OBUF[208]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[209] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[241]),
        .Q(ic_dev_rdata_OBUF[209]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[20] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[52]),
        .Q(ic_dev_rdata_OBUF[20]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[210] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[242]),
        .Q(ic_dev_rdata_OBUF[210]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[211] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[243]),
        .Q(ic_dev_rdata_OBUF[211]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[212] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[244]),
        .Q(ic_dev_rdata_OBUF[212]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[213] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[245]),
        .Q(ic_dev_rdata_OBUF[213]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[214] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[246]),
        .Q(ic_dev_rdata_OBUF[214]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[215] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[247]),
        .Q(ic_dev_rdata_OBUF[215]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[216] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[248]),
        .Q(ic_dev_rdata_OBUF[216]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[217] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[249]),
        .Q(ic_dev_rdata_OBUF[217]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[218] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[250]),
        .Q(ic_dev_rdata_OBUF[218]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[219] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[251]),
        .Q(ic_dev_rdata_OBUF[219]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[21] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[53]),
        .Q(ic_dev_rdata_OBUF[21]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[220] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[252]),
        .Q(ic_dev_rdata_OBUF[220]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[221] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[253]),
        .Q(ic_dev_rdata_OBUF[221]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[222] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[254]),
        .Q(ic_dev_rdata_OBUF[222]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[223] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[255]),
        .Q(ic_dev_rdata_OBUF[223]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[224] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[0]),
        .Q(ic_dev_rdata_OBUF[224]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[225] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[1]),
        .Q(ic_dev_rdata_OBUF[225]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[226] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[2]),
        .Q(ic_dev_rdata_OBUF[226]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[227] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[3]),
        .Q(ic_dev_rdata_OBUF[227]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[228] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[4]),
        .Q(ic_dev_rdata_OBUF[228]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[229] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[5]),
        .Q(ic_dev_rdata_OBUF[229]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[22] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[54]),
        .Q(ic_dev_rdata_OBUF[22]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[230] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[6]),
        .Q(ic_dev_rdata_OBUF[230]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[231] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[7]),
        .Q(ic_dev_rdata_OBUF[231]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[232] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[8]),
        .Q(ic_dev_rdata_OBUF[232]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[233] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[9]),
        .Q(ic_dev_rdata_OBUF[233]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[234] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[10]),
        .Q(ic_dev_rdata_OBUF[234]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[235] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[11]),
        .Q(ic_dev_rdata_OBUF[235]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[236] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[12]),
        .Q(ic_dev_rdata_OBUF[236]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[237] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[13]),
        .Q(ic_dev_rdata_OBUF[237]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[238] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[14]),
        .Q(ic_dev_rdata_OBUF[238]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[239] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[15]),
        .Q(ic_dev_rdata_OBUF[239]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[23] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[55]),
        .Q(ic_dev_rdata_OBUF[23]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[240] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[16]),
        .Q(ic_dev_rdata_OBUF[240]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[241] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[17]),
        .Q(ic_dev_rdata_OBUF[241]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[242] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[18]),
        .Q(ic_dev_rdata_OBUF[242]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[243] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[19]),
        .Q(ic_dev_rdata_OBUF[243]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[244] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[20]),
        .Q(ic_dev_rdata_OBUF[244]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[245] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[21]),
        .Q(ic_dev_rdata_OBUF[245]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[246] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[22]),
        .Q(ic_dev_rdata_OBUF[246]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[247] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[23]),
        .Q(ic_dev_rdata_OBUF[247]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[248] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[24]),
        .Q(ic_dev_rdata_OBUF[248]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[249] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[25]),
        .Q(ic_dev_rdata_OBUF[249]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[24] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[56]),
        .Q(ic_dev_rdata_OBUF[24]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[250] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[26]),
        .Q(ic_dev_rdata_OBUF[250]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[251] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[27]),
        .Q(ic_dev_rdata_OBUF[251]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[252] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[28]),
        .Q(ic_dev_rdata_OBUF[252]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[253] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[29]),
        .Q(ic_dev_rdata_OBUF[253]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[254] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[30]),
        .Q(ic_dev_rdata_OBUF[254]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[255] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(m_axi_rdata_IBUF[31]),
        .Q(ic_dev_rdata_OBUF[255]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[25] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[57]),
        .Q(ic_dev_rdata_OBUF[25]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[26] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[58]),
        .Q(ic_dev_rdata_OBUF[26]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[27] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[59]),
        .Q(ic_dev_rdata_OBUF[27]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[28] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[60]),
        .Q(ic_dev_rdata_OBUF[28]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[29] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[61]),
        .Q(ic_dev_rdata_OBUF[29]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[2] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[34]),
        .Q(ic_dev_rdata_OBUF[2]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[30] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[62]),
        .Q(ic_dev_rdata_OBUF[30]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[31] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[63]),
        .Q(ic_dev_rdata_OBUF[31]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[32] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[64]),
        .Q(ic_dev_rdata_OBUF[32]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[33] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[65]),
        .Q(ic_dev_rdata_OBUF[33]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[34] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[66]),
        .Q(ic_dev_rdata_OBUF[34]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[35] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[67]),
        .Q(ic_dev_rdata_OBUF[35]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[36] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[68]),
        .Q(ic_dev_rdata_OBUF[36]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[37] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[69]),
        .Q(ic_dev_rdata_OBUF[37]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[38] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[70]),
        .Q(ic_dev_rdata_OBUF[38]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[39] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[71]),
        .Q(ic_dev_rdata_OBUF[39]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[3] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[35]),
        .Q(ic_dev_rdata_OBUF[3]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[40] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[72]),
        .Q(ic_dev_rdata_OBUF[40]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[41] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[73]),
        .Q(ic_dev_rdata_OBUF[41]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[42] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[74]),
        .Q(ic_dev_rdata_OBUF[42]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[43] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[75]),
        .Q(ic_dev_rdata_OBUF[43]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[44] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[76]),
        .Q(ic_dev_rdata_OBUF[44]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[45] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[77]),
        .Q(ic_dev_rdata_OBUF[45]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[46] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[78]),
        .Q(ic_dev_rdata_OBUF[46]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[47] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[79]),
        .Q(ic_dev_rdata_OBUF[47]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[48] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[80]),
        .Q(ic_dev_rdata_OBUF[48]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[49] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[81]),
        .Q(ic_dev_rdata_OBUF[49]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[4] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[36]),
        .Q(ic_dev_rdata_OBUF[4]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[50] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[82]),
        .Q(ic_dev_rdata_OBUF[50]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[51] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[83]),
        .Q(ic_dev_rdata_OBUF[51]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[52] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[84]),
        .Q(ic_dev_rdata_OBUF[52]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[53] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[85]),
        .Q(ic_dev_rdata_OBUF[53]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[54] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[86]),
        .Q(ic_dev_rdata_OBUF[54]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[55] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[87]),
        .Q(ic_dev_rdata_OBUF[55]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[56] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[88]),
        .Q(ic_dev_rdata_OBUF[56]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[57] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[89]),
        .Q(ic_dev_rdata_OBUF[57]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[58] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[90]),
        .Q(ic_dev_rdata_OBUF[58]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[59] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[91]),
        .Q(ic_dev_rdata_OBUF[59]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[5] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[37]),
        .Q(ic_dev_rdata_OBUF[5]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[60] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[92]),
        .Q(ic_dev_rdata_OBUF[60]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[61] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[93]),
        .Q(ic_dev_rdata_OBUF[61]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[62] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[94]),
        .Q(ic_dev_rdata_OBUF[62]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[63] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[95]),
        .Q(ic_dev_rdata_OBUF[63]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[64] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[96]),
        .Q(ic_dev_rdata_OBUF[64]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[65] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[97]),
        .Q(ic_dev_rdata_OBUF[65]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[66] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[98]),
        .Q(ic_dev_rdata_OBUF[66]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[67] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[99]),
        .Q(ic_dev_rdata_OBUF[67]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[68] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[100]),
        .Q(ic_dev_rdata_OBUF[68]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[69] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[101]),
        .Q(ic_dev_rdata_OBUF[69]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[6] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[38]),
        .Q(ic_dev_rdata_OBUF[6]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[70] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[102]),
        .Q(ic_dev_rdata_OBUF[70]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[71] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[103]),
        .Q(ic_dev_rdata_OBUF[71]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[72] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[104]),
        .Q(ic_dev_rdata_OBUF[72]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[73] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[105]),
        .Q(ic_dev_rdata_OBUF[73]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[74] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[106]),
        .Q(ic_dev_rdata_OBUF[74]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[75] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[107]),
        .Q(ic_dev_rdata_OBUF[75]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[76] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[108]),
        .Q(ic_dev_rdata_OBUF[76]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[77] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[109]),
        .Q(ic_dev_rdata_OBUF[77]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[78] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[110]),
        .Q(ic_dev_rdata_OBUF[78]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[79] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[111]),
        .Q(ic_dev_rdata_OBUF[79]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[7] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[39]),
        .Q(ic_dev_rdata_OBUF[7]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[80] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[112]),
        .Q(ic_dev_rdata_OBUF[80]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[81] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[113]),
        .Q(ic_dev_rdata_OBUF[81]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[82] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[114]),
        .Q(ic_dev_rdata_OBUF[82]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[83] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[115]),
        .Q(ic_dev_rdata_OBUF[83]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[84] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[116]),
        .Q(ic_dev_rdata_OBUF[84]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[85] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[117]),
        .Q(ic_dev_rdata_OBUF[85]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[86] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[118]),
        .Q(ic_dev_rdata_OBUF[86]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[87] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[119]),
        .Q(ic_dev_rdata_OBUF[87]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[88] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[120]),
        .Q(ic_dev_rdata_OBUF[88]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[89] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[121]),
        .Q(ic_dev_rdata_OBUF[89]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[8] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[40]),
        .Q(ic_dev_rdata_OBUF[8]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[90] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[122]),
        .Q(ic_dev_rdata_OBUF[90]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[91] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[123]),
        .Q(ic_dev_rdata_OBUF[91]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[92] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[124]),
        .Q(ic_dev_rdata_OBUF[92]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[93] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[125]),
        .Q(ic_dev_rdata_OBUF[93]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[94] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[126]),
        .Q(ic_dev_rdata_OBUF[94]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[95] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[127]),
        .Q(ic_dev_rdata_OBUF[95]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[96] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[128]),
        .Q(ic_dev_rdata_OBUF[96]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[97] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[129]),
        .Q(ic_dev_rdata_OBUF[97]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[98] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[130]),
        .Q(ic_dev_rdata_OBUF[98]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[99] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[131]),
        .Q(ic_dev_rdata_OBUF[99]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[9] 
       (.C(aclk_IBUF_BUFG),
        .CE(\ic_dev_rdata[255]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(ic_dev_rdata_OBUF[41]),
        .Q(ic_dev_rdata_OBUF[9]));
  OBUF ic_dev_rrdy_OBUF_inst
       (.I(ic_dev_rrdy_OBUF),
        .O(ic_dev_rrdy));
  LUT5 #(
    .INIT(32'hFBBBF000)) 
    ic_dev_rrdy_i_1
       (.I0(has_dc_rd_req_r),
        .I1(has_ic_rd_req_r),
        .I2(m_axi_rvalid_IBUF),
        .I3(m_axi_rlast_IBUF),
        .I4(ic_dev_rrdy_OBUF),
        .O(ic_dev_rrdy_i_1_n_0));
  FDPE #(
    .INIT(1'b1)) 
    ic_dev_rrdy_reg
       (.C(aclk_IBUF_BUFG),
        .CE(1'b1),
        .D(ic_dev_rrdy_i_1_n_0),
        .PRE(areset_IBUF),
        .Q(ic_dev_rrdy_OBUF));
  OBUF ic_dev_rvalid_OBUF_inst
       (.I(ic_dev_rvalid_OBUF),
        .O(ic_dev_rvalid));
  LUT6 #(
    .INIT(64'hAAAAAAAA00400000)) 
    ic_dev_rvalid_i_1
       (.I0(ic_dev_rvalid_OBUF),
        .I1(m_axi_rvalid_IBUF),
        .I2(m_axi_rlast_IBUF),
        .I3(has_dc_rd_req_r),
        .I4(has_ic_rd_req_r),
        .I5(dc_dev_rvalid_OBUF),
        .O(ic_dev_rvalid_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    ic_dev_rvalid_reg
       (.C(aclk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(areset_IBUF),
        .D(ic_dev_rvalid_i_1_n_0),
        .Q(ic_dev_rvalid_OBUF));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[0]_i_1 
       (.I0(dc_cpu_raddr_IBUF[0]),
        .I1(ic_cpu_raddr_IBUF[0]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[10]_i_1 
       (.I0(dc_cpu_raddr_IBUF[10]),
        .I1(ic_cpu_raddr_IBUF[10]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[10]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[11]_i_1 
       (.I0(dc_cpu_raddr_IBUF[11]),
        .I1(ic_cpu_raddr_IBUF[11]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[11]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[12]_i_1 
       (.I0(dc_cpu_raddr_IBUF[12]),
        .I1(ic_cpu_raddr_IBUF[12]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[12]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[13]_i_1 
       (.I0(dc_cpu_raddr_IBUF[13]),
        .I1(ic_cpu_raddr_IBUF[13]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[13]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[14]_i_1 
       (.I0(dc_cpu_raddr_IBUF[14]),
        .I1(ic_cpu_raddr_IBUF[14]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[14]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[15]_i_1 
       (.I0(dc_cpu_raddr_IBUF[15]),
        .I1(ic_cpu_raddr_IBUF[15]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[16]_i_1 
       (.I0(dc_cpu_raddr_IBUF[16]),
        .I1(ic_cpu_raddr_IBUF[16]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[16]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[17]_i_1 
       (.I0(dc_cpu_raddr_IBUF[17]),
        .I1(ic_cpu_raddr_IBUF[17]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[17]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[18]_i_1 
       (.I0(dc_cpu_raddr_IBUF[18]),
        .I1(ic_cpu_raddr_IBUF[18]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[18]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[19]_i_1 
       (.I0(dc_cpu_raddr_IBUF[19]),
        .I1(ic_cpu_raddr_IBUF[19]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[19]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[1]_i_1 
       (.I0(dc_cpu_raddr_IBUF[1]),
        .I1(ic_cpu_raddr_IBUF[1]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[20]_i_1 
       (.I0(dc_cpu_raddr_IBUF[20]),
        .I1(ic_cpu_raddr_IBUF[20]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[20]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[21]_i_1 
       (.I0(dc_cpu_raddr_IBUF[21]),
        .I1(ic_cpu_raddr_IBUF[21]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[21]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[22]_i_1 
       (.I0(dc_cpu_raddr_IBUF[22]),
        .I1(ic_cpu_raddr_IBUF[22]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[22]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[23]_i_1 
       (.I0(dc_cpu_raddr_IBUF[23]),
        .I1(ic_cpu_raddr_IBUF[23]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[23]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[24]_i_1 
       (.I0(dc_cpu_raddr_IBUF[24]),
        .I1(ic_cpu_raddr_IBUF[24]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[24]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[25]_i_1 
       (.I0(dc_cpu_raddr_IBUF[25]),
        .I1(ic_cpu_raddr_IBUF[25]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[25]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[26]_i_1 
       (.I0(dc_cpu_raddr_IBUF[26]),
        .I1(ic_cpu_raddr_IBUF[26]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[26]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[27]_i_1 
       (.I0(dc_cpu_raddr_IBUF[27]),
        .I1(ic_cpu_raddr_IBUF[27]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[27]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[28]_i_1 
       (.I0(dc_cpu_raddr_IBUF[28]),
        .I1(ic_cpu_raddr_IBUF[28]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[28]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[29]_i_1 
       (.I0(dc_cpu_raddr_IBUF[29]),
        .I1(ic_cpu_raddr_IBUF[29]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[29]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[2]_i_1 
       (.I0(dc_cpu_raddr_IBUF[2]),
        .I1(ic_cpu_raddr_IBUF[2]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[30]_i_1 
       (.I0(dc_cpu_raddr_IBUF[30]),
        .I1(ic_cpu_raddr_IBUF[30]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[30]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \m_axi_araddr[31]_i_1 
       (.I0(dc_cpu_ren_IBUF),
        .I1(dc_dev_rrdy_OBUF),
        .I2(ic_cpu_ren_IBUF),
        .I3(ic_dev_rrdy_OBUF),
        .O(has_rd_req));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[31]_i_2 
       (.I0(dc_cpu_raddr_IBUF[31]),
        .I1(ic_cpu_raddr_IBUF[31]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[31]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[3]_i_1 
       (.I0(dc_cpu_raddr_IBUF[3]),
        .I1(ic_cpu_raddr_IBUF[3]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[4]_i_1 
       (.I0(dc_cpu_raddr_IBUF[4]),
        .I1(ic_cpu_raddr_IBUF[4]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[4]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[5]_i_1 
       (.I0(dc_cpu_raddr_IBUF[5]),
        .I1(ic_cpu_raddr_IBUF[5]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[5]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[6]_i_1 
       (.I0(dc_cpu_raddr_IBUF[6]),
        .I1(ic_cpu_raddr_IBUF[6]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[7]_i_1 
       (.I0(dc_cpu_raddr_IBUF[7]),
        .I1(ic_cpu_raddr_IBUF[7]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[7]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[8]_i_1 
       (.I0(dc_cpu_raddr_IBUF[8]),
        .I1(ic_cpu_raddr_IBUF[8]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[8]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[9]_i_1 
       (.I0(dc_cpu_raddr_IBUF[9]),
        .I1(ic_cpu_raddr_IBUF[9]),
        .I2(dc_dev_rrdy_OBUF),
        .I3(dc_cpu_ren_IBUF),
        .O(\m_axi_araddr[9]_i_1_n_0 ));
  OBUF \m_axi_araddr_OBUF[0]_inst 
       (.I(m_axi_araddr_OBUF[0]),
        .O(m_axi_araddr[0]));
  OBUF \m_axi_araddr_OBUF[10]_inst 
       (.I(m_axi_araddr_OBUF[10]),
        .O(m_axi_araddr[10]));
  OBUF \m_axi_araddr_OBUF[11]_inst 
       (.I(m_axi_araddr_OBUF[11]),
        .O(m_axi_araddr[11]));
  OBUF \m_axi_araddr_OBUF[12]_inst 
       (.I(m_axi_araddr_OBUF[12]),
        .O(m_axi_araddr[12]));
  OBUF \m_axi_araddr_OBUF[13]_inst 
       (.I(m_axi_araddr_OBUF[13]),
        .O(m_axi_araddr[13]));
  OBUF \m_axi_araddr_OBUF[14]_inst 
       (.I(m_axi_araddr_OBUF[14]),
        .O(m_axi_araddr[14]));
  OBUF \m_axi_araddr_OBUF[15]_inst 
       (.I(m_axi_araddr_OBUF[15]),
        .O(m_axi_araddr[15]));
  OBUF \m_axi_araddr_OBUF[16]_inst 
       (.I(m_axi_araddr_OBUF[16]),
        .O(m_axi_araddr[16]));
  OBUF \m_axi_araddr_OBUF[17]_inst 
       (.I(m_axi_araddr_OBUF[17]),
        .O(m_axi_araddr[17]));
  OBUF \m_axi_araddr_OBUF[18]_inst 
       (.I(m_axi_araddr_OBUF[18]),
        .O(m_axi_araddr[18]));
  OBUF \m_axi_araddr_OBUF[19]_inst 
       (.I(m_axi_araddr_OBUF[19]),
        .O(m_axi_araddr[19]));
  OBUF \m_axi_araddr_OBUF[1]_inst 
       (.I(m_axi_araddr_OBUF[1]),
        .O(m_axi_araddr[1]));
  OBUF \m_axi_araddr_OBUF[20]_inst 
       (.I(m_axi_araddr_OBUF[20]),
        .O(m_axi_araddr[20]));
  OBUF \m_axi_araddr_OBUF[21]_inst 
       (.I(m_axi_araddr_OBUF[21]),
        .O(m_axi_araddr[21]));
  OBUF \m_axi_araddr_OBUF[22]_inst 
       (.I(m_axi_araddr_OBUF[22]),
        .O(m_axi_araddr[22]));
  OBUF \m_axi_araddr_OBUF[23]_inst 
       (.I(m_axi_araddr_OBUF[23]),
        .O(m_axi_araddr[23]));
  OBUF \m_axi_araddr_OBUF[24]_inst 
       (.I(m_axi_araddr_OBUF[24]),
        .O(m_axi_araddr[24]));
  OBUF \m_axi_araddr_OBUF[25]_inst 
       (.I(m_axi_araddr_OBUF[25]),
        .O(m_axi_araddr[25]));
  OBUF \m_axi_araddr_OBUF[26]_inst 
       (.I(m_axi_araddr_OBUF[26]),
        .O(m_axi_araddr[26]));
  OBUF \m_axi_araddr_OBUF[27]_inst 
       (.I(m_axi_araddr_OBUF[27]),
        .O(m_axi_araddr[27]));
  OBUF \m_axi_araddr_OBUF[28]_inst 
       (.I(m_axi_araddr_OBUF[28]),
        .O(m_axi_araddr[28]));
  OBUF \m_axi_araddr_OBUF[29]_inst 
       (.I(m_axi_araddr_OBUF[29]),
        .O(m_axi_araddr[29]));
  OBUF \m_axi_araddr_OBUF[2]_inst 
       (.I(m_axi_araddr_OBUF[2]),
        .O(m_axi_araddr[2]));
  OBUF \m_axi_araddr_OBUF[30]_inst 
       (.I(m_axi_araddr_OBUF[30]),
        .O(m_axi_araddr[30]));
  OBUF \m_axi_araddr_OBUF[31]_inst 
       (.I(m_axi_araddr_OBUF[31]),
        .O(m_axi_araddr[31]));
  OBUF \m_axi_araddr_OBUF[3]_inst 
       (.I(m_axi_araddr_OBUF[3]),
        .O(m_axi_araddr[3]));
  OBUF \m_axi_araddr_OBUF[4]_inst 
       (.I(m_axi_araddr_OBUF[4]),
        .O(m_axi_araddr[4]));
  OBUF \m_axi_araddr_OBUF[5]_inst 
       (.I(m_axi_araddr_OBUF[5]),
        .O(m_axi_araddr[5]));
  OBUF \m_axi_araddr_OBUF[6]_inst 
       (.I(m_axi_araddr_OBUF[6]),
        .O(m_axi_araddr[6]));
  OBUF \m_axi_araddr_OBUF[7]_inst 
       (.I(m_axi_araddr_OBUF[7]),
        .O(m_axi_araddr[7]));
  OBUF \m_axi_araddr_OBUF[8]_inst 
       (.I(m_axi_araddr_OBUF[8]),
        .O(m_axi_araddr[8]));
  OBUF \m_axi_araddr_OBUF[9]_inst 
       (.I(m_axi_araddr_OBUF[9]),
        .O(m_axi_araddr[9]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[0] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[0]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[0]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[10] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[10]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[10]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[11] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[11]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[11]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[12] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[12]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[12]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[13] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[13]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[13]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[14] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[14]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[14]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[15] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[15]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[15]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[16] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[16]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[16]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[17] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[17]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[17]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[18] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[18]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[18]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[19] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[19]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[19]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[1] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[1]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[1]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[20] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[20]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[20]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[21] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[21]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[21]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[22] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[22]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[22]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[23] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[23]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[23]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[24] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[24]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[24]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[25] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[25]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[25]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[26] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[26]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[26]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[27] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[27]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[27]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[28] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[28]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[28]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[29] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[29]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[29]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[2] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[2]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[2]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[30] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[30]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[30]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[31] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[31]_i_2_n_0 ),
        .Q(m_axi_araddr_OBUF[31]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[3] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[3]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[3]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[4] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[4]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[4]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[5] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[5]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[5]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[6] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[6]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[6]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[7] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[7]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[7]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[8] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[8]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[8]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[9] 
       (.C(aclk_IBUF_BUFG),
        .CE(has_rd_req),
        .CLR(areset_IBUF),
        .D(\m_axi_araddr[9]_i_1_n_0 ),
        .Q(m_axi_araddr_OBUF[9]));
  OBUF \m_axi_arburst_OBUF[0]_inst 
       (.I(m_axi_arburst_OBUF),
        .O(m_axi_arburst[0]));
  OBUF \m_axi_arburst_OBUF[1]_inst 
       (.I(1'b0),
        .O(m_axi_arburst[1]));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \m_axi_arlen[2]_i_1 
       (.I0(m_axi_arready_IBUF),
        .I1(m_axi_arvalid_OBUF),
        .I2(ic_dev_rrdy_OBUF),
        .I3(ic_cpu_ren_IBUF),
        .I4(dc_dev_rrdy_OBUF),
        .I5(dc_cpu_ren_IBUF),
        .O(\m_axi_arlen[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0888)) 
    \m_axi_arlen[2]_i_2 
       (.I0(ic_dev_rrdy_OBUF),
        .I1(ic_cpu_ren_IBUF),
        .I2(dc_cpu_ren_IBUF),
        .I3(dc_dev_rrdy_OBUF),
        .O(\m_axi_arlen[2]_i_2_n_0 ));
  OBUF \m_axi_arlen_OBUF[0]_inst 
       (.I(m_axi_arburst_OBUF),
        .O(m_axi_arlen[0]));
  OBUF \m_axi_arlen_OBUF[1]_inst 
       (.I(m_axi_arburst_OBUF),
        .O(m_axi_arlen[1]));
  OBUF \m_axi_arlen_OBUF[2]_inst 
       (.I(m_axi_arlen_OBUF),
        .O(m_axi_arlen[2]));
  OBUF \m_axi_arlen_OBUF[3]_inst 
       (.I(1'b0),
        .O(m_axi_arlen[3]));
  OBUF \m_axi_arlen_OBUF[4]_inst 
       (.I(1'b0),
        .O(m_axi_arlen[4]));
  OBUF \m_axi_arlen_OBUF[5]_inst 
       (.I(1'b0),
        .O(m_axi_arlen[5]));
  OBUF \m_axi_arlen_OBUF[6]_inst 
       (.I(1'b0),
        .O(m_axi_arlen[6]));
  OBUF \m_axi_arlen_OBUF[7]_inst 
       (.I(1'b0),
        .O(m_axi_arlen[7]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_arlen_reg[1] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_arlen[2]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(has_rd_req),
        .Q(m_axi_arburst_OBUF));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_arlen_reg[2] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_arlen[2]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(\m_axi_arlen[2]_i_2_n_0 ),
        .Q(m_axi_arlen_OBUF));
  IBUF m_axi_arready_IBUF_inst
       (.I(m_axi_arready),
        .O(m_axi_arready_IBUF));
  OBUF \m_axi_arsize_OBUF[0]_inst 
       (.I(1'b0),
        .O(m_axi_arsize[0]));
  OBUF \m_axi_arsize_OBUF[1]_inst 
       (.I(m_axi_arburst_OBUF),
        .O(m_axi_arsize[1]));
  OBUF \m_axi_arsize_OBUF[2]_inst 
       (.I(1'b0),
        .O(m_axi_arsize[2]));
  OBUF m_axi_arvalid_OBUF_inst
       (.I(m_axi_arvalid_OBUF),
        .O(m_axi_arvalid));
  LUT6 #(
    .INIT(64'hFFFFF444F444F444)) 
    m_axi_arvalid_i_1
       (.I0(m_axi_arready_IBUF),
        .I1(m_axi_arvalid_OBUF),
        .I2(ic_dev_rrdy_OBUF),
        .I3(ic_cpu_ren_IBUF),
        .I4(dc_dev_rrdy_OBUF),
        .I5(dc_cpu_ren_IBUF),
        .O(m_axi_arvalid_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    m_axi_arvalid_reg
       (.C(aclk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(areset_IBUF),
        .D(m_axi_arvalid_i_1_n_0),
        .Q(m_axi_arvalid_OBUF));
  LUT3 #(
    .INIT(8'h2A)) 
    \m_axi_awaddr[31]_i_1 
       (.I0(has_dc_wr_req),
        .I1(m_axi_awready_IBUF),
        .I2(m_axi_awvalid_OBUF),
        .O(\m_axi_awaddr[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAAAAAAA8)) 
    \m_axi_awaddr[31]_i_2 
       (.I0(dc_dev_wrdy_OBUF),
        .I1(dc_cpu_wen_IBUF[1]),
        .I2(dc_cpu_wen_IBUF[0]),
        .I3(dc_cpu_wen_IBUF[2]),
        .I4(dc_cpu_wen_IBUF[3]),
        .O(has_dc_wr_req));
  OBUF \m_axi_awaddr_OBUF[0]_inst 
       (.I(m_axi_awaddr_OBUF[0]),
        .O(m_axi_awaddr[0]));
  OBUF \m_axi_awaddr_OBUF[10]_inst 
       (.I(m_axi_awaddr_OBUF[10]),
        .O(m_axi_awaddr[10]));
  OBUF \m_axi_awaddr_OBUF[11]_inst 
       (.I(m_axi_awaddr_OBUF[11]),
        .O(m_axi_awaddr[11]));
  OBUF \m_axi_awaddr_OBUF[12]_inst 
       (.I(m_axi_awaddr_OBUF[12]),
        .O(m_axi_awaddr[12]));
  OBUF \m_axi_awaddr_OBUF[13]_inst 
       (.I(m_axi_awaddr_OBUF[13]),
        .O(m_axi_awaddr[13]));
  OBUF \m_axi_awaddr_OBUF[14]_inst 
       (.I(m_axi_awaddr_OBUF[14]),
        .O(m_axi_awaddr[14]));
  OBUF \m_axi_awaddr_OBUF[15]_inst 
       (.I(m_axi_awaddr_OBUF[15]),
        .O(m_axi_awaddr[15]));
  OBUF \m_axi_awaddr_OBUF[16]_inst 
       (.I(m_axi_awaddr_OBUF[16]),
        .O(m_axi_awaddr[16]));
  OBUF \m_axi_awaddr_OBUF[17]_inst 
       (.I(m_axi_awaddr_OBUF[17]),
        .O(m_axi_awaddr[17]));
  OBUF \m_axi_awaddr_OBUF[18]_inst 
       (.I(m_axi_awaddr_OBUF[18]),
        .O(m_axi_awaddr[18]));
  OBUF \m_axi_awaddr_OBUF[19]_inst 
       (.I(m_axi_awaddr_OBUF[19]),
        .O(m_axi_awaddr[19]));
  OBUF \m_axi_awaddr_OBUF[1]_inst 
       (.I(m_axi_awaddr_OBUF[1]),
        .O(m_axi_awaddr[1]));
  OBUF \m_axi_awaddr_OBUF[20]_inst 
       (.I(m_axi_awaddr_OBUF[20]),
        .O(m_axi_awaddr[20]));
  OBUF \m_axi_awaddr_OBUF[21]_inst 
       (.I(m_axi_awaddr_OBUF[21]),
        .O(m_axi_awaddr[21]));
  OBUF \m_axi_awaddr_OBUF[22]_inst 
       (.I(m_axi_awaddr_OBUF[22]),
        .O(m_axi_awaddr[22]));
  OBUF \m_axi_awaddr_OBUF[23]_inst 
       (.I(m_axi_awaddr_OBUF[23]),
        .O(m_axi_awaddr[23]));
  OBUF \m_axi_awaddr_OBUF[24]_inst 
       (.I(m_axi_awaddr_OBUF[24]),
        .O(m_axi_awaddr[24]));
  OBUF \m_axi_awaddr_OBUF[25]_inst 
       (.I(m_axi_awaddr_OBUF[25]),
        .O(m_axi_awaddr[25]));
  OBUF \m_axi_awaddr_OBUF[26]_inst 
       (.I(m_axi_awaddr_OBUF[26]),
        .O(m_axi_awaddr[26]));
  OBUF \m_axi_awaddr_OBUF[27]_inst 
       (.I(m_axi_awaddr_OBUF[27]),
        .O(m_axi_awaddr[27]));
  OBUF \m_axi_awaddr_OBUF[28]_inst 
       (.I(m_axi_awaddr_OBUF[28]),
        .O(m_axi_awaddr[28]));
  OBUF \m_axi_awaddr_OBUF[29]_inst 
       (.I(m_axi_awaddr_OBUF[29]),
        .O(m_axi_awaddr[29]));
  OBUF \m_axi_awaddr_OBUF[2]_inst 
       (.I(m_axi_awaddr_OBUF[2]),
        .O(m_axi_awaddr[2]));
  OBUF \m_axi_awaddr_OBUF[30]_inst 
       (.I(m_axi_awaddr_OBUF[30]),
        .O(m_axi_awaddr[30]));
  OBUF \m_axi_awaddr_OBUF[31]_inst 
       (.I(m_axi_awaddr_OBUF[31]),
        .O(m_axi_awaddr[31]));
  OBUF \m_axi_awaddr_OBUF[3]_inst 
       (.I(m_axi_awaddr_OBUF[3]),
        .O(m_axi_awaddr[3]));
  OBUF \m_axi_awaddr_OBUF[4]_inst 
       (.I(m_axi_awaddr_OBUF[4]),
        .O(m_axi_awaddr[4]));
  OBUF \m_axi_awaddr_OBUF[5]_inst 
       (.I(m_axi_awaddr_OBUF[5]),
        .O(m_axi_awaddr[5]));
  OBUF \m_axi_awaddr_OBUF[6]_inst 
       (.I(m_axi_awaddr_OBUF[6]),
        .O(m_axi_awaddr[6]));
  OBUF \m_axi_awaddr_OBUF[7]_inst 
       (.I(m_axi_awaddr_OBUF[7]),
        .O(m_axi_awaddr[7]));
  OBUF \m_axi_awaddr_OBUF[8]_inst 
       (.I(m_axi_awaddr_OBUF[8]),
        .O(m_axi_awaddr[8]));
  OBUF \m_axi_awaddr_OBUF[9]_inst 
       (.I(m_axi_awaddr_OBUF[9]),
        .O(m_axi_awaddr[9]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[0] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[0]),
        .Q(m_axi_awaddr_OBUF[0]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[10] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[10]),
        .Q(m_axi_awaddr_OBUF[10]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[11] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[11]),
        .Q(m_axi_awaddr_OBUF[11]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[12] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[12]),
        .Q(m_axi_awaddr_OBUF[12]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[13] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[13]),
        .Q(m_axi_awaddr_OBUF[13]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[14] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[14]),
        .Q(m_axi_awaddr_OBUF[14]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[15] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[15]),
        .Q(m_axi_awaddr_OBUF[15]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[16] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[16]),
        .Q(m_axi_awaddr_OBUF[16]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[17] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[17]),
        .Q(m_axi_awaddr_OBUF[17]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[18] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[18]),
        .Q(m_axi_awaddr_OBUF[18]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[19] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[19]),
        .Q(m_axi_awaddr_OBUF[19]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[1] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[1]),
        .Q(m_axi_awaddr_OBUF[1]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[20] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[20]),
        .Q(m_axi_awaddr_OBUF[20]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[21] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[21]),
        .Q(m_axi_awaddr_OBUF[21]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[22] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[22]),
        .Q(m_axi_awaddr_OBUF[22]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[23] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[23]),
        .Q(m_axi_awaddr_OBUF[23]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[24] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[24]),
        .Q(m_axi_awaddr_OBUF[24]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[25] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[25]),
        .Q(m_axi_awaddr_OBUF[25]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[26] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[26]),
        .Q(m_axi_awaddr_OBUF[26]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[27] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[27]),
        .Q(m_axi_awaddr_OBUF[27]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[28] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[28]),
        .Q(m_axi_awaddr_OBUF[28]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[29] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[29]),
        .Q(m_axi_awaddr_OBUF[29]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[2] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[2]),
        .Q(m_axi_awaddr_OBUF[2]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[30] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[30]),
        .Q(m_axi_awaddr_OBUF[30]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[31] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[31]),
        .Q(m_axi_awaddr_OBUF[31]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[3] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[3]),
        .Q(m_axi_awaddr_OBUF[3]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[4] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[4]),
        .Q(m_axi_awaddr_OBUF[4]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[5] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[5]),
        .Q(m_axi_awaddr_OBUF[5]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[6] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[6]),
        .Q(m_axi_awaddr_OBUF[6]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[7] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[7]),
        .Q(m_axi_awaddr_OBUF[7]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[8] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[8]),
        .Q(m_axi_awaddr_OBUF[8]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[9] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_waddr_IBUF[9]),
        .Q(m_axi_awaddr_OBUF[9]));
  OBUF \m_axi_awburst_OBUF[0]_inst 
       (.I(m_axi_awburst_OBUF),
        .O(m_axi_awburst[0]));
  OBUF \m_axi_awburst_OBUF[1]_inst 
       (.I(1'b0),
        .O(m_axi_awburst[1]));
  OBUF \m_axi_awlen_OBUF[0]_inst 
       (.I(1'b0),
        .O(m_axi_awlen[0]));
  OBUF \m_axi_awlen_OBUF[1]_inst 
       (.I(1'b0),
        .O(m_axi_awlen[1]));
  OBUF \m_axi_awlen_OBUF[2]_inst 
       (.I(1'b0),
        .O(m_axi_awlen[2]));
  OBUF \m_axi_awlen_OBUF[3]_inst 
       (.I(1'b0),
        .O(m_axi_awlen[3]));
  OBUF \m_axi_awlen_OBUF[4]_inst 
       (.I(1'b0),
        .O(m_axi_awlen[4]));
  OBUF \m_axi_awlen_OBUF[5]_inst 
       (.I(1'b0),
        .O(m_axi_awlen[5]));
  OBUF \m_axi_awlen_OBUF[6]_inst 
       (.I(1'b0),
        .O(m_axi_awlen[6]));
  OBUF \m_axi_awlen_OBUF[7]_inst 
       (.I(1'b0),
        .O(m_axi_awlen[7]));
  IBUF m_axi_awready_IBUF_inst
       (.I(m_axi_awready),
        .O(m_axi_awready_IBUF));
  LUT4 #(
    .INIT(16'h00F8)) 
    \m_axi_awsize[1]_i_1 
       (.I0(m_axi_awvalid_OBUF),
        .I1(m_axi_awready_IBUF),
        .I2(has_dc_wr_req),
        .I3(areset_IBUF),
        .O(\m_axi_awsize[1]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h7)) 
    \m_axi_awsize[1]_i_2 
       (.I0(m_axi_awready_IBUF),
        .I1(m_axi_awvalid_OBUF),
        .O(p_3_in));
  OBUF \m_axi_awsize_OBUF[0]_inst 
       (.I(1'b0),
        .O(m_axi_awsize[0]));
  OBUF \m_axi_awsize_OBUF[1]_inst 
       (.I(m_axi_awburst_OBUF),
        .O(m_axi_awsize[1]));
  OBUF \m_axi_awsize_OBUF[2]_inst 
       (.I(1'b0),
        .O(m_axi_awsize[2]));
  FDRE #(
    .INIT(1'b0)) 
    \m_axi_awsize_reg[1] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_awsize[1]_i_1_n_0 ),
        .D(p_3_in),
        .Q(m_axi_awburst_OBUF),
        .R(1'b0));
  OBUF m_axi_awvalid_OBUF_inst
       (.I(m_axi_awvalid_OBUF),
        .O(m_axi_awvalid));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h3A)) 
    m_axi_awvalid_i_1
       (.I0(has_dc_wr_req),
        .I1(m_axi_awready_IBUF),
        .I2(m_axi_awvalid_OBUF),
        .O(m_axi_awvalid_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    m_axi_awvalid_reg
       (.C(aclk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(areset_IBUF),
        .D(m_axi_awvalid_i_1_n_0),
        .Q(m_axi_awvalid_OBUF));
  OBUF m_axi_bready_OBUF_inst
       (.I(m_axi_rready_OBUF),
        .O(m_axi_bready));
  FDCE #(
    .INIT(1'b0)) 
    m_axi_bready_reg
       (.C(aclk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(areset_IBUF),
        .D(1'b1),
        .Q(m_axi_rready_OBUF));
  IBUF m_axi_bvalid_IBUF_inst
       (.I(m_axi_bvalid),
        .O(m_axi_bvalid_IBUF));
  IBUF \m_axi_rdata_IBUF[0]_inst 
       (.I(m_axi_rdata[0]),
        .O(m_axi_rdata_IBUF[0]));
  IBUF \m_axi_rdata_IBUF[10]_inst 
       (.I(m_axi_rdata[10]),
        .O(m_axi_rdata_IBUF[10]));
  IBUF \m_axi_rdata_IBUF[11]_inst 
       (.I(m_axi_rdata[11]),
        .O(m_axi_rdata_IBUF[11]));
  IBUF \m_axi_rdata_IBUF[12]_inst 
       (.I(m_axi_rdata[12]),
        .O(m_axi_rdata_IBUF[12]));
  IBUF \m_axi_rdata_IBUF[13]_inst 
       (.I(m_axi_rdata[13]),
        .O(m_axi_rdata_IBUF[13]));
  IBUF \m_axi_rdata_IBUF[14]_inst 
       (.I(m_axi_rdata[14]),
        .O(m_axi_rdata_IBUF[14]));
  IBUF \m_axi_rdata_IBUF[15]_inst 
       (.I(m_axi_rdata[15]),
        .O(m_axi_rdata_IBUF[15]));
  IBUF \m_axi_rdata_IBUF[16]_inst 
       (.I(m_axi_rdata[16]),
        .O(m_axi_rdata_IBUF[16]));
  IBUF \m_axi_rdata_IBUF[17]_inst 
       (.I(m_axi_rdata[17]),
        .O(m_axi_rdata_IBUF[17]));
  IBUF \m_axi_rdata_IBUF[18]_inst 
       (.I(m_axi_rdata[18]),
        .O(m_axi_rdata_IBUF[18]));
  IBUF \m_axi_rdata_IBUF[19]_inst 
       (.I(m_axi_rdata[19]),
        .O(m_axi_rdata_IBUF[19]));
  IBUF \m_axi_rdata_IBUF[1]_inst 
       (.I(m_axi_rdata[1]),
        .O(m_axi_rdata_IBUF[1]));
  IBUF \m_axi_rdata_IBUF[20]_inst 
       (.I(m_axi_rdata[20]),
        .O(m_axi_rdata_IBUF[20]));
  IBUF \m_axi_rdata_IBUF[21]_inst 
       (.I(m_axi_rdata[21]),
        .O(m_axi_rdata_IBUF[21]));
  IBUF \m_axi_rdata_IBUF[22]_inst 
       (.I(m_axi_rdata[22]),
        .O(m_axi_rdata_IBUF[22]));
  IBUF \m_axi_rdata_IBUF[23]_inst 
       (.I(m_axi_rdata[23]),
        .O(m_axi_rdata_IBUF[23]));
  IBUF \m_axi_rdata_IBUF[24]_inst 
       (.I(m_axi_rdata[24]),
        .O(m_axi_rdata_IBUF[24]));
  IBUF \m_axi_rdata_IBUF[25]_inst 
       (.I(m_axi_rdata[25]),
        .O(m_axi_rdata_IBUF[25]));
  IBUF \m_axi_rdata_IBUF[26]_inst 
       (.I(m_axi_rdata[26]),
        .O(m_axi_rdata_IBUF[26]));
  IBUF \m_axi_rdata_IBUF[27]_inst 
       (.I(m_axi_rdata[27]),
        .O(m_axi_rdata_IBUF[27]));
  IBUF \m_axi_rdata_IBUF[28]_inst 
       (.I(m_axi_rdata[28]),
        .O(m_axi_rdata_IBUF[28]));
  IBUF \m_axi_rdata_IBUF[29]_inst 
       (.I(m_axi_rdata[29]),
        .O(m_axi_rdata_IBUF[29]));
  IBUF \m_axi_rdata_IBUF[2]_inst 
       (.I(m_axi_rdata[2]),
        .O(m_axi_rdata_IBUF[2]));
  IBUF \m_axi_rdata_IBUF[30]_inst 
       (.I(m_axi_rdata[30]),
        .O(m_axi_rdata_IBUF[30]));
  IBUF \m_axi_rdata_IBUF[31]_inst 
       (.I(m_axi_rdata[31]),
        .O(m_axi_rdata_IBUF[31]));
  IBUF \m_axi_rdata_IBUF[3]_inst 
       (.I(m_axi_rdata[3]),
        .O(m_axi_rdata_IBUF[3]));
  IBUF \m_axi_rdata_IBUF[4]_inst 
       (.I(m_axi_rdata[4]),
        .O(m_axi_rdata_IBUF[4]));
  IBUF \m_axi_rdata_IBUF[5]_inst 
       (.I(m_axi_rdata[5]),
        .O(m_axi_rdata_IBUF[5]));
  IBUF \m_axi_rdata_IBUF[6]_inst 
       (.I(m_axi_rdata[6]),
        .O(m_axi_rdata_IBUF[6]));
  IBUF \m_axi_rdata_IBUF[7]_inst 
       (.I(m_axi_rdata[7]),
        .O(m_axi_rdata_IBUF[7]));
  IBUF \m_axi_rdata_IBUF[8]_inst 
       (.I(m_axi_rdata[8]),
        .O(m_axi_rdata_IBUF[8]));
  IBUF \m_axi_rdata_IBUF[9]_inst 
       (.I(m_axi_rdata[9]),
        .O(m_axi_rdata_IBUF[9]));
  IBUF m_axi_rlast_IBUF_inst
       (.I(m_axi_rlast),
        .O(m_axi_rlast_IBUF));
  OBUF m_axi_rready_OBUF_inst
       (.I(m_axi_rready_OBUF),
        .O(m_axi_rready));
  IBUF m_axi_rvalid_IBUF_inst
       (.I(m_axi_rvalid),
        .O(m_axi_rvalid_IBUF));
  LUT3 #(
    .INIT(8'h2A)) 
    \m_axi_wdata[31]_i_1 
       (.I0(has_dc_wr_req),
        .I1(m_axi_wready_IBUF),
        .I2(m_axi_wvalid_OBUF),
        .O(\m_axi_wdata[31]_i_1_n_0 ));
  OBUF \m_axi_wdata_OBUF[0]_inst 
       (.I(m_axi_wdata_OBUF[0]),
        .O(m_axi_wdata[0]));
  OBUF \m_axi_wdata_OBUF[10]_inst 
       (.I(m_axi_wdata_OBUF[10]),
        .O(m_axi_wdata[10]));
  OBUF \m_axi_wdata_OBUF[11]_inst 
       (.I(m_axi_wdata_OBUF[11]),
        .O(m_axi_wdata[11]));
  OBUF \m_axi_wdata_OBUF[12]_inst 
       (.I(m_axi_wdata_OBUF[12]),
        .O(m_axi_wdata[12]));
  OBUF \m_axi_wdata_OBUF[13]_inst 
       (.I(m_axi_wdata_OBUF[13]),
        .O(m_axi_wdata[13]));
  OBUF \m_axi_wdata_OBUF[14]_inst 
       (.I(m_axi_wdata_OBUF[14]),
        .O(m_axi_wdata[14]));
  OBUF \m_axi_wdata_OBUF[15]_inst 
       (.I(m_axi_wdata_OBUF[15]),
        .O(m_axi_wdata[15]));
  OBUF \m_axi_wdata_OBUF[16]_inst 
       (.I(m_axi_wdata_OBUF[16]),
        .O(m_axi_wdata[16]));
  OBUF \m_axi_wdata_OBUF[17]_inst 
       (.I(m_axi_wdata_OBUF[17]),
        .O(m_axi_wdata[17]));
  OBUF \m_axi_wdata_OBUF[18]_inst 
       (.I(m_axi_wdata_OBUF[18]),
        .O(m_axi_wdata[18]));
  OBUF \m_axi_wdata_OBUF[19]_inst 
       (.I(m_axi_wdata_OBUF[19]),
        .O(m_axi_wdata[19]));
  OBUF \m_axi_wdata_OBUF[1]_inst 
       (.I(m_axi_wdata_OBUF[1]),
        .O(m_axi_wdata[1]));
  OBUF \m_axi_wdata_OBUF[20]_inst 
       (.I(m_axi_wdata_OBUF[20]),
        .O(m_axi_wdata[20]));
  OBUF \m_axi_wdata_OBUF[21]_inst 
       (.I(m_axi_wdata_OBUF[21]),
        .O(m_axi_wdata[21]));
  OBUF \m_axi_wdata_OBUF[22]_inst 
       (.I(m_axi_wdata_OBUF[22]),
        .O(m_axi_wdata[22]));
  OBUF \m_axi_wdata_OBUF[23]_inst 
       (.I(m_axi_wdata_OBUF[23]),
        .O(m_axi_wdata[23]));
  OBUF \m_axi_wdata_OBUF[24]_inst 
       (.I(m_axi_wdata_OBUF[24]),
        .O(m_axi_wdata[24]));
  OBUF \m_axi_wdata_OBUF[25]_inst 
       (.I(m_axi_wdata_OBUF[25]),
        .O(m_axi_wdata[25]));
  OBUF \m_axi_wdata_OBUF[26]_inst 
       (.I(m_axi_wdata_OBUF[26]),
        .O(m_axi_wdata[26]));
  OBUF \m_axi_wdata_OBUF[27]_inst 
       (.I(m_axi_wdata_OBUF[27]),
        .O(m_axi_wdata[27]));
  OBUF \m_axi_wdata_OBUF[28]_inst 
       (.I(m_axi_wdata_OBUF[28]),
        .O(m_axi_wdata[28]));
  OBUF \m_axi_wdata_OBUF[29]_inst 
       (.I(m_axi_wdata_OBUF[29]),
        .O(m_axi_wdata[29]));
  OBUF \m_axi_wdata_OBUF[2]_inst 
       (.I(m_axi_wdata_OBUF[2]),
        .O(m_axi_wdata[2]));
  OBUF \m_axi_wdata_OBUF[30]_inst 
       (.I(m_axi_wdata_OBUF[30]),
        .O(m_axi_wdata[30]));
  OBUF \m_axi_wdata_OBUF[31]_inst 
       (.I(m_axi_wdata_OBUF[31]),
        .O(m_axi_wdata[31]));
  OBUF \m_axi_wdata_OBUF[3]_inst 
       (.I(m_axi_wdata_OBUF[3]),
        .O(m_axi_wdata[3]));
  OBUF \m_axi_wdata_OBUF[4]_inst 
       (.I(m_axi_wdata_OBUF[4]),
        .O(m_axi_wdata[4]));
  OBUF \m_axi_wdata_OBUF[5]_inst 
       (.I(m_axi_wdata_OBUF[5]),
        .O(m_axi_wdata[5]));
  OBUF \m_axi_wdata_OBUF[6]_inst 
       (.I(m_axi_wdata_OBUF[6]),
        .O(m_axi_wdata[6]));
  OBUF \m_axi_wdata_OBUF[7]_inst 
       (.I(m_axi_wdata_OBUF[7]),
        .O(m_axi_wdata[7]));
  OBUF \m_axi_wdata_OBUF[8]_inst 
       (.I(m_axi_wdata_OBUF[8]),
        .O(m_axi_wdata[8]));
  OBUF \m_axi_wdata_OBUF[9]_inst 
       (.I(m_axi_wdata_OBUF[9]),
        .O(m_axi_wdata[9]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[0] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[0]),
        .Q(m_axi_wdata_OBUF[0]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[10] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[10]),
        .Q(m_axi_wdata_OBUF[10]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[11] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[11]),
        .Q(m_axi_wdata_OBUF[11]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[12] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[12]),
        .Q(m_axi_wdata_OBUF[12]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[13] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[13]),
        .Q(m_axi_wdata_OBUF[13]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[14] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[14]),
        .Q(m_axi_wdata_OBUF[14]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[15] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[15]),
        .Q(m_axi_wdata_OBUF[15]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[16] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[16]),
        .Q(m_axi_wdata_OBUF[16]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[17] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[17]),
        .Q(m_axi_wdata_OBUF[17]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[18] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[18]),
        .Q(m_axi_wdata_OBUF[18]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[19] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[19]),
        .Q(m_axi_wdata_OBUF[19]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[1] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[1]),
        .Q(m_axi_wdata_OBUF[1]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[20] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[20]),
        .Q(m_axi_wdata_OBUF[20]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[21] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[21]),
        .Q(m_axi_wdata_OBUF[21]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[22] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[22]),
        .Q(m_axi_wdata_OBUF[22]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[23] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[23]),
        .Q(m_axi_wdata_OBUF[23]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[24] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[24]),
        .Q(m_axi_wdata_OBUF[24]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[25] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[25]),
        .Q(m_axi_wdata_OBUF[25]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[26] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[26]),
        .Q(m_axi_wdata_OBUF[26]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[27] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[27]),
        .Q(m_axi_wdata_OBUF[27]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[28] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[28]),
        .Q(m_axi_wdata_OBUF[28]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[29] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[29]),
        .Q(m_axi_wdata_OBUF[29]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[2] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[2]),
        .Q(m_axi_wdata_OBUF[2]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[30] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[30]),
        .Q(m_axi_wdata_OBUF[30]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[31] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[31]),
        .Q(m_axi_wdata_OBUF[31]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[3] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[3]),
        .Q(m_axi_wdata_OBUF[3]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[4] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[4]),
        .Q(m_axi_wdata_OBUF[4]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[5] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[5]),
        .Q(m_axi_wdata_OBUF[5]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[6] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[6]),
        .Q(m_axi_wdata_OBUF[6]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[7] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[7]),
        .Q(m_axi_wdata_OBUF[7]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[8] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[8]),
        .Q(m_axi_wdata_OBUF[8]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[9] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wdata_IBUF[9]),
        .Q(m_axi_wdata_OBUF[9]));
  OBUF m_axi_wlast_OBUF_inst
       (.I(m_axi_wvalid_OBUF),
        .O(m_axi_wlast));
  IBUF m_axi_wready_IBUF_inst
       (.I(m_axi_wready),
        .O(m_axi_wready_IBUF));
  OBUF \m_axi_wstrb_OBUF[0]_inst 
       (.I(m_axi_wstrb_OBUF[0]),
        .O(m_axi_wstrb[0]));
  OBUF \m_axi_wstrb_OBUF[1]_inst 
       (.I(m_axi_wstrb_OBUF[1]),
        .O(m_axi_wstrb[1]));
  OBUF \m_axi_wstrb_OBUF[2]_inst 
       (.I(m_axi_wstrb_OBUF[2]),
        .O(m_axi_wstrb[2]));
  OBUF \m_axi_wstrb_OBUF[3]_inst 
       (.I(m_axi_wstrb_OBUF[3]),
        .O(m_axi_wstrb[3]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wstrb_reg[0] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wen_IBUF[0]),
        .Q(m_axi_wstrb_OBUF[0]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wstrb_reg[1] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wen_IBUF[1]),
        .Q(m_axi_wstrb_OBUF[1]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wstrb_reg[2] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wen_IBUF[2]),
        .Q(m_axi_wstrb_OBUF[2]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wstrb_reg[3] 
       (.C(aclk_IBUF_BUFG),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(areset_IBUF),
        .D(dc_cpu_wen_IBUF[3]),
        .Q(m_axi_wstrb_OBUF[3]));
  OBUF m_axi_wvalid_OBUF_inst
       (.I(m_axi_wvalid_OBUF),
        .O(m_axi_wvalid));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h3A)) 
    m_axi_wvalid_i_1
       (.I0(has_dc_wr_req),
        .I1(m_axi_wready_IBUF),
        .I2(m_axi_wvalid_OBUF),
        .O(m_axi_wvalid_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    m_axi_wvalid_reg
       (.C(aclk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(areset_IBUF),
        .D(m_axi_wvalid_i_1_n_0),
        .Q(m_axi_wvalid_OBUF));
endmodule
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
