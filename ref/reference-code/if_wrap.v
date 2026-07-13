// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Wed Apr 29 14:22:33 2026
// Command     : write_verilog -mode funcsim if_wrap.v
// Design      : if_wrap
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tfgg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* IF_IDLE = "2'b01" *) (* IF_READ = "2'b10" *) 
(* NotValidForBitStream *)
module if_wrap
   (clk_i,
    rst_i,
    finish_i,
    pc_i,
    valid_o,
    inst_o,
    inst_rreq,
    inst_addr,
    inst_valid,
    inst_i);
  input clk_i;
  input rst_i;
  input finish_i;
  input [31:0]pc_i;
  output valid_o;
  output [31:0]inst_o;
  output inst_rreq;
  output [31:0]inst_addr;
  input inst_valid;
  input [31:0]inst_i;

  wire clk_i;
  wire clk_i_IBUF;
  wire clk_i_IBUF_BUFG;
  wire finish_i;
  wire finish_i_IBUF;
  wire [1:0]if_nstat;
  wire [1:0]if_state;
  wire [31:0]inst_addr;
  wire [31:0]inst_addr0_in;
  wire \inst_addr[31]_i_1_n_0 ;
  wire [31:0]inst_addr_OBUF;
  wire [31:0]inst_i;
  wire [31:0]inst_i_IBUF;
  wire [31:0]inst_o;
  wire [31:0]inst_o0_in;
  wire \inst_o[31]_i_1_n_0 ;
  wire [31:0]inst_o_OBUF;
  wire inst_rreq;
  wire inst_rreq_OBUF;
  wire inst_rreq_i_1_n_0;
  wire inst_valid;
  wire inst_valid_IBUF;
  wire [31:0]pc_i;
  wire [31:0]pc_i_IBUF;
  wire rst_i;
  wire rst_i_IBUF;
  wire valid_o;
  wire valid_o_OBUF;
  wire valid_o_i_1_n_0;
  wire valid_o_i_2_n_0;

  BUFG clk_i_IBUF_BUFG_inst
       (.I(clk_i_IBUF),
        .O(clk_i_IBUF_BUFG));
  IBUF clk_i_IBUF_inst
       (.I(clk_i),
        .O(clk_i_IBUF));
  IBUF finish_i_IBUF_inst
       (.I(finish_i),
        .O(finish_i_IBUF));
  LUT3 #(
    .INIT(8'h40)) 
    \if_state[0]_i_1 
       (.I0(if_state[0]),
        .I1(finish_i_IBUF),
        .I2(if_state[1]),
        .O(if_nstat[0]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    \if_state[1]_i_1 
       (.I0(if_state[1]),
        .I1(if_state[0]),
        .I2(finish_i_IBUF),
        .O(if_nstat[1]));
  (* FSM_ENCODED_STATES = "IF_READ:10,IF_IDLE:01" *) 
  FDPE #(
    .INIT(1'b1)) 
    \if_state_reg[0] 
       (.C(clk_i_IBUF_BUFG),
        .CE(1'b1),
        .D(if_nstat[0]),
        .PRE(rst_i_IBUF),
        .Q(if_state[0]));
  (* FSM_ENCODED_STATES = "IF_READ:10,IF_IDLE:01" *) 
  FDCE #(
    .INIT(1'b0)) 
    \if_state_reg[1] 
       (.C(clk_i_IBUF_BUFG),
        .CE(1'b1),
        .CLR(rst_i_IBUF),
        .D(if_nstat[1]),
        .Q(if_state[1]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[0]_i_1 
       (.I0(pc_i_IBUF[0]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[10]_i_1 
       (.I0(pc_i_IBUF[10]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[10]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[11]_i_1 
       (.I0(pc_i_IBUF[11]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[11]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[12]_i_1 
       (.I0(pc_i_IBUF[12]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[12]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[13]_i_1 
       (.I0(pc_i_IBUF[13]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[13]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[14]_i_1 
       (.I0(pc_i_IBUF[14]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[14]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[15]_i_1 
       (.I0(pc_i_IBUF[15]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[15]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[16]_i_1 
       (.I0(pc_i_IBUF[16]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[16]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[17]_i_1 
       (.I0(pc_i_IBUF[17]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[17]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[18]_i_1 
       (.I0(pc_i_IBUF[18]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[18]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[19]_i_1 
       (.I0(pc_i_IBUF[19]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[19]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[1]_i_1 
       (.I0(pc_i_IBUF[1]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[20]_i_1 
       (.I0(pc_i_IBUF[20]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[20]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[21]_i_1 
       (.I0(pc_i_IBUF[21]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[21]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[22]_i_1 
       (.I0(pc_i_IBUF[22]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[22]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[23]_i_1 
       (.I0(pc_i_IBUF[23]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[23]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[24]_i_1 
       (.I0(pc_i_IBUF[24]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[24]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[25]_i_1 
       (.I0(pc_i_IBUF[25]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[25]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[26]_i_1 
       (.I0(pc_i_IBUF[26]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[26]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[27]_i_1 
       (.I0(pc_i_IBUF[27]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[27]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[28]_i_1 
       (.I0(pc_i_IBUF[28]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[28]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[29]_i_1 
       (.I0(pc_i_IBUF[29]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[29]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[2]_i_1 
       (.I0(pc_i_IBUF[2]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[30]_i_1 
       (.I0(pc_i_IBUF[30]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[30]));
  LUT2 #(
    .INIT(4'hB)) 
    \inst_addr[31]_i_1 
       (.I0(if_state[0]),
        .I1(if_state[1]),
        .O(\inst_addr[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[31]_i_2 
       (.I0(pc_i_IBUF[31]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[31]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[3]_i_1 
       (.I0(pc_i_IBUF[3]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[4]_i_1 
       (.I0(pc_i_IBUF[4]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[4]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[5]_i_1 
       (.I0(pc_i_IBUF[5]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[5]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[6]_i_1 
       (.I0(pc_i_IBUF[6]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[7]_i_1 
       (.I0(pc_i_IBUF[7]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[7]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[8]_i_1 
       (.I0(pc_i_IBUF[8]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[8]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \inst_addr[9]_i_1 
       (.I0(pc_i_IBUF[9]),
        .I1(if_state[0]),
        .I2(if_state[1]),
        .O(inst_addr0_in[9]));
  OBUF \inst_addr_OBUF[0]_inst 
       (.I(inst_addr_OBUF[0]),
        .O(inst_addr[0]));
  OBUF \inst_addr_OBUF[10]_inst 
       (.I(inst_addr_OBUF[10]),
        .O(inst_addr[10]));
  OBUF \inst_addr_OBUF[11]_inst 
       (.I(inst_addr_OBUF[11]),
        .O(inst_addr[11]));
  OBUF \inst_addr_OBUF[12]_inst 
       (.I(inst_addr_OBUF[12]),
        .O(inst_addr[12]));
  OBUF \inst_addr_OBUF[13]_inst 
       (.I(inst_addr_OBUF[13]),
        .O(inst_addr[13]));
  OBUF \inst_addr_OBUF[14]_inst 
       (.I(inst_addr_OBUF[14]),
        .O(inst_addr[14]));
  OBUF \inst_addr_OBUF[15]_inst 
       (.I(inst_addr_OBUF[15]),
        .O(inst_addr[15]));
  OBUF \inst_addr_OBUF[16]_inst 
       (.I(inst_addr_OBUF[16]),
        .O(inst_addr[16]));
  OBUF \inst_addr_OBUF[17]_inst 
       (.I(inst_addr_OBUF[17]),
        .O(inst_addr[17]));
  OBUF \inst_addr_OBUF[18]_inst 
       (.I(inst_addr_OBUF[18]),
        .O(inst_addr[18]));
  OBUF \inst_addr_OBUF[19]_inst 
       (.I(inst_addr_OBUF[19]),
        .O(inst_addr[19]));
  OBUF \inst_addr_OBUF[1]_inst 
       (.I(inst_addr_OBUF[1]),
        .O(inst_addr[1]));
  OBUF \inst_addr_OBUF[20]_inst 
       (.I(inst_addr_OBUF[20]),
        .O(inst_addr[20]));
  OBUF \inst_addr_OBUF[21]_inst 
       (.I(inst_addr_OBUF[21]),
        .O(inst_addr[21]));
  OBUF \inst_addr_OBUF[22]_inst 
       (.I(inst_addr_OBUF[22]),
        .O(inst_addr[22]));
  OBUF \inst_addr_OBUF[23]_inst 
       (.I(inst_addr_OBUF[23]),
        .O(inst_addr[23]));
  OBUF \inst_addr_OBUF[24]_inst 
       (.I(inst_addr_OBUF[24]),
        .O(inst_addr[24]));
  OBUF \inst_addr_OBUF[25]_inst 
       (.I(inst_addr_OBUF[25]),
        .O(inst_addr[25]));
  OBUF \inst_addr_OBUF[26]_inst 
       (.I(inst_addr_OBUF[26]),
        .O(inst_addr[26]));
  OBUF \inst_addr_OBUF[27]_inst 
       (.I(inst_addr_OBUF[27]),
        .O(inst_addr[27]));
  OBUF \inst_addr_OBUF[28]_inst 
       (.I(inst_addr_OBUF[28]),
        .O(inst_addr[28]));
  OBUF \inst_addr_OBUF[29]_inst 
       (.I(inst_addr_OBUF[29]),
        .O(inst_addr[29]));
  OBUF \inst_addr_OBUF[2]_inst 
       (.I(inst_addr_OBUF[2]),
        .O(inst_addr[2]));
  OBUF \inst_addr_OBUF[30]_inst 
       (.I(inst_addr_OBUF[30]),
        .O(inst_addr[30]));
  OBUF \inst_addr_OBUF[31]_inst 
       (.I(inst_addr_OBUF[31]),
        .O(inst_addr[31]));
  OBUF \inst_addr_OBUF[3]_inst 
       (.I(inst_addr_OBUF[3]),
        .O(inst_addr[3]));
  OBUF \inst_addr_OBUF[4]_inst 
       (.I(inst_addr_OBUF[4]),
        .O(inst_addr[4]));
  OBUF \inst_addr_OBUF[5]_inst 
       (.I(inst_addr_OBUF[5]),
        .O(inst_addr[5]));
  OBUF \inst_addr_OBUF[6]_inst 
       (.I(inst_addr_OBUF[6]),
        .O(inst_addr[6]));
  OBUF \inst_addr_OBUF[7]_inst 
       (.I(inst_addr_OBUF[7]),
        .O(inst_addr[7]));
  OBUF \inst_addr_OBUF[8]_inst 
       (.I(inst_addr_OBUF[8]),
        .O(inst_addr[8]));
  OBUF \inst_addr_OBUF[9]_inst 
       (.I(inst_addr_OBUF[9]),
        .O(inst_addr[9]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[0] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[0]),
        .Q(inst_addr_OBUF[0]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[10] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[10]),
        .Q(inst_addr_OBUF[10]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[11] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[11]),
        .Q(inst_addr_OBUF[11]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[12] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[12]),
        .Q(inst_addr_OBUF[12]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[13] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[13]),
        .Q(inst_addr_OBUF[13]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[14] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[14]),
        .Q(inst_addr_OBUF[14]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[15] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[15]),
        .Q(inst_addr_OBUF[15]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[16] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[16]),
        .Q(inst_addr_OBUF[16]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[17] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[17]),
        .Q(inst_addr_OBUF[17]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[18] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[18]),
        .Q(inst_addr_OBUF[18]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[19] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[19]),
        .Q(inst_addr_OBUF[19]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[1] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[1]),
        .Q(inst_addr_OBUF[1]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[20] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[20]),
        .Q(inst_addr_OBUF[20]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[21] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[21]),
        .Q(inst_addr_OBUF[21]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[22] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[22]),
        .Q(inst_addr_OBUF[22]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[23] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[23]),
        .Q(inst_addr_OBUF[23]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[24] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[24]),
        .Q(inst_addr_OBUF[24]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[25] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[25]),
        .Q(inst_addr_OBUF[25]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[26] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[26]),
        .Q(inst_addr_OBUF[26]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[27] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[27]),
        .Q(inst_addr_OBUF[27]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[28] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[28]),
        .Q(inst_addr_OBUF[28]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[29] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[29]),
        .Q(inst_addr_OBUF[29]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[2] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[2]),
        .Q(inst_addr_OBUF[2]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[30] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[30]),
        .Q(inst_addr_OBUF[30]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[31] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[31]),
        .Q(inst_addr_OBUF[31]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[3] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[3]),
        .Q(inst_addr_OBUF[3]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[4] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[4]),
        .Q(inst_addr_OBUF[4]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[5] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[5]),
        .Q(inst_addr_OBUF[5]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[6] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[6]),
        .Q(inst_addr_OBUF[6]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[7] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[7]),
        .Q(inst_addr_OBUF[7]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[8] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[8]),
        .Q(inst_addr_OBUF[8]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_addr_reg[9] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_addr[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_addr0_in[9]),
        .Q(inst_addr_OBUF[9]));
  IBUF \inst_i_IBUF[0]_inst 
       (.I(inst_i[0]),
        .O(inst_i_IBUF[0]));
  IBUF \inst_i_IBUF[10]_inst 
       (.I(inst_i[10]),
        .O(inst_i_IBUF[10]));
  IBUF \inst_i_IBUF[11]_inst 
       (.I(inst_i[11]),
        .O(inst_i_IBUF[11]));
  IBUF \inst_i_IBUF[12]_inst 
       (.I(inst_i[12]),
        .O(inst_i_IBUF[12]));
  IBUF \inst_i_IBUF[13]_inst 
       (.I(inst_i[13]),
        .O(inst_i_IBUF[13]));
  IBUF \inst_i_IBUF[14]_inst 
       (.I(inst_i[14]),
        .O(inst_i_IBUF[14]));
  IBUF \inst_i_IBUF[15]_inst 
       (.I(inst_i[15]),
        .O(inst_i_IBUF[15]));
  IBUF \inst_i_IBUF[16]_inst 
       (.I(inst_i[16]),
        .O(inst_i_IBUF[16]));
  IBUF \inst_i_IBUF[17]_inst 
       (.I(inst_i[17]),
        .O(inst_i_IBUF[17]));
  IBUF \inst_i_IBUF[18]_inst 
       (.I(inst_i[18]),
        .O(inst_i_IBUF[18]));
  IBUF \inst_i_IBUF[19]_inst 
       (.I(inst_i[19]),
        .O(inst_i_IBUF[19]));
  IBUF \inst_i_IBUF[1]_inst 
       (.I(inst_i[1]),
        .O(inst_i_IBUF[1]));
  IBUF \inst_i_IBUF[20]_inst 
       (.I(inst_i[20]),
        .O(inst_i_IBUF[20]));
  IBUF \inst_i_IBUF[21]_inst 
       (.I(inst_i[21]),
        .O(inst_i_IBUF[21]));
  IBUF \inst_i_IBUF[22]_inst 
       (.I(inst_i[22]),
        .O(inst_i_IBUF[22]));
  IBUF \inst_i_IBUF[23]_inst 
       (.I(inst_i[23]),
        .O(inst_i_IBUF[23]));
  IBUF \inst_i_IBUF[24]_inst 
       (.I(inst_i[24]),
        .O(inst_i_IBUF[24]));
  IBUF \inst_i_IBUF[25]_inst 
       (.I(inst_i[25]),
        .O(inst_i_IBUF[25]));
  IBUF \inst_i_IBUF[26]_inst 
       (.I(inst_i[26]),
        .O(inst_i_IBUF[26]));
  IBUF \inst_i_IBUF[27]_inst 
       (.I(inst_i[27]),
        .O(inst_i_IBUF[27]));
  IBUF \inst_i_IBUF[28]_inst 
       (.I(inst_i[28]),
        .O(inst_i_IBUF[28]));
  IBUF \inst_i_IBUF[29]_inst 
       (.I(inst_i[29]),
        .O(inst_i_IBUF[29]));
  IBUF \inst_i_IBUF[2]_inst 
       (.I(inst_i[2]),
        .O(inst_i_IBUF[2]));
  IBUF \inst_i_IBUF[30]_inst 
       (.I(inst_i[30]),
        .O(inst_i_IBUF[30]));
  IBUF \inst_i_IBUF[31]_inst 
       (.I(inst_i[31]),
        .O(inst_i_IBUF[31]));
  IBUF \inst_i_IBUF[3]_inst 
       (.I(inst_i[3]),
        .O(inst_i_IBUF[3]));
  IBUF \inst_i_IBUF[4]_inst 
       (.I(inst_i[4]),
        .O(inst_i_IBUF[4]));
  IBUF \inst_i_IBUF[5]_inst 
       (.I(inst_i[5]),
        .O(inst_i_IBUF[5]));
  IBUF \inst_i_IBUF[6]_inst 
       (.I(inst_i[6]),
        .O(inst_i_IBUF[6]));
  IBUF \inst_i_IBUF[7]_inst 
       (.I(inst_i[7]),
        .O(inst_i_IBUF[7]));
  IBUF \inst_i_IBUF[8]_inst 
       (.I(inst_i[8]),
        .O(inst_i_IBUF[8]));
  IBUF \inst_i_IBUF[9]_inst 
       (.I(inst_i[9]),
        .O(inst_i_IBUF[9]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'hFDFF)) 
    \inst_o[0]_i_1 
       (.I0(if_state[1]),
        .I1(if_state[0]),
        .I2(inst_i_IBUF[0]),
        .I3(inst_valid_IBUF),
        .O(inst_o0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[10]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[10]),
        .I3(if_state[1]),
        .O(inst_o0_in[10]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[11]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[11]),
        .I3(if_state[1]),
        .O(inst_o0_in[11]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[12]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[12]),
        .I3(if_state[1]),
        .O(inst_o0_in[12]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[13]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[13]),
        .I3(if_state[1]),
        .O(inst_o0_in[13]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[14]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[14]),
        .I3(if_state[1]),
        .O(inst_o0_in[14]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[15]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[15]),
        .I3(if_state[1]),
        .O(inst_o0_in[15]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[16]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[16]),
        .I3(if_state[1]),
        .O(inst_o0_in[16]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[17]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[17]),
        .I3(if_state[1]),
        .O(inst_o0_in[17]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[18]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[18]),
        .I3(if_state[1]),
        .O(inst_o0_in[18]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[19]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[19]),
        .I3(if_state[1]),
        .O(inst_o0_in[19]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'hFDFF)) 
    \inst_o[1]_i_1 
       (.I0(if_state[1]),
        .I1(if_state[0]),
        .I2(inst_i_IBUF[1]),
        .I3(inst_valid_IBUF),
        .O(inst_o0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[20]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[20]),
        .I3(if_state[1]),
        .O(inst_o0_in[20]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[21]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[21]),
        .I3(if_state[1]),
        .O(inst_o0_in[21]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[22]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[22]),
        .I3(if_state[1]),
        .O(inst_o0_in[22]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[23]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[23]),
        .I3(if_state[1]),
        .O(inst_o0_in[23]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[24]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[24]),
        .I3(if_state[1]),
        .O(inst_o0_in[24]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[25]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[25]),
        .I3(if_state[1]),
        .O(inst_o0_in[25]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[26]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[26]),
        .I3(if_state[1]),
        .O(inst_o0_in[26]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[27]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[27]),
        .I3(if_state[1]),
        .O(inst_o0_in[27]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[28]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[28]),
        .I3(if_state[1]),
        .O(inst_o0_in[28]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[29]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[29]),
        .I3(if_state[1]),
        .O(inst_o0_in[29]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[2]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[2]),
        .I3(if_state[1]),
        .O(inst_o0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[30]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[30]),
        .I3(if_state[1]),
        .O(inst_o0_in[30]));
  LUT2 #(
    .INIT(4'hB)) 
    \inst_o[31]_i_1 
       (.I0(if_state[1]),
        .I1(if_state[0]),
        .O(\inst_o[31]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[31]_i_2 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[31]),
        .I3(if_state[1]),
        .O(inst_o0_in[31]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[3]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[3]),
        .I3(if_state[1]),
        .O(inst_o0_in[3]));
  LUT4 #(
    .INIT(16'hFDFF)) 
    \inst_o[4]_i_1 
       (.I0(if_state[1]),
        .I1(if_state[0]),
        .I2(inst_i_IBUF[4]),
        .I3(inst_valid_IBUF),
        .O(inst_o0_in[4]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[5]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[5]),
        .I3(if_state[1]),
        .O(inst_o0_in[5]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[6]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[6]),
        .I3(if_state[1]),
        .O(inst_o0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[7]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[7]),
        .I3(if_state[1]),
        .O(inst_o0_in[7]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[8]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[8]),
        .I3(if_state[1]),
        .O(inst_o0_in[8]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \inst_o[9]_i_1 
       (.I0(if_state[0]),
        .I1(inst_valid_IBUF),
        .I2(inst_i_IBUF[9]),
        .I3(if_state[1]),
        .O(inst_o0_in[9]));
  OBUF \inst_o_OBUF[0]_inst 
       (.I(inst_o_OBUF[0]),
        .O(inst_o[0]));
  OBUF \inst_o_OBUF[10]_inst 
       (.I(inst_o_OBUF[10]),
        .O(inst_o[10]));
  OBUF \inst_o_OBUF[11]_inst 
       (.I(inst_o_OBUF[11]),
        .O(inst_o[11]));
  OBUF \inst_o_OBUF[12]_inst 
       (.I(inst_o_OBUF[12]),
        .O(inst_o[12]));
  OBUF \inst_o_OBUF[13]_inst 
       (.I(inst_o_OBUF[13]),
        .O(inst_o[13]));
  OBUF \inst_o_OBUF[14]_inst 
       (.I(inst_o_OBUF[14]),
        .O(inst_o[14]));
  OBUF \inst_o_OBUF[15]_inst 
       (.I(inst_o_OBUF[15]),
        .O(inst_o[15]));
  OBUF \inst_o_OBUF[16]_inst 
       (.I(inst_o_OBUF[16]),
        .O(inst_o[16]));
  OBUF \inst_o_OBUF[17]_inst 
       (.I(inst_o_OBUF[17]),
        .O(inst_o[17]));
  OBUF \inst_o_OBUF[18]_inst 
       (.I(inst_o_OBUF[18]),
        .O(inst_o[18]));
  OBUF \inst_o_OBUF[19]_inst 
       (.I(inst_o_OBUF[19]),
        .O(inst_o[19]));
  OBUF \inst_o_OBUF[1]_inst 
       (.I(inst_o_OBUF[1]),
        .O(inst_o[1]));
  OBUF \inst_o_OBUF[20]_inst 
       (.I(inst_o_OBUF[20]),
        .O(inst_o[20]));
  OBUF \inst_o_OBUF[21]_inst 
       (.I(inst_o_OBUF[21]),
        .O(inst_o[21]));
  OBUF \inst_o_OBUF[22]_inst 
       (.I(inst_o_OBUF[22]),
        .O(inst_o[22]));
  OBUF \inst_o_OBUF[23]_inst 
       (.I(inst_o_OBUF[23]),
        .O(inst_o[23]));
  OBUF \inst_o_OBUF[24]_inst 
       (.I(inst_o_OBUF[24]),
        .O(inst_o[24]));
  OBUF \inst_o_OBUF[25]_inst 
       (.I(inst_o_OBUF[25]),
        .O(inst_o[25]));
  OBUF \inst_o_OBUF[26]_inst 
       (.I(inst_o_OBUF[26]),
        .O(inst_o[26]));
  OBUF \inst_o_OBUF[27]_inst 
       (.I(inst_o_OBUF[27]),
        .O(inst_o[27]));
  OBUF \inst_o_OBUF[28]_inst 
       (.I(inst_o_OBUF[28]),
        .O(inst_o[28]));
  OBUF \inst_o_OBUF[29]_inst 
       (.I(inst_o_OBUF[29]),
        .O(inst_o[29]));
  OBUF \inst_o_OBUF[2]_inst 
       (.I(inst_o_OBUF[2]),
        .O(inst_o[2]));
  OBUF \inst_o_OBUF[30]_inst 
       (.I(inst_o_OBUF[30]),
        .O(inst_o[30]));
  OBUF \inst_o_OBUF[31]_inst 
       (.I(inst_o_OBUF[31]),
        .O(inst_o[31]));
  OBUF \inst_o_OBUF[3]_inst 
       (.I(inst_o_OBUF[3]),
        .O(inst_o[3]));
  OBUF \inst_o_OBUF[4]_inst 
       (.I(inst_o_OBUF[4]),
        .O(inst_o[4]));
  OBUF \inst_o_OBUF[5]_inst 
       (.I(inst_o_OBUF[5]),
        .O(inst_o[5]));
  OBUF \inst_o_OBUF[6]_inst 
       (.I(inst_o_OBUF[6]),
        .O(inst_o[6]));
  OBUF \inst_o_OBUF[7]_inst 
       (.I(inst_o_OBUF[7]),
        .O(inst_o[7]));
  OBUF \inst_o_OBUF[8]_inst 
       (.I(inst_o_OBUF[8]),
        .O(inst_o[8]));
  OBUF \inst_o_OBUF[9]_inst 
       (.I(inst_o_OBUF[9]),
        .O(inst_o[9]));
  FDPE #(
    .INIT(1'b1)) 
    \inst_o_reg[0] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .D(inst_o0_in[0]),
        .PRE(rst_i_IBUF),
        .Q(inst_o_OBUF[0]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[10] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[10]),
        .Q(inst_o_OBUF[10]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[11] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[11]),
        .Q(inst_o_OBUF[11]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[12] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[12]),
        .Q(inst_o_OBUF[12]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[13] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[13]),
        .Q(inst_o_OBUF[13]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[14] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[14]),
        .Q(inst_o_OBUF[14]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[15] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[15]),
        .Q(inst_o_OBUF[15]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[16] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[16]),
        .Q(inst_o_OBUF[16]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[17] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[17]),
        .Q(inst_o_OBUF[17]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[18] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[18]),
        .Q(inst_o_OBUF[18]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[19] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[19]),
        .Q(inst_o_OBUF[19]));
  FDPE #(
    .INIT(1'b1)) 
    \inst_o_reg[1] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .D(inst_o0_in[1]),
        .PRE(rst_i_IBUF),
        .Q(inst_o_OBUF[1]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[20] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[20]),
        .Q(inst_o_OBUF[20]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[21] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[21]),
        .Q(inst_o_OBUF[21]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[22] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[22]),
        .Q(inst_o_OBUF[22]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[23] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[23]),
        .Q(inst_o_OBUF[23]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[24] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[24]),
        .Q(inst_o_OBUF[24]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[25] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[25]),
        .Q(inst_o_OBUF[25]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[26] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[26]),
        .Q(inst_o_OBUF[26]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[27] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[27]),
        .Q(inst_o_OBUF[27]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[28] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[28]),
        .Q(inst_o_OBUF[28]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[29] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[29]),
        .Q(inst_o_OBUF[29]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[2] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[2]),
        .Q(inst_o_OBUF[2]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[30] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[30]),
        .Q(inst_o_OBUF[30]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[31] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[31]),
        .Q(inst_o_OBUF[31]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[3] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[3]),
        .Q(inst_o_OBUF[3]));
  FDPE #(
    .INIT(1'b1)) 
    \inst_o_reg[4] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .D(inst_o0_in[4]),
        .PRE(rst_i_IBUF),
        .Q(inst_o_OBUF[4]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[5] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[5]),
        .Q(inst_o_OBUF[5]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[6] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[6]),
        .Q(inst_o_OBUF[6]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[7] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[7]),
        .Q(inst_o_OBUF[7]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[8] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[8]),
        .Q(inst_o_OBUF[8]));
  FDCE #(
    .INIT(1'b0)) 
    \inst_o_reg[9] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\inst_o[31]_i_1_n_0 ),
        .CLR(rst_i_IBUF),
        .D(inst_o0_in[9]),
        .Q(inst_o_OBUF[9]));
  OBUF inst_rreq_OBUF_inst
       (.I(inst_rreq_OBUF),
        .O(inst_rreq));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h2)) 
    inst_rreq_i_1
       (.I0(if_state[0]),
        .I1(if_state[1]),
        .O(inst_rreq_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    inst_rreq_reg
       (.C(clk_i_IBUF_BUFG),
        .CE(1'b1),
        .CLR(rst_i_IBUF),
        .D(inst_rreq_i_1_n_0),
        .Q(inst_rreq_OBUF));
  IBUF inst_valid_IBUF_inst
       (.I(inst_valid),
        .O(inst_valid_IBUF));
  IBUF \pc_i_IBUF[0]_inst 
       (.I(pc_i[0]),
        .O(pc_i_IBUF[0]));
  IBUF \pc_i_IBUF[10]_inst 
       (.I(pc_i[10]),
        .O(pc_i_IBUF[10]));
  IBUF \pc_i_IBUF[11]_inst 
       (.I(pc_i[11]),
        .O(pc_i_IBUF[11]));
  IBUF \pc_i_IBUF[12]_inst 
       (.I(pc_i[12]),
        .O(pc_i_IBUF[12]));
  IBUF \pc_i_IBUF[13]_inst 
       (.I(pc_i[13]),
        .O(pc_i_IBUF[13]));
  IBUF \pc_i_IBUF[14]_inst 
       (.I(pc_i[14]),
        .O(pc_i_IBUF[14]));
  IBUF \pc_i_IBUF[15]_inst 
       (.I(pc_i[15]),
        .O(pc_i_IBUF[15]));
  IBUF \pc_i_IBUF[16]_inst 
       (.I(pc_i[16]),
        .O(pc_i_IBUF[16]));
  IBUF \pc_i_IBUF[17]_inst 
       (.I(pc_i[17]),
        .O(pc_i_IBUF[17]));
  IBUF \pc_i_IBUF[18]_inst 
       (.I(pc_i[18]),
        .O(pc_i_IBUF[18]));
  IBUF \pc_i_IBUF[19]_inst 
       (.I(pc_i[19]),
        .O(pc_i_IBUF[19]));
  IBUF \pc_i_IBUF[1]_inst 
       (.I(pc_i[1]),
        .O(pc_i_IBUF[1]));
  IBUF \pc_i_IBUF[20]_inst 
       (.I(pc_i[20]),
        .O(pc_i_IBUF[20]));
  IBUF \pc_i_IBUF[21]_inst 
       (.I(pc_i[21]),
        .O(pc_i_IBUF[21]));
  IBUF \pc_i_IBUF[22]_inst 
       (.I(pc_i[22]),
        .O(pc_i_IBUF[22]));
  IBUF \pc_i_IBUF[23]_inst 
       (.I(pc_i[23]),
        .O(pc_i_IBUF[23]));
  IBUF \pc_i_IBUF[24]_inst 
       (.I(pc_i[24]),
        .O(pc_i_IBUF[24]));
  IBUF \pc_i_IBUF[25]_inst 
       (.I(pc_i[25]),
        .O(pc_i_IBUF[25]));
  IBUF \pc_i_IBUF[26]_inst 
       (.I(pc_i[26]),
        .O(pc_i_IBUF[26]));
  IBUF \pc_i_IBUF[27]_inst 
       (.I(pc_i[27]),
        .O(pc_i_IBUF[27]));
  IBUF \pc_i_IBUF[28]_inst 
       (.I(pc_i[28]),
        .O(pc_i_IBUF[28]));
  IBUF \pc_i_IBUF[29]_inst 
       (.I(pc_i[29]),
        .O(pc_i_IBUF[29]));
  IBUF \pc_i_IBUF[2]_inst 
       (.I(pc_i[2]),
        .O(pc_i_IBUF[2]));
  IBUF \pc_i_IBUF[30]_inst 
       (.I(pc_i[30]),
        .O(pc_i_IBUF[30]));
  IBUF \pc_i_IBUF[31]_inst 
       (.I(pc_i[31]),
        .O(pc_i_IBUF[31]));
  IBUF \pc_i_IBUF[3]_inst 
       (.I(pc_i[3]),
        .O(pc_i_IBUF[3]));
  IBUF \pc_i_IBUF[4]_inst 
       (.I(pc_i[4]),
        .O(pc_i_IBUF[4]));
  IBUF \pc_i_IBUF[5]_inst 
       (.I(pc_i[5]),
        .O(pc_i_IBUF[5]));
  IBUF \pc_i_IBUF[6]_inst 
       (.I(pc_i[6]),
        .O(pc_i_IBUF[6]));
  IBUF \pc_i_IBUF[7]_inst 
       (.I(pc_i[7]),
        .O(pc_i_IBUF[7]));
  IBUF \pc_i_IBUF[8]_inst 
       (.I(pc_i[8]),
        .O(pc_i_IBUF[8]));
  IBUF \pc_i_IBUF[9]_inst 
       (.I(pc_i[9]),
        .O(pc_i_IBUF[9]));
  IBUF rst_i_IBUF_inst
       (.I(rst_i),
        .O(rst_i_IBUF));
  OBUF valid_o_OBUF_inst
       (.I(valid_o_OBUF),
        .O(valid_o));
  LUT2 #(
    .INIT(4'h6)) 
    valid_o_i_1
       (.I0(if_state[0]),
        .I1(if_state[1]),
        .O(valid_o_i_1_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    valid_o_i_2
       (.I0(if_state[1]),
        .I1(inst_valid_IBUF),
        .O(valid_o_i_2_n_0));
  FDCE #(
    .INIT(1'b0)) 
    valid_o_reg
       (.C(clk_i_IBUF_BUFG),
        .CE(valid_o_i_1_n_0),
        .CLR(rst_i_IBUF),
        .D(valid_o_i_2_n_0),
        .Q(valid_o_OBUF));
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
