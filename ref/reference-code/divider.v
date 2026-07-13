// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Wed Apr 29 14:28:50 2026
// Command     : write_verilog -mode funcsim divider.v
// Design      : divider
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tfgg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* LOG_W = "5" *) (* WIDTH = "32" *) 
(* NotValidForBitStream *)
module divider
   (clk,
    rst,
    x,
    y,
    start,
    z,
    r,
    busy);
  input clk;
  input rst;
  input [31:0]x;
  input [31:0]y;
  input start;
  output [31:0]z;
  output [31:0]r;
  output busy;

  wire busy;
  wire busy_OBUF;
  wire busy_i_1_n_0;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire \cnt[0]_i_1_n_0 ;
  wire \cnt[1]_i_1_n_0 ;
  wire \cnt[2]_i_1_n_0 ;
  wire \cnt[3]_i_1_n_0 ;
  wire \cnt[4]_i_1_n_0 ;
  wire \cnt[5]_i_1_n_0 ;
  wire \cnt[5]_i_2_n_0 ;
  wire cnt_end;
  wire [5:0]cnt_reg;
  wire [63:32]mux_out2;
  wire [31:0]p_0_in;
  wire [31:0]p_1_in;
  wire [31:0]p_2_in;
  wire quotient;
  wire \quotient[0]_i_1_n_0 ;
  wire \quotient[10]_i_1_n_0 ;
  wire \quotient[11]_i_1_n_0 ;
  wire \quotient[12]_i_1_n_0 ;
  wire \quotient[13]_i_1_n_0 ;
  wire \quotient[14]_i_1_n_0 ;
  wire \quotient[15]_i_1_n_0 ;
  wire \quotient[16]_i_1_n_0 ;
  wire \quotient[17]_i_1_n_0 ;
  wire \quotient[18]_i_1_n_0 ;
  wire \quotient[19]_i_1_n_0 ;
  wire \quotient[1]_i_1_n_0 ;
  wire \quotient[20]_i_1_n_0 ;
  wire \quotient[21]_i_1_n_0 ;
  wire \quotient[22]_i_1_n_0 ;
  wire \quotient[23]_i_1_n_0 ;
  wire \quotient[24]_i_1_n_0 ;
  wire \quotient[25]_i_1_n_0 ;
  wire \quotient[26]_i_1_n_0 ;
  wire \quotient[27]_i_1_n_0 ;
  wire \quotient[28]_i_1_n_0 ;
  wire \quotient[29]_i_1_n_0 ;
  wire \quotient[2]_i_1_n_0 ;
  wire \quotient[30]_i_2_n_0 ;
  wire \quotient[3]_i_1_n_0 ;
  wire \quotient[4]_i_1_n_0 ;
  wire \quotient[5]_i_1_n_0 ;
  wire \quotient[6]_i_1_n_0 ;
  wire \quotient[7]_i_1_n_0 ;
  wire \quotient[8]_i_1_n_0 ;
  wire \quotient[9]_i_1_n_0 ;
  wire [31:0]r;
  wire \r[11]_i_11_n_0 ;
  wire \r[11]_i_12_n_0 ;
  wire \r[11]_i_13_n_0 ;
  wire \r[11]_i_14_n_0 ;
  wire \r[11]_i_2_n_0 ;
  wire \r[11]_i_3_n_0 ;
  wire \r[11]_i_4_n_0 ;
  wire \r[11]_i_5_n_0 ;
  wire \r[11]_i_6_n_0 ;
  wire \r[11]_i_7_n_0 ;
  wire \r[11]_i_8_n_0 ;
  wire \r[11]_i_9_n_0 ;
  wire \r[15]_i_11_n_0 ;
  wire \r[15]_i_12_n_0 ;
  wire \r[15]_i_13_n_0 ;
  wire \r[15]_i_14_n_0 ;
  wire \r[15]_i_2_n_0 ;
  wire \r[15]_i_3_n_0 ;
  wire \r[15]_i_4_n_0 ;
  wire \r[15]_i_5_n_0 ;
  wire \r[15]_i_6_n_0 ;
  wire \r[15]_i_7_n_0 ;
  wire \r[15]_i_8_n_0 ;
  wire \r[15]_i_9_n_0 ;
  wire \r[19]_i_11_n_0 ;
  wire \r[19]_i_12_n_0 ;
  wire \r[19]_i_13_n_0 ;
  wire \r[19]_i_14_n_0 ;
  wire \r[19]_i_2_n_0 ;
  wire \r[19]_i_3_n_0 ;
  wire \r[19]_i_4_n_0 ;
  wire \r[19]_i_5_n_0 ;
  wire \r[19]_i_6_n_0 ;
  wire \r[19]_i_7_n_0 ;
  wire \r[19]_i_8_n_0 ;
  wire \r[19]_i_9_n_0 ;
  wire \r[23]_i_11_n_0 ;
  wire \r[23]_i_12_n_0 ;
  wire \r[23]_i_13_n_0 ;
  wire \r[23]_i_14_n_0 ;
  wire \r[23]_i_2_n_0 ;
  wire \r[23]_i_3_n_0 ;
  wire \r[23]_i_4_n_0 ;
  wire \r[23]_i_5_n_0 ;
  wire \r[23]_i_6_n_0 ;
  wire \r[23]_i_7_n_0 ;
  wire \r[23]_i_8_n_0 ;
  wire \r[23]_i_9_n_0 ;
  wire \r[27]_i_11_n_0 ;
  wire \r[27]_i_12_n_0 ;
  wire \r[27]_i_13_n_0 ;
  wire \r[27]_i_14_n_0 ;
  wire \r[27]_i_2_n_0 ;
  wire \r[27]_i_3_n_0 ;
  wire \r[27]_i_4_n_0 ;
  wire \r[27]_i_5_n_0 ;
  wire \r[27]_i_6_n_0 ;
  wire \r[27]_i_7_n_0 ;
  wire \r[27]_i_8_n_0 ;
  wire \r[27]_i_9_n_0 ;
  wire \r[31]_i_11_n_0 ;
  wire \r[31]_i_12_n_0 ;
  wire \r[31]_i_13_n_0 ;
  wire \r[31]_i_2_n_0 ;
  wire \r[31]_i_3_n_0 ;
  wire \r[31]_i_4_n_0 ;
  wire \r[31]_i_5_n_0 ;
  wire \r[31]_i_6_n_0 ;
  wire \r[31]_i_7_n_0 ;
  wire \r[31]_i_8_n_0 ;
  wire \r[3]_i_11_n_0 ;
  wire \r[3]_i_12_n_0 ;
  wire \r[3]_i_13_n_0 ;
  wire \r[3]_i_14_n_0 ;
  wire \r[3]_i_2_n_0 ;
  wire \r[3]_i_3_n_0 ;
  wire \r[3]_i_4_n_0 ;
  wire \r[3]_i_5_n_0 ;
  wire \r[3]_i_6_n_0 ;
  wire \r[3]_i_7_n_0 ;
  wire \r[3]_i_8_n_0 ;
  wire \r[3]_i_9_n_0 ;
  wire \r[7]_i_11_n_0 ;
  wire \r[7]_i_12_n_0 ;
  wire \r[7]_i_13_n_0 ;
  wire \r[7]_i_14_n_0 ;
  wire \r[7]_i_2_n_0 ;
  wire \r[7]_i_3_n_0 ;
  wire \r[7]_i_4_n_0 ;
  wire \r[7]_i_5_n_0 ;
  wire \r[7]_i_6_n_0 ;
  wire \r[7]_i_7_n_0 ;
  wire \r[7]_i_8_n_0 ;
  wire \r[7]_i_9_n_0 ;
  wire [31:0]r_OBUF;
  wire [30:0]r_d1;
  wire \r_reg[11]_i_10_n_0 ;
  wire \r_reg[11]_i_10_n_1 ;
  wire \r_reg[11]_i_10_n_2 ;
  wire \r_reg[11]_i_10_n_3 ;
  wire \r_reg[11]_i_1_n_0 ;
  wire \r_reg[11]_i_1_n_1 ;
  wire \r_reg[11]_i_1_n_2 ;
  wire \r_reg[11]_i_1_n_3 ;
  wire \r_reg[11]_i_1_n_4 ;
  wire \r_reg[11]_i_1_n_5 ;
  wire \r_reg[11]_i_1_n_6 ;
  wire \r_reg[11]_i_1_n_7 ;
  wire \r_reg[15]_i_10_n_0 ;
  wire \r_reg[15]_i_10_n_1 ;
  wire \r_reg[15]_i_10_n_2 ;
  wire \r_reg[15]_i_10_n_3 ;
  wire \r_reg[15]_i_1_n_0 ;
  wire \r_reg[15]_i_1_n_1 ;
  wire \r_reg[15]_i_1_n_2 ;
  wire \r_reg[15]_i_1_n_3 ;
  wire \r_reg[15]_i_1_n_4 ;
  wire \r_reg[15]_i_1_n_5 ;
  wire \r_reg[15]_i_1_n_6 ;
  wire \r_reg[15]_i_1_n_7 ;
  wire \r_reg[19]_i_10_n_0 ;
  wire \r_reg[19]_i_10_n_1 ;
  wire \r_reg[19]_i_10_n_2 ;
  wire \r_reg[19]_i_10_n_3 ;
  wire \r_reg[19]_i_1_n_0 ;
  wire \r_reg[19]_i_1_n_1 ;
  wire \r_reg[19]_i_1_n_2 ;
  wire \r_reg[19]_i_1_n_3 ;
  wire \r_reg[19]_i_1_n_4 ;
  wire \r_reg[19]_i_1_n_5 ;
  wire \r_reg[19]_i_1_n_6 ;
  wire \r_reg[19]_i_1_n_7 ;
  wire \r_reg[23]_i_10_n_0 ;
  wire \r_reg[23]_i_10_n_1 ;
  wire \r_reg[23]_i_10_n_2 ;
  wire \r_reg[23]_i_10_n_3 ;
  wire \r_reg[23]_i_1_n_0 ;
  wire \r_reg[23]_i_1_n_1 ;
  wire \r_reg[23]_i_1_n_2 ;
  wire \r_reg[23]_i_1_n_3 ;
  wire \r_reg[23]_i_1_n_4 ;
  wire \r_reg[23]_i_1_n_5 ;
  wire \r_reg[23]_i_1_n_6 ;
  wire \r_reg[23]_i_1_n_7 ;
  wire \r_reg[27]_i_10_n_0 ;
  wire \r_reg[27]_i_10_n_1 ;
  wire \r_reg[27]_i_10_n_2 ;
  wire \r_reg[27]_i_10_n_3 ;
  wire \r_reg[27]_i_1_n_0 ;
  wire \r_reg[27]_i_1_n_1 ;
  wire \r_reg[27]_i_1_n_2 ;
  wire \r_reg[27]_i_1_n_3 ;
  wire \r_reg[27]_i_1_n_4 ;
  wire \r_reg[27]_i_1_n_5 ;
  wire \r_reg[27]_i_1_n_6 ;
  wire \r_reg[27]_i_1_n_7 ;
  wire \r_reg[31]_i_10_n_2 ;
  wire \r_reg[31]_i_10_n_3 ;
  wire \r_reg[31]_i_1_n_1 ;
  wire \r_reg[31]_i_1_n_2 ;
  wire \r_reg[31]_i_1_n_3 ;
  wire \r_reg[31]_i_1_n_4 ;
  wire \r_reg[31]_i_1_n_5 ;
  wire \r_reg[31]_i_1_n_6 ;
  wire \r_reg[31]_i_1_n_7 ;
  wire \r_reg[3]_i_10_n_0 ;
  wire \r_reg[3]_i_10_n_1 ;
  wire \r_reg[3]_i_10_n_2 ;
  wire \r_reg[3]_i_10_n_3 ;
  wire \r_reg[3]_i_1_n_0 ;
  wire \r_reg[3]_i_1_n_1 ;
  wire \r_reg[3]_i_1_n_2 ;
  wire \r_reg[3]_i_1_n_3 ;
  wire \r_reg[3]_i_1_n_4 ;
  wire \r_reg[3]_i_1_n_5 ;
  wire \r_reg[3]_i_1_n_6 ;
  wire \r_reg[3]_i_1_n_7 ;
  wire \r_reg[7]_i_10_n_0 ;
  wire \r_reg[7]_i_10_n_1 ;
  wire \r_reg[7]_i_10_n_2 ;
  wire \r_reg[7]_i_10_n_3 ;
  wire \r_reg[7]_i_1_n_0 ;
  wire \r_reg[7]_i_1_n_1 ;
  wire \r_reg[7]_i_1_n_2 ;
  wire \r_reg[7]_i_1_n_3 ;
  wire \r_reg[7]_i_1_n_4 ;
  wire \r_reg[7]_i_1_n_5 ;
  wire \r_reg[7]_i_1_n_6 ;
  wire \r_reg[7]_i_1_n_7 ;
  wire \remainder[10]_i_1_n_0 ;
  wire \remainder[11]_i_1_n_0 ;
  wire \remainder[12]_i_1_n_0 ;
  wire \remainder[13]_i_1_n_0 ;
  wire \remainder[14]_i_1_n_0 ;
  wire \remainder[15]_i_1_n_0 ;
  wire \remainder[16]_i_1_n_0 ;
  wire \remainder[17]_i_1_n_0 ;
  wire \remainder[18]_i_1_n_0 ;
  wire \remainder[19]_i_1_n_0 ;
  wire \remainder[1]_i_1_n_0 ;
  wire \remainder[20]_i_1_n_0 ;
  wire \remainder[21]_i_1_n_0 ;
  wire \remainder[22]_i_1_n_0 ;
  wire \remainder[23]_i_1_n_0 ;
  wire \remainder[24]_i_1_n_0 ;
  wire \remainder[25]_i_1_n_0 ;
  wire \remainder[26]_i_1_n_0 ;
  wire \remainder[27]_i_1_n_0 ;
  wire \remainder[28]_i_1_n_0 ;
  wire \remainder[29]_i_1_n_0 ;
  wire \remainder[2]_i_1_n_0 ;
  wire \remainder[30]_i_1_n_0 ;
  wire \remainder[31]_i_1_n_0 ;
  wire \remainder[32]_i_1_n_0 ;
  wire \remainder[33]_i_1_n_0 ;
  wire \remainder[34]_i_1_n_0 ;
  wire \remainder[35]_i_10_n_0 ;
  wire \remainder[35]_i_11_n_0 ;
  wire \remainder[35]_i_12_n_0 ;
  wire \remainder[35]_i_1_n_0 ;
  wire \remainder[35]_i_5_n_0 ;
  wire \remainder[35]_i_6_n_0 ;
  wire \remainder[35]_i_7_n_0 ;
  wire \remainder[35]_i_8_n_0 ;
  wire \remainder[35]_i_9_n_0 ;
  wire \remainder[36]_i_1_n_0 ;
  wire \remainder[37]_i_1_n_0 ;
  wire \remainder[38]_i_1_n_0 ;
  wire \remainder[39]_i_10_n_0 ;
  wire \remainder[39]_i_11_n_0 ;
  wire \remainder[39]_i_12_n_0 ;
  wire \remainder[39]_i_1_n_0 ;
  wire \remainder[39]_i_5_n_0 ;
  wire \remainder[39]_i_6_n_0 ;
  wire \remainder[39]_i_7_n_0 ;
  wire \remainder[39]_i_8_n_0 ;
  wire \remainder[39]_i_9_n_0 ;
  wire \remainder[3]_i_1_n_0 ;
  wire \remainder[40]_i_1_n_0 ;
  wire \remainder[41]_i_1_n_0 ;
  wire \remainder[42]_i_1_n_0 ;
  wire \remainder[43]_i_10_n_0 ;
  wire \remainder[43]_i_11_n_0 ;
  wire \remainder[43]_i_12_n_0 ;
  wire \remainder[43]_i_1_n_0 ;
  wire \remainder[43]_i_5_n_0 ;
  wire \remainder[43]_i_6_n_0 ;
  wire \remainder[43]_i_7_n_0 ;
  wire \remainder[43]_i_8_n_0 ;
  wire \remainder[43]_i_9_n_0 ;
  wire \remainder[44]_i_1_n_0 ;
  wire \remainder[45]_i_1_n_0 ;
  wire \remainder[46]_i_1_n_0 ;
  wire \remainder[47]_i_10_n_0 ;
  wire \remainder[47]_i_11_n_0 ;
  wire \remainder[47]_i_12_n_0 ;
  wire \remainder[47]_i_1_n_0 ;
  wire \remainder[47]_i_5_n_0 ;
  wire \remainder[47]_i_6_n_0 ;
  wire \remainder[47]_i_7_n_0 ;
  wire \remainder[47]_i_8_n_0 ;
  wire \remainder[47]_i_9_n_0 ;
  wire \remainder[48]_i_1_n_0 ;
  wire \remainder[49]_i_1_n_0 ;
  wire \remainder[4]_i_1_n_0 ;
  wire \remainder[50]_i_1_n_0 ;
  wire \remainder[51]_i_10_n_0 ;
  wire \remainder[51]_i_11_n_0 ;
  wire \remainder[51]_i_12_n_0 ;
  wire \remainder[51]_i_1_n_0 ;
  wire \remainder[51]_i_5_n_0 ;
  wire \remainder[51]_i_6_n_0 ;
  wire \remainder[51]_i_7_n_0 ;
  wire \remainder[51]_i_8_n_0 ;
  wire \remainder[51]_i_9_n_0 ;
  wire \remainder[52]_i_1_n_0 ;
  wire \remainder[53]_i_1_n_0 ;
  wire \remainder[54]_i_1_n_0 ;
  wire \remainder[55]_i_10_n_0 ;
  wire \remainder[55]_i_11_n_0 ;
  wire \remainder[55]_i_12_n_0 ;
  wire \remainder[55]_i_1_n_0 ;
  wire \remainder[55]_i_5_n_0 ;
  wire \remainder[55]_i_6_n_0 ;
  wire \remainder[55]_i_7_n_0 ;
  wire \remainder[55]_i_8_n_0 ;
  wire \remainder[55]_i_9_n_0 ;
  wire \remainder[56]_i_1_n_0 ;
  wire \remainder[57]_i_1_n_0 ;
  wire \remainder[58]_i_1_n_0 ;
  wire \remainder[59]_i_10_n_0 ;
  wire \remainder[59]_i_11_n_0 ;
  wire \remainder[59]_i_12_n_0 ;
  wire \remainder[59]_i_1_n_0 ;
  wire \remainder[59]_i_5_n_0 ;
  wire \remainder[59]_i_6_n_0 ;
  wire \remainder[59]_i_7_n_0 ;
  wire \remainder[59]_i_8_n_0 ;
  wire \remainder[59]_i_9_n_0 ;
  wire \remainder[5]_i_1_n_0 ;
  wire \remainder[60]_i_1_n_0 ;
  wire \remainder[61]_i_1_n_0 ;
  wire \remainder[62]_i_1_n_0 ;
  wire \remainder[63]_i_10_n_0 ;
  wire \remainder[63]_i_11_n_0 ;
  wire \remainder[63]_i_12_n_0 ;
  wire \remainder[63]_i_13_n_0 ;
  wire \remainder[63]_i_1_n_0 ;
  wire \remainder[63]_i_2_n_0 ;
  wire \remainder[63]_i_3_n_0 ;
  wire \remainder[63]_i_7_n_0 ;
  wire \remainder[63]_i_8_n_0 ;
  wire \remainder[63]_i_9_n_0 ;
  wire \remainder[6]_i_1_n_0 ;
  wire \remainder[7]_i_1_n_0 ;
  wire \remainder[8]_i_1_n_0 ;
  wire \remainder[9]_i_1_n_0 ;
  wire \remainder_reg[35]_i_3_n_0 ;
  wire \remainder_reg[35]_i_3_n_1 ;
  wire \remainder_reg[35]_i_3_n_2 ;
  wire \remainder_reg[35]_i_3_n_3 ;
  wire \remainder_reg[35]_i_4_n_0 ;
  wire \remainder_reg[35]_i_4_n_1 ;
  wire \remainder_reg[35]_i_4_n_2 ;
  wire \remainder_reg[35]_i_4_n_3 ;
  wire \remainder_reg[39]_i_3_n_0 ;
  wire \remainder_reg[39]_i_3_n_1 ;
  wire \remainder_reg[39]_i_3_n_2 ;
  wire \remainder_reg[39]_i_3_n_3 ;
  wire \remainder_reg[39]_i_4_n_0 ;
  wire \remainder_reg[39]_i_4_n_1 ;
  wire \remainder_reg[39]_i_4_n_2 ;
  wire \remainder_reg[39]_i_4_n_3 ;
  wire \remainder_reg[43]_i_3_n_0 ;
  wire \remainder_reg[43]_i_3_n_1 ;
  wire \remainder_reg[43]_i_3_n_2 ;
  wire \remainder_reg[43]_i_3_n_3 ;
  wire \remainder_reg[43]_i_4_n_0 ;
  wire \remainder_reg[43]_i_4_n_1 ;
  wire \remainder_reg[43]_i_4_n_2 ;
  wire \remainder_reg[43]_i_4_n_3 ;
  wire \remainder_reg[47]_i_3_n_0 ;
  wire \remainder_reg[47]_i_3_n_1 ;
  wire \remainder_reg[47]_i_3_n_2 ;
  wire \remainder_reg[47]_i_3_n_3 ;
  wire \remainder_reg[47]_i_4_n_0 ;
  wire \remainder_reg[47]_i_4_n_1 ;
  wire \remainder_reg[47]_i_4_n_2 ;
  wire \remainder_reg[47]_i_4_n_3 ;
  wire \remainder_reg[51]_i_3_n_0 ;
  wire \remainder_reg[51]_i_3_n_1 ;
  wire \remainder_reg[51]_i_3_n_2 ;
  wire \remainder_reg[51]_i_3_n_3 ;
  wire \remainder_reg[51]_i_4_n_0 ;
  wire \remainder_reg[51]_i_4_n_1 ;
  wire \remainder_reg[51]_i_4_n_2 ;
  wire \remainder_reg[51]_i_4_n_3 ;
  wire \remainder_reg[55]_i_3_n_0 ;
  wire \remainder_reg[55]_i_3_n_1 ;
  wire \remainder_reg[55]_i_3_n_2 ;
  wire \remainder_reg[55]_i_3_n_3 ;
  wire \remainder_reg[55]_i_4_n_0 ;
  wire \remainder_reg[55]_i_4_n_1 ;
  wire \remainder_reg[55]_i_4_n_2 ;
  wire \remainder_reg[55]_i_4_n_3 ;
  wire \remainder_reg[59]_i_3_n_0 ;
  wire \remainder_reg[59]_i_3_n_1 ;
  wire \remainder_reg[59]_i_3_n_2 ;
  wire \remainder_reg[59]_i_3_n_3 ;
  wire \remainder_reg[59]_i_4_n_0 ;
  wire \remainder_reg[59]_i_4_n_1 ;
  wire \remainder_reg[59]_i_4_n_2 ;
  wire \remainder_reg[59]_i_4_n_3 ;
  wire \remainder_reg[63]_i_4_n_1 ;
  wire \remainder_reg[63]_i_4_n_2 ;
  wire \remainder_reg[63]_i_4_n_3 ;
  wire \remainder_reg[63]_i_5_n_1 ;
  wire \remainder_reg[63]_i_5_n_2 ;
  wire \remainder_reg[63]_i_5_n_3 ;
  wire \remainder_reg_n_0_[10] ;
  wire \remainder_reg_n_0_[11] ;
  wire \remainder_reg_n_0_[12] ;
  wire \remainder_reg_n_0_[13] ;
  wire \remainder_reg_n_0_[14] ;
  wire \remainder_reg_n_0_[15] ;
  wire \remainder_reg_n_0_[16] ;
  wire \remainder_reg_n_0_[17] ;
  wire \remainder_reg_n_0_[18] ;
  wire \remainder_reg_n_0_[19] ;
  wire \remainder_reg_n_0_[1] ;
  wire \remainder_reg_n_0_[20] ;
  wire \remainder_reg_n_0_[21] ;
  wire \remainder_reg_n_0_[22] ;
  wire \remainder_reg_n_0_[23] ;
  wire \remainder_reg_n_0_[24] ;
  wire \remainder_reg_n_0_[25] ;
  wire \remainder_reg_n_0_[26] ;
  wire \remainder_reg_n_0_[27] ;
  wire \remainder_reg_n_0_[28] ;
  wire \remainder_reg_n_0_[29] ;
  wire \remainder_reg_n_0_[2] ;
  wire \remainder_reg_n_0_[30] ;
  wire \remainder_reg_n_0_[31] ;
  wire \remainder_reg_n_0_[3] ;
  wire \remainder_reg_n_0_[4] ;
  wire \remainder_reg_n_0_[5] ;
  wire \remainder_reg_n_0_[6] ;
  wire \remainder_reg_n_0_[7] ;
  wire \remainder_reg_n_0_[8] ;
  wire \remainder_reg_n_0_[9] ;
  wire rst;
  wire rst_IBUF;
  wire start;
  wire start_IBUF;
  wire [31:0]x;
  wire [31:0]x_IBUF;
  wire [31:31]x_r;
  wire [31:0]y;
  wire [31:0]y_IBUF;
  wire [31:31]y_r;
  wire \y_r_reg_n_0_[0] ;
  wire \y_r_reg_n_0_[10] ;
  wire \y_r_reg_n_0_[11] ;
  wire \y_r_reg_n_0_[12] ;
  wire \y_r_reg_n_0_[13] ;
  wire \y_r_reg_n_0_[14] ;
  wire \y_r_reg_n_0_[15] ;
  wire \y_r_reg_n_0_[16] ;
  wire \y_r_reg_n_0_[17] ;
  wire \y_r_reg_n_0_[18] ;
  wire \y_r_reg_n_0_[19] ;
  wire \y_r_reg_n_0_[1] ;
  wire \y_r_reg_n_0_[20] ;
  wire \y_r_reg_n_0_[21] ;
  wire \y_r_reg_n_0_[22] ;
  wire \y_r_reg_n_0_[23] ;
  wire \y_r_reg_n_0_[24] ;
  wire \y_r_reg_n_0_[25] ;
  wire \y_r_reg_n_0_[26] ;
  wire \y_r_reg_n_0_[27] ;
  wire \y_r_reg_n_0_[28] ;
  wire \y_r_reg_n_0_[29] ;
  wire \y_r_reg_n_0_[2] ;
  wire \y_r_reg_n_0_[30] ;
  wire \y_r_reg_n_0_[3] ;
  wire \y_r_reg_n_0_[4] ;
  wire \y_r_reg_n_0_[5] ;
  wire \y_r_reg_n_0_[6] ;
  wire \y_r_reg_n_0_[7] ;
  wire \y_r_reg_n_0_[8] ;
  wire \y_r_reg_n_0_[9] ;
  wire [31:0]z;
  wire [31:0]z_OBUF;
  wire [3:3]\NLW_r_reg[31]_i_1_CO_UNCONNECTED ;
  wire [3:2]\NLW_r_reg[31]_i_10_CO_UNCONNECTED ;
  wire [3:3]\NLW_r_reg[31]_i_10_O_UNCONNECTED ;
  wire [3:3]\NLW_remainder_reg[63]_i_4_CO_UNCONNECTED ;
  wire [3:3]\NLW_remainder_reg[63]_i_5_CO_UNCONNECTED ;

  OBUF busy_OBUF_inst
       (.I(busy_OBUF),
        .O(busy));
  LUT2 #(
    .INIT(4'hE)) 
    busy_i_1
       (.I0(cnt_end),
        .I1(start_IBUF),
        .O(busy_i_1_n_0));
  LUT6 #(
    .INIT(64'h4000000000000000)) 
    busy_i_2
       (.I0(cnt_reg[5]),
        .I1(cnt_reg[3]),
        .I2(cnt_reg[4]),
        .I3(cnt_reg[2]),
        .I4(cnt_reg[0]),
        .I5(cnt_reg[1]),
        .O(cnt_end));
  FDCE #(
    .INIT(1'b0)) 
    busy_reg
       (.C(clk_IBUF_BUFG),
        .CE(busy_i_1_n_0),
        .CLR(rst_IBUF),
        .D(start_IBUF),
        .Q(busy_OBUF));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  LUT2 #(
    .INIT(4'h1)) 
    \cnt[0]_i_1 
       (.I0(cnt_reg[0]),
        .I1(start_IBUF),
        .O(\cnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \cnt[1]_i_1 
       (.I0(cnt_reg[1]),
        .I1(cnt_reg[0]),
        .I2(start_IBUF),
        .O(\cnt[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h006A)) 
    \cnt[2]_i_1 
       (.I0(cnt_reg[2]),
        .I1(cnt_reg[0]),
        .I2(cnt_reg[1]),
        .I3(start_IBUF),
        .O(\cnt[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00006AAA)) 
    \cnt[3]_i_1 
       (.I0(cnt_reg[3]),
        .I1(cnt_reg[2]),
        .I2(cnt_reg[0]),
        .I3(cnt_reg[1]),
        .I4(start_IBUF),
        .O(\cnt[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000000006AAAAAAA)) 
    \cnt[4]_i_1 
       (.I0(cnt_reg[4]),
        .I1(cnt_reg[3]),
        .I2(cnt_reg[1]),
        .I3(cnt_reg[0]),
        .I4(cnt_reg[2]),
        .I5(start_IBUF),
        .O(\cnt[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h006A)) 
    \cnt[5]_i_1 
       (.I0(cnt_reg[5]),
        .I1(cnt_reg[4]),
        .I2(\cnt[5]_i_2_n_0 ),
        .I3(start_IBUF),
        .O(\cnt[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \cnt[5]_i_2 
       (.I0(cnt_reg[3]),
        .I1(cnt_reg[1]),
        .I2(cnt_reg[0]),
        .I3(cnt_reg[2]),
        .O(\cnt[5]_i_2_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\cnt[0]_i_1_n_0 ),
        .Q(cnt_reg[0]));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\cnt[1]_i_1_n_0 ),
        .Q(cnt_reg[1]));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\cnt[2]_i_1_n_0 ),
        .Q(cnt_reg[2]));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\cnt[3]_i_1_n_0 ),
        .Q(cnt_reg[3]));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\cnt[4]_i_1_n_0 ),
        .Q(cnt_reg[4]));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\cnt[5]_i_1_n_0 ),
        .Q(cnt_reg[5]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h001D)) 
    \quotient[0]_i_1 
       (.I0(p_1_in[31]),
        .I1(p_0_in[31]),
        .I2(p_2_in[31]),
        .I3(start_IBUF),
        .O(\quotient[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[10]_i_1 
       (.I0(z_OBUF[9]),
        .I1(start_IBUF),
        .O(\quotient[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[11]_i_1 
       (.I0(z_OBUF[10]),
        .I1(start_IBUF),
        .O(\quotient[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[12]_i_1 
       (.I0(z_OBUF[11]),
        .I1(start_IBUF),
        .O(\quotient[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[13]_i_1 
       (.I0(z_OBUF[12]),
        .I1(start_IBUF),
        .O(\quotient[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[14]_i_1 
       (.I0(z_OBUF[13]),
        .I1(start_IBUF),
        .O(\quotient[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[15]_i_1 
       (.I0(z_OBUF[14]),
        .I1(start_IBUF),
        .O(\quotient[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[16]_i_1 
       (.I0(z_OBUF[15]),
        .I1(start_IBUF),
        .O(\quotient[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[17]_i_1 
       (.I0(z_OBUF[16]),
        .I1(start_IBUF),
        .O(\quotient[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[18]_i_1 
       (.I0(z_OBUF[17]),
        .I1(start_IBUF),
        .O(\quotient[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[19]_i_1 
       (.I0(z_OBUF[18]),
        .I1(start_IBUF),
        .O(\quotient[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[1]_i_1 
       (.I0(z_OBUF[0]),
        .I1(start_IBUF),
        .O(\quotient[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[20]_i_1 
       (.I0(z_OBUF[19]),
        .I1(start_IBUF),
        .O(\quotient[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[21]_i_1 
       (.I0(z_OBUF[20]),
        .I1(start_IBUF),
        .O(\quotient[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[22]_i_1 
       (.I0(z_OBUF[21]),
        .I1(start_IBUF),
        .O(\quotient[22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[23]_i_1 
       (.I0(z_OBUF[22]),
        .I1(start_IBUF),
        .O(\quotient[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[24]_i_1 
       (.I0(z_OBUF[23]),
        .I1(start_IBUF),
        .O(\quotient[24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[25]_i_1 
       (.I0(z_OBUF[24]),
        .I1(start_IBUF),
        .O(\quotient[25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[26]_i_1 
       (.I0(z_OBUF[25]),
        .I1(start_IBUF),
        .O(\quotient[26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[27]_i_1 
       (.I0(z_OBUF[26]),
        .I1(start_IBUF),
        .O(\quotient[27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[28]_i_1 
       (.I0(z_OBUF[27]),
        .I1(start_IBUF),
        .O(\quotient[28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[29]_i_1 
       (.I0(z_OBUF[28]),
        .I1(start_IBUF),
        .O(\quotient[29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[2]_i_1 
       (.I0(z_OBUF[1]),
        .I1(start_IBUF),
        .O(\quotient[2]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \quotient[30]_i_1 
       (.I0(busy_OBUF),
        .I1(start_IBUF),
        .O(quotient));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[30]_i_2 
       (.I0(z_OBUF[29]),
        .I1(start_IBUF),
        .O(\quotient[30]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[3]_i_1 
       (.I0(z_OBUF[2]),
        .I1(start_IBUF),
        .O(\quotient[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[4]_i_1 
       (.I0(z_OBUF[3]),
        .I1(start_IBUF),
        .O(\quotient[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[5]_i_1 
       (.I0(z_OBUF[4]),
        .I1(start_IBUF),
        .O(\quotient[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[6]_i_1 
       (.I0(z_OBUF[5]),
        .I1(start_IBUF),
        .O(\quotient[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[7]_i_1 
       (.I0(z_OBUF[6]),
        .I1(start_IBUF),
        .O(\quotient[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[8]_i_1 
       (.I0(z_OBUF[7]),
        .I1(start_IBUF),
        .O(\quotient[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \quotient[9]_i_1 
       (.I0(z_OBUF[8]),
        .I1(start_IBUF),
        .O(\quotient[9]_i_1_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[0]_i_1_n_0 ),
        .Q(z_OBUF[0]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[10]_i_1_n_0 ),
        .Q(z_OBUF[10]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[11]_i_1_n_0 ),
        .Q(z_OBUF[11]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[12]_i_1_n_0 ),
        .Q(z_OBUF[12]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[13]_i_1_n_0 ),
        .Q(z_OBUF[13]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[14]_i_1_n_0 ),
        .Q(z_OBUF[14]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[15]_i_1_n_0 ),
        .Q(z_OBUF[15]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[16]_i_1_n_0 ),
        .Q(z_OBUF[16]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[17] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[17]_i_1_n_0 ),
        .Q(z_OBUF[17]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[18] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[18]_i_1_n_0 ),
        .Q(z_OBUF[18]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[19] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[19]_i_1_n_0 ),
        .Q(z_OBUF[19]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[1]_i_1_n_0 ),
        .Q(z_OBUF[1]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[20] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[20]_i_1_n_0 ),
        .Q(z_OBUF[20]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[21] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[21]_i_1_n_0 ),
        .Q(z_OBUF[21]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[22] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[22]_i_1_n_0 ),
        .Q(z_OBUF[22]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[23] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[23]_i_1_n_0 ),
        .Q(z_OBUF[23]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[24] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[24]_i_1_n_0 ),
        .Q(z_OBUF[24]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[25] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[25]_i_1_n_0 ),
        .Q(z_OBUF[25]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[26] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[26]_i_1_n_0 ),
        .Q(z_OBUF[26]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[27] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[27]_i_1_n_0 ),
        .Q(z_OBUF[27]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[28] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[28]_i_1_n_0 ),
        .Q(z_OBUF[28]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[29] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[29]_i_1_n_0 ),
        .Q(z_OBUF[29]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[2]_i_1_n_0 ),
        .Q(z_OBUF[2]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[30] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[30]_i_2_n_0 ),
        .Q(z_OBUF[30]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[3]_i_1_n_0 ),
        .Q(z_OBUF[3]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[4]_i_1_n_0 ),
        .Q(z_OBUF[4]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[5]_i_1_n_0 ),
        .Q(z_OBUF[5]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[6]_i_1_n_0 ),
        .Q(z_OBUF[6]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[7]_i_1_n_0 ),
        .Q(z_OBUF[7]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[8]_i_1_n_0 ),
        .Q(z_OBUF[8]));
  FDCE #(
    .INIT(1'b0)) 
    \quotient_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(quotient),
        .CLR(rst_IBUF),
        .D(\quotient[9]_i_1_n_0 ),
        .Q(z_OBUF[9]));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[11]_i_11 
       (.I0(p_1_in[11]),
        .I1(p_2_in[11]),
        .I2(\y_r_reg_n_0_[11] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[11]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[11]_i_12 
       (.I0(p_1_in[10]),
        .I1(p_2_in[10]),
        .I2(\y_r_reg_n_0_[10] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[11]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[11]_i_13 
       (.I0(p_1_in[9]),
        .I1(p_2_in[9]),
        .I2(\y_r_reg_n_0_[9] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[11]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[11]_i_14 
       (.I0(p_1_in[8]),
        .I1(p_2_in[8]),
        .I2(\y_r_reg_n_0_[8] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[11]_i_14_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[11]_i_2 
       (.I0(\y_r_reg_n_0_[11] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[11]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[11]_i_3 
       (.I0(\y_r_reg_n_0_[10] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[11]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[11]_i_4 
       (.I0(\y_r_reg_n_0_[9] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[11]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[11]_i_5 
       (.I0(\y_r_reg_n_0_[8] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[11]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[11]_i_6 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[11] ),
        .I2(mux_out2[43]),
        .I3(x_r),
        .I4(r_d1[11]),
        .O(\r[11]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[11]_i_7 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[10] ),
        .I2(mux_out2[42]),
        .I3(x_r),
        .I4(r_d1[10]),
        .O(\r[11]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[11]_i_8 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[9] ),
        .I2(mux_out2[41]),
        .I3(x_r),
        .I4(r_d1[9]),
        .O(\r[11]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[11]_i_9 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[8] ),
        .I2(mux_out2[40]),
        .I3(x_r),
        .I4(r_d1[8]),
        .O(\r[11]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[15]_i_11 
       (.I0(p_1_in[15]),
        .I1(p_2_in[15]),
        .I2(\y_r_reg_n_0_[15] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[15]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[15]_i_12 
       (.I0(p_1_in[14]),
        .I1(p_2_in[14]),
        .I2(\y_r_reg_n_0_[14] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[15]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[15]_i_13 
       (.I0(p_1_in[13]),
        .I1(p_2_in[13]),
        .I2(\y_r_reg_n_0_[13] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[15]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[15]_i_14 
       (.I0(p_1_in[12]),
        .I1(p_2_in[12]),
        .I2(\y_r_reg_n_0_[12] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[15]_i_14_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[15]_i_2 
       (.I0(\y_r_reg_n_0_[15] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[15]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[15]_i_3 
       (.I0(\y_r_reg_n_0_[14] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[15]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[15]_i_4 
       (.I0(\y_r_reg_n_0_[13] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[15]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[15]_i_5 
       (.I0(\y_r_reg_n_0_[12] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[15]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[15]_i_6 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[15] ),
        .I2(mux_out2[47]),
        .I3(x_r),
        .I4(r_d1[15]),
        .O(\r[15]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[15]_i_7 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[14] ),
        .I2(mux_out2[46]),
        .I3(x_r),
        .I4(r_d1[14]),
        .O(\r[15]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[15]_i_8 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[13] ),
        .I2(mux_out2[45]),
        .I3(x_r),
        .I4(r_d1[13]),
        .O(\r[15]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[15]_i_9 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[12] ),
        .I2(mux_out2[44]),
        .I3(x_r),
        .I4(r_d1[12]),
        .O(\r[15]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[19]_i_11 
       (.I0(p_1_in[19]),
        .I1(p_2_in[19]),
        .I2(\y_r_reg_n_0_[19] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[19]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[19]_i_12 
       (.I0(p_1_in[18]),
        .I1(p_2_in[18]),
        .I2(\y_r_reg_n_0_[18] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[19]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[19]_i_13 
       (.I0(p_1_in[17]),
        .I1(p_2_in[17]),
        .I2(\y_r_reg_n_0_[17] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[19]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[19]_i_14 
       (.I0(p_1_in[16]),
        .I1(p_2_in[16]),
        .I2(\y_r_reg_n_0_[16] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[19]_i_14_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[19]_i_2 
       (.I0(\y_r_reg_n_0_[19] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[19]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[19]_i_3 
       (.I0(\y_r_reg_n_0_[18] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[19]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[19]_i_4 
       (.I0(\y_r_reg_n_0_[17] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[19]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[19]_i_5 
       (.I0(\y_r_reg_n_0_[16] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[19]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[19]_i_6 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[19] ),
        .I2(mux_out2[51]),
        .I3(x_r),
        .I4(r_d1[19]),
        .O(\r[19]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[19]_i_7 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[18] ),
        .I2(mux_out2[50]),
        .I3(x_r),
        .I4(r_d1[18]),
        .O(\r[19]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[19]_i_8 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[17] ),
        .I2(mux_out2[49]),
        .I3(x_r),
        .I4(r_d1[17]),
        .O(\r[19]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[19]_i_9 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[16] ),
        .I2(mux_out2[48]),
        .I3(x_r),
        .I4(r_d1[16]),
        .O(\r[19]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[23]_i_11 
       (.I0(p_1_in[23]),
        .I1(p_2_in[23]),
        .I2(\y_r_reg_n_0_[23] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[23]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[23]_i_12 
       (.I0(p_1_in[22]),
        .I1(p_2_in[22]),
        .I2(\y_r_reg_n_0_[22] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[23]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[23]_i_13 
       (.I0(p_1_in[21]),
        .I1(p_2_in[21]),
        .I2(\y_r_reg_n_0_[21] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[23]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[23]_i_14 
       (.I0(p_1_in[20]),
        .I1(p_2_in[20]),
        .I2(\y_r_reg_n_0_[20] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[23]_i_14_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[23]_i_2 
       (.I0(\y_r_reg_n_0_[23] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[23]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[23]_i_3 
       (.I0(\y_r_reg_n_0_[22] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[23]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[23]_i_4 
       (.I0(\y_r_reg_n_0_[21] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[23]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[23]_i_5 
       (.I0(\y_r_reg_n_0_[20] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[23]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[23]_i_6 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[23] ),
        .I2(mux_out2[55]),
        .I3(x_r),
        .I4(r_d1[23]),
        .O(\r[23]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[23]_i_7 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[22] ),
        .I2(mux_out2[54]),
        .I3(x_r),
        .I4(r_d1[22]),
        .O(\r[23]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[23]_i_8 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[21] ),
        .I2(mux_out2[53]),
        .I3(x_r),
        .I4(r_d1[21]),
        .O(\r[23]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[23]_i_9 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[20] ),
        .I2(mux_out2[52]),
        .I3(x_r),
        .I4(r_d1[20]),
        .O(\r[23]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[27]_i_11 
       (.I0(p_1_in[27]),
        .I1(p_2_in[27]),
        .I2(\y_r_reg_n_0_[27] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[27]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[27]_i_12 
       (.I0(p_1_in[26]),
        .I1(p_2_in[26]),
        .I2(\y_r_reg_n_0_[26] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[27]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[27]_i_13 
       (.I0(p_1_in[25]),
        .I1(p_2_in[25]),
        .I2(\y_r_reg_n_0_[25] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[27]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[27]_i_14 
       (.I0(p_1_in[24]),
        .I1(p_2_in[24]),
        .I2(\y_r_reg_n_0_[24] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[27]_i_14_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[27]_i_2 
       (.I0(\y_r_reg_n_0_[27] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[27]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[27]_i_3 
       (.I0(\y_r_reg_n_0_[26] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[27]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[27]_i_4 
       (.I0(\y_r_reg_n_0_[25] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[27]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[27]_i_5 
       (.I0(\y_r_reg_n_0_[24] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[27]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[27]_i_6 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[27] ),
        .I2(mux_out2[59]),
        .I3(x_r),
        .I4(r_d1[27]),
        .O(\r[27]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[27]_i_7 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[26] ),
        .I2(mux_out2[58]),
        .I3(x_r),
        .I4(r_d1[26]),
        .O(\r[27]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[27]_i_8 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[25] ),
        .I2(mux_out2[57]),
        .I3(x_r),
        .I4(r_d1[25]),
        .O(\r[27]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[27]_i_9 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[24] ),
        .I2(mux_out2[56]),
        .I3(x_r),
        .I4(r_d1[24]),
        .O(\r[27]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[31]_i_11 
       (.I0(p_1_in[30]),
        .I1(p_2_in[30]),
        .I2(\y_r_reg_n_0_[30] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[31]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[31]_i_12 
       (.I0(p_1_in[29]),
        .I1(p_2_in[29]),
        .I2(\y_r_reg_n_0_[29] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[31]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[31]_i_13 
       (.I0(p_1_in[28]),
        .I1(p_2_in[28]),
        .I2(\y_r_reg_n_0_[28] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[31]_i_13_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[31]_i_2 
       (.I0(\y_r_reg_n_0_[30] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[31]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[31]_i_3 
       (.I0(\y_r_reg_n_0_[29] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[31]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[31]_i_4 
       (.I0(\y_r_reg_n_0_[28] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[31]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFEAE)) 
    \r[31]_i_5 
       (.I0(x_r),
        .I1(p_1_in[31]),
        .I2(p_0_in[31]),
        .I3(p_2_in[31]),
        .O(\r[31]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[31]_i_6 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[30] ),
        .I2(mux_out2[62]),
        .I3(x_r),
        .I4(r_d1[30]),
        .O(\r[31]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[31]_i_7 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[29] ),
        .I2(mux_out2[61]),
        .I3(x_r),
        .I4(r_d1[29]),
        .O(\r[31]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[31]_i_8 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[28] ),
        .I2(mux_out2[60]),
        .I3(x_r),
        .I4(r_d1[28]),
        .O(\r[31]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \r[31]_i_9 
       (.I0(p_2_in[30]),
        .I1(p_0_in[31]),
        .I2(p_1_in[30]),
        .O(mux_out2[62]));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[3]_i_11 
       (.I0(p_1_in[3]),
        .I1(p_2_in[3]),
        .I2(\y_r_reg_n_0_[3] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[3]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[3]_i_12 
       (.I0(p_1_in[2]),
        .I1(p_2_in[2]),
        .I2(\y_r_reg_n_0_[2] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[3]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[3]_i_13 
       (.I0(p_1_in[1]),
        .I1(p_2_in[1]),
        .I2(\y_r_reg_n_0_[1] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[3]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[3]_i_14 
       (.I0(p_1_in[0]),
        .I1(p_2_in[0]),
        .I2(\y_r_reg_n_0_[0] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[3]_i_14_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[3]_i_2 
       (.I0(\y_r_reg_n_0_[3] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[3]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[3]_i_3 
       (.I0(\y_r_reg_n_0_[2] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[3]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[3]_i_4 
       (.I0(\y_r_reg_n_0_[1] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[3]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[3]_i_5 
       (.I0(\y_r_reg_n_0_[0] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[3]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[3]_i_6 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[3] ),
        .I2(mux_out2[35]),
        .I3(x_r),
        .I4(r_d1[3]),
        .O(\r[3]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[3]_i_7 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[2] ),
        .I2(mux_out2[34]),
        .I3(x_r),
        .I4(r_d1[2]),
        .O(\r[3]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[3]_i_8 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[1] ),
        .I2(mux_out2[33]),
        .I3(x_r),
        .I4(r_d1[1]),
        .O(\r[3]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[3]_i_9 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[0] ),
        .I2(mux_out2[32]),
        .I3(x_r),
        .I4(r_d1[0]),
        .O(\r[3]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[7]_i_11 
       (.I0(p_1_in[7]),
        .I1(p_2_in[7]),
        .I2(\y_r_reg_n_0_[7] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[7]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[7]_i_12 
       (.I0(p_1_in[6]),
        .I1(p_2_in[6]),
        .I2(\y_r_reg_n_0_[6] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[7]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[7]_i_13 
       (.I0(p_1_in[5]),
        .I1(p_2_in[5]),
        .I2(\y_r_reg_n_0_[5] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[7]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC5A5A3CCCAAAA)) 
    \r[7]_i_14 
       (.I0(p_1_in[4]),
        .I1(p_2_in[4]),
        .I2(\y_r_reg_n_0_[4] ),
        .I3(p_2_in[31]),
        .I4(p_0_in[31]),
        .I5(p_1_in[31]),
        .O(\r[7]_i_14_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[7]_i_2 
       (.I0(\y_r_reg_n_0_[7] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[7]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[7]_i_3 
       (.I0(\y_r_reg_n_0_[6] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[7]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[7]_i_4 
       (.I0(\y_r_reg_n_0_[5] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[7]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \r[7]_i_5 
       (.I0(\y_r_reg_n_0_[4] ),
        .I1(p_2_in[31]),
        .I2(p_0_in[31]),
        .I3(p_1_in[31]),
        .I4(x_r),
        .O(\r[7]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[7]_i_6 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[7] ),
        .I2(mux_out2[39]),
        .I3(x_r),
        .I4(r_d1[7]),
        .O(\r[7]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[7]_i_7 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[6] ),
        .I2(mux_out2[38]),
        .I3(x_r),
        .I4(r_d1[6]),
        .O(\r[7]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[7]_i_8 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[5] ),
        .I2(mux_out2[37]),
        .I3(x_r),
        .I4(r_d1[5]),
        .O(\r[7]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'hFF780078)) 
    \r[7]_i_9 
       (.I0(mux_out2[63]),
        .I1(\y_r_reg_n_0_[4] ),
        .I2(mux_out2[36]),
        .I3(x_r),
        .I4(r_d1[4]),
        .O(\r[7]_i_9_n_0 ));
  OBUF \r_OBUF[0]_inst 
       (.I(r_OBUF[0]),
        .O(r[0]));
  OBUF \r_OBUF[10]_inst 
       (.I(r_OBUF[10]),
        .O(r[10]));
  OBUF \r_OBUF[11]_inst 
       (.I(r_OBUF[11]),
        .O(r[11]));
  OBUF \r_OBUF[12]_inst 
       (.I(r_OBUF[12]),
        .O(r[12]));
  OBUF \r_OBUF[13]_inst 
       (.I(r_OBUF[13]),
        .O(r[13]));
  OBUF \r_OBUF[14]_inst 
       (.I(r_OBUF[14]),
        .O(r[14]));
  OBUF \r_OBUF[15]_inst 
       (.I(r_OBUF[15]),
        .O(r[15]));
  OBUF \r_OBUF[16]_inst 
       (.I(r_OBUF[16]),
        .O(r[16]));
  OBUF \r_OBUF[17]_inst 
       (.I(r_OBUF[17]),
        .O(r[17]));
  OBUF \r_OBUF[18]_inst 
       (.I(r_OBUF[18]),
        .O(r[18]));
  OBUF \r_OBUF[19]_inst 
       (.I(r_OBUF[19]),
        .O(r[19]));
  OBUF \r_OBUF[1]_inst 
       (.I(r_OBUF[1]),
        .O(r[1]));
  OBUF \r_OBUF[20]_inst 
       (.I(r_OBUF[20]),
        .O(r[20]));
  OBUF \r_OBUF[21]_inst 
       (.I(r_OBUF[21]),
        .O(r[21]));
  OBUF \r_OBUF[22]_inst 
       (.I(r_OBUF[22]),
        .O(r[22]));
  OBUF \r_OBUF[23]_inst 
       (.I(r_OBUF[23]),
        .O(r[23]));
  OBUF \r_OBUF[24]_inst 
       (.I(r_OBUF[24]),
        .O(r[24]));
  OBUF \r_OBUF[25]_inst 
       (.I(r_OBUF[25]),
        .O(r[25]));
  OBUF \r_OBUF[26]_inst 
       (.I(r_OBUF[26]),
        .O(r[26]));
  OBUF \r_OBUF[27]_inst 
       (.I(r_OBUF[27]),
        .O(r[27]));
  OBUF \r_OBUF[28]_inst 
       (.I(r_OBUF[28]),
        .O(r[28]));
  OBUF \r_OBUF[29]_inst 
       (.I(r_OBUF[29]),
        .O(r[29]));
  OBUF \r_OBUF[2]_inst 
       (.I(r_OBUF[2]),
        .O(r[2]));
  OBUF \r_OBUF[30]_inst 
       (.I(r_OBUF[30]),
        .O(r[30]));
  OBUF \r_OBUF[31]_inst 
       (.I(r_OBUF[31]),
        .O(r[31]));
  OBUF \r_OBUF[3]_inst 
       (.I(r_OBUF[3]),
        .O(r[3]));
  OBUF \r_OBUF[4]_inst 
       (.I(r_OBUF[4]),
        .O(r[4]));
  OBUF \r_OBUF[5]_inst 
       (.I(r_OBUF[5]),
        .O(r[5]));
  OBUF \r_OBUF[6]_inst 
       (.I(r_OBUF[6]),
        .O(r[6]));
  OBUF \r_OBUF[7]_inst 
       (.I(r_OBUF[7]),
        .O(r[7]));
  OBUF \r_OBUF[8]_inst 
       (.I(r_OBUF[8]),
        .O(r[8]));
  OBUF \r_OBUF[9]_inst 
       (.I(r_OBUF[9]),
        .O(r[9]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[3]_i_1_n_7 ),
        .Q(r_OBUF[0]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[11]_i_1_n_5 ),
        .Q(r_OBUF[10]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[11]_i_1_n_4 ),
        .Q(r_OBUF[11]));
  CARRY4 \r_reg[11]_i_1 
       (.CI(\r_reg[7]_i_1_n_0 ),
        .CO({\r_reg[11]_i_1_n_0 ,\r_reg[11]_i_1_n_1 ,\r_reg[11]_i_1_n_2 ,\r_reg[11]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\r[11]_i_2_n_0 ,\r[11]_i_3_n_0 ,\r[11]_i_4_n_0 ,\r[11]_i_5_n_0 }),
        .O({\r_reg[11]_i_1_n_4 ,\r_reg[11]_i_1_n_5 ,\r_reg[11]_i_1_n_6 ,\r_reg[11]_i_1_n_7 }),
        .S({\r[11]_i_6_n_0 ,\r[11]_i_7_n_0 ,\r[11]_i_8_n_0 ,\r[11]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \r_reg[11]_i_10 
       (.CI(\r_reg[7]_i_10_n_0 ),
        .CO({\r_reg[11]_i_10_n_0 ,\r_reg[11]_i_10_n_1 ,\r_reg[11]_i_10_n_2 ,\r_reg[11]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI(mux_out2[43:40]),
        .O(r_d1[11:8]),
        .S({\r[11]_i_11_n_0 ,\r[11]_i_12_n_0 ,\r[11]_i_13_n_0 ,\r[11]_i_14_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[15]_i_1_n_7 ),
        .Q(r_OBUF[12]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[15]_i_1_n_6 ),
        .Q(r_OBUF[13]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[15]_i_1_n_5 ),
        .Q(r_OBUF[14]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[15]_i_1_n_4 ),
        .Q(r_OBUF[15]));
  CARRY4 \r_reg[15]_i_1 
       (.CI(\r_reg[11]_i_1_n_0 ),
        .CO({\r_reg[15]_i_1_n_0 ,\r_reg[15]_i_1_n_1 ,\r_reg[15]_i_1_n_2 ,\r_reg[15]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\r[15]_i_2_n_0 ,\r[15]_i_3_n_0 ,\r[15]_i_4_n_0 ,\r[15]_i_5_n_0 }),
        .O({\r_reg[15]_i_1_n_4 ,\r_reg[15]_i_1_n_5 ,\r_reg[15]_i_1_n_6 ,\r_reg[15]_i_1_n_7 }),
        .S({\r[15]_i_6_n_0 ,\r[15]_i_7_n_0 ,\r[15]_i_8_n_0 ,\r[15]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \r_reg[15]_i_10 
       (.CI(\r_reg[11]_i_10_n_0 ),
        .CO({\r_reg[15]_i_10_n_0 ,\r_reg[15]_i_10_n_1 ,\r_reg[15]_i_10_n_2 ,\r_reg[15]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI(mux_out2[47:44]),
        .O(r_d1[15:12]),
        .S({\r[15]_i_11_n_0 ,\r[15]_i_12_n_0 ,\r[15]_i_13_n_0 ,\r[15]_i_14_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[19]_i_1_n_7 ),
        .Q(r_OBUF[16]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[17] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[19]_i_1_n_6 ),
        .Q(r_OBUF[17]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[18] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[19]_i_1_n_5 ),
        .Q(r_OBUF[18]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[19] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[19]_i_1_n_4 ),
        .Q(r_OBUF[19]));
  CARRY4 \r_reg[19]_i_1 
       (.CI(\r_reg[15]_i_1_n_0 ),
        .CO({\r_reg[19]_i_1_n_0 ,\r_reg[19]_i_1_n_1 ,\r_reg[19]_i_1_n_2 ,\r_reg[19]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\r[19]_i_2_n_0 ,\r[19]_i_3_n_0 ,\r[19]_i_4_n_0 ,\r[19]_i_5_n_0 }),
        .O({\r_reg[19]_i_1_n_4 ,\r_reg[19]_i_1_n_5 ,\r_reg[19]_i_1_n_6 ,\r_reg[19]_i_1_n_7 }),
        .S({\r[19]_i_6_n_0 ,\r[19]_i_7_n_0 ,\r[19]_i_8_n_0 ,\r[19]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \r_reg[19]_i_10 
       (.CI(\r_reg[15]_i_10_n_0 ),
        .CO({\r_reg[19]_i_10_n_0 ,\r_reg[19]_i_10_n_1 ,\r_reg[19]_i_10_n_2 ,\r_reg[19]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI(mux_out2[51:48]),
        .O(r_d1[19:16]),
        .S({\r[19]_i_11_n_0 ,\r[19]_i_12_n_0 ,\r[19]_i_13_n_0 ,\r[19]_i_14_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[3]_i_1_n_6 ),
        .Q(r_OBUF[1]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[20] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[23]_i_1_n_7 ),
        .Q(r_OBUF[20]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[21] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[23]_i_1_n_6 ),
        .Q(r_OBUF[21]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[22] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[23]_i_1_n_5 ),
        .Q(r_OBUF[22]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[23] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[23]_i_1_n_4 ),
        .Q(r_OBUF[23]));
  CARRY4 \r_reg[23]_i_1 
       (.CI(\r_reg[19]_i_1_n_0 ),
        .CO({\r_reg[23]_i_1_n_0 ,\r_reg[23]_i_1_n_1 ,\r_reg[23]_i_1_n_2 ,\r_reg[23]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\r[23]_i_2_n_0 ,\r[23]_i_3_n_0 ,\r[23]_i_4_n_0 ,\r[23]_i_5_n_0 }),
        .O({\r_reg[23]_i_1_n_4 ,\r_reg[23]_i_1_n_5 ,\r_reg[23]_i_1_n_6 ,\r_reg[23]_i_1_n_7 }),
        .S({\r[23]_i_6_n_0 ,\r[23]_i_7_n_0 ,\r[23]_i_8_n_0 ,\r[23]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \r_reg[23]_i_10 
       (.CI(\r_reg[19]_i_10_n_0 ),
        .CO({\r_reg[23]_i_10_n_0 ,\r_reg[23]_i_10_n_1 ,\r_reg[23]_i_10_n_2 ,\r_reg[23]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI(mux_out2[55:52]),
        .O(r_d1[23:20]),
        .S({\r[23]_i_11_n_0 ,\r[23]_i_12_n_0 ,\r[23]_i_13_n_0 ,\r[23]_i_14_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[24] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[27]_i_1_n_7 ),
        .Q(r_OBUF[24]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[25] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[27]_i_1_n_6 ),
        .Q(r_OBUF[25]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[26] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[27]_i_1_n_5 ),
        .Q(r_OBUF[26]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[27] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[27]_i_1_n_4 ),
        .Q(r_OBUF[27]));
  CARRY4 \r_reg[27]_i_1 
       (.CI(\r_reg[23]_i_1_n_0 ),
        .CO({\r_reg[27]_i_1_n_0 ,\r_reg[27]_i_1_n_1 ,\r_reg[27]_i_1_n_2 ,\r_reg[27]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\r[27]_i_2_n_0 ,\r[27]_i_3_n_0 ,\r[27]_i_4_n_0 ,\r[27]_i_5_n_0 }),
        .O({\r_reg[27]_i_1_n_4 ,\r_reg[27]_i_1_n_5 ,\r_reg[27]_i_1_n_6 ,\r_reg[27]_i_1_n_7 }),
        .S({\r[27]_i_6_n_0 ,\r[27]_i_7_n_0 ,\r[27]_i_8_n_0 ,\r[27]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \r_reg[27]_i_10 
       (.CI(\r_reg[23]_i_10_n_0 ),
        .CO({\r_reg[27]_i_10_n_0 ,\r_reg[27]_i_10_n_1 ,\r_reg[27]_i_10_n_2 ,\r_reg[27]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI(mux_out2[59:56]),
        .O(r_d1[27:24]),
        .S({\r[27]_i_11_n_0 ,\r[27]_i_12_n_0 ,\r[27]_i_13_n_0 ,\r[27]_i_14_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[28] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[31]_i_1_n_7 ),
        .Q(r_OBUF[28]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[29] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[31]_i_1_n_6 ),
        .Q(r_OBUF[29]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[3]_i_1_n_5 ),
        .Q(r_OBUF[2]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[30] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[31]_i_1_n_5 ),
        .Q(r_OBUF[30]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[31] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[31]_i_1_n_4 ),
        .Q(r_OBUF[31]));
  CARRY4 \r_reg[31]_i_1 
       (.CI(\r_reg[27]_i_1_n_0 ),
        .CO({\NLW_r_reg[31]_i_1_CO_UNCONNECTED [3],\r_reg[31]_i_1_n_1 ,\r_reg[31]_i_1_n_2 ,\r_reg[31]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,\r[31]_i_2_n_0 ,\r[31]_i_3_n_0 ,\r[31]_i_4_n_0 }),
        .O({\r_reg[31]_i_1_n_4 ,\r_reg[31]_i_1_n_5 ,\r_reg[31]_i_1_n_6 ,\r_reg[31]_i_1_n_7 }),
        .S({\r[31]_i_5_n_0 ,\r[31]_i_6_n_0 ,\r[31]_i_7_n_0 ,\r[31]_i_8_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \r_reg[31]_i_10 
       (.CI(\r_reg[27]_i_10_n_0 ),
        .CO({\NLW_r_reg[31]_i_10_CO_UNCONNECTED [3:2],\r_reg[31]_i_10_n_2 ,\r_reg[31]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,mux_out2[61:60]}),
        .O({\NLW_r_reg[31]_i_10_O_UNCONNECTED [3],r_d1[30:28]}),
        .S({1'b0,\r[31]_i_11_n_0 ,\r[31]_i_12_n_0 ,\r[31]_i_13_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[3]_i_1_n_4 ),
        .Q(r_OBUF[3]));
  CARRY4 \r_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\r_reg[3]_i_1_n_0 ,\r_reg[3]_i_1_n_1 ,\r_reg[3]_i_1_n_2 ,\r_reg[3]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\r[3]_i_2_n_0 ,\r[3]_i_3_n_0 ,\r[3]_i_4_n_0 ,\r[3]_i_5_n_0 }),
        .O({\r_reg[3]_i_1_n_4 ,\r_reg[3]_i_1_n_5 ,\r_reg[3]_i_1_n_6 ,\r_reg[3]_i_1_n_7 }),
        .S({\r[3]_i_6_n_0 ,\r[3]_i_7_n_0 ,\r[3]_i_8_n_0 ,\r[3]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \r_reg[3]_i_10 
       (.CI(1'b0),
        .CO({\r_reg[3]_i_10_n_0 ,\r_reg[3]_i_10_n_1 ,\r_reg[3]_i_10_n_2 ,\r_reg[3]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI(mux_out2[35:32]),
        .O(r_d1[3:0]),
        .S({\r[3]_i_11_n_0 ,\r[3]_i_12_n_0 ,\r[3]_i_13_n_0 ,\r[3]_i_14_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[7]_i_1_n_7 ),
        .Q(r_OBUF[4]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[7]_i_1_n_6 ),
        .Q(r_OBUF[5]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[7]_i_1_n_5 ),
        .Q(r_OBUF[6]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[7]_i_1_n_4 ),
        .Q(r_OBUF[7]));
  CARRY4 \r_reg[7]_i_1 
       (.CI(\r_reg[3]_i_1_n_0 ),
        .CO({\r_reg[7]_i_1_n_0 ,\r_reg[7]_i_1_n_1 ,\r_reg[7]_i_1_n_2 ,\r_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\r[7]_i_2_n_0 ,\r[7]_i_3_n_0 ,\r[7]_i_4_n_0 ,\r[7]_i_5_n_0 }),
        .O({\r_reg[7]_i_1_n_4 ,\r_reg[7]_i_1_n_5 ,\r_reg[7]_i_1_n_6 ,\r_reg[7]_i_1_n_7 }),
        .S({\r[7]_i_6_n_0 ,\r[7]_i_7_n_0 ,\r[7]_i_8_n_0 ,\r[7]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \r_reg[7]_i_10 
       (.CI(\r_reg[3]_i_10_n_0 ),
        .CO({\r_reg[7]_i_10_n_0 ,\r_reg[7]_i_10_n_1 ,\r_reg[7]_i_10_n_2 ,\r_reg[7]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI(mux_out2[39:36]),
        .O(r_d1[7:4]),
        .S({\r[7]_i_11_n_0 ,\r[7]_i_12_n_0 ,\r[7]_i_13_n_0 ,\r[7]_i_14_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[11]_i_1_n_7 ),
        .Q(r_OBUF[8]));
  FDCE #(
    .INIT(1'b0)) 
    \r_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(busy_OBUF),
        .CLR(rst_IBUF),
        .D(\r_reg[11]_i_1_n_6 ),
        .Q(r_OBUF[9]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[10]_i_1 
       (.I0(x_IBUF[9]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[10] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[9] ),
        .O(\remainder[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[11]_i_1 
       (.I0(x_IBUF[10]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[11] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[10] ),
        .O(\remainder[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[12]_i_1 
       (.I0(x_IBUF[11]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[12] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[11] ),
        .O(\remainder[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[13]_i_1 
       (.I0(x_IBUF[12]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[13] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[12] ),
        .O(\remainder[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[14]_i_1 
       (.I0(x_IBUF[13]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[14] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[13] ),
        .O(\remainder[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[15]_i_1 
       (.I0(x_IBUF[14]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[15] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[14] ),
        .O(\remainder[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[16]_i_1 
       (.I0(x_IBUF[15]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[16] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[15] ),
        .O(\remainder[16]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[17]_i_1 
       (.I0(x_IBUF[16]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[17] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[16] ),
        .O(\remainder[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[18]_i_1 
       (.I0(x_IBUF[17]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[18] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[17] ),
        .O(\remainder[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[19]_i_1 
       (.I0(x_IBUF[18]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[19] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[18] ),
        .O(\remainder[19]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \remainder[1]_i_1 
       (.I0(x_IBUF[0]),
        .I1(start_IBUF),
        .I2(\remainder[63]_i_3_n_0 ),
        .I3(\remainder_reg_n_0_[1] ),
        .O(\remainder[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[20]_i_1 
       (.I0(x_IBUF[19]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[20] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[19] ),
        .O(\remainder[20]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[21]_i_1 
       (.I0(x_IBUF[20]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[21] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[20] ),
        .O(\remainder[21]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[22]_i_1 
       (.I0(x_IBUF[21]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[22] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[21] ),
        .O(\remainder[22]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[23]_i_1 
       (.I0(x_IBUF[22]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[23] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[22] ),
        .O(\remainder[23]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[24]_i_1 
       (.I0(x_IBUF[23]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[24] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[23] ),
        .O(\remainder[24]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[25]_i_1 
       (.I0(x_IBUF[24]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[25] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[24] ),
        .O(\remainder[25]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[26]_i_1 
       (.I0(x_IBUF[25]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[26] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[25] ),
        .O(\remainder[26]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[27]_i_1 
       (.I0(x_IBUF[26]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[27] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[26] ),
        .O(\remainder[27]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[28]_i_1 
       (.I0(x_IBUF[27]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[28] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[27] ),
        .O(\remainder[28]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[29]_i_1 
       (.I0(x_IBUF[28]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[29] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[28] ),
        .O(\remainder[29]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[2]_i_1 
       (.I0(x_IBUF[1]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[2] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[1] ),
        .O(\remainder[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[30]_i_1 
       (.I0(x_IBUF[29]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[30] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[29] ),
        .O(\remainder[30]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[31]_i_1 
       (.I0(x_IBUF[30]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[31] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[30] ),
        .O(\remainder[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[32]_i_1 
       (.I0(\remainder_reg_n_0_[31] ),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[0]),
        .I3(p_0_in[31]),
        .I4(p_2_in[0]),
        .I5(start_IBUF),
        .O(\remainder[32]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[33]_i_1 
       (.I0(mux_out2[32]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[1]),
        .I3(p_0_in[31]),
        .I4(p_2_in[1]),
        .I5(start_IBUF),
        .O(\remainder[33]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[33]_i_2 
       (.I0(p_2_in[0]),
        .I1(p_0_in[31]),
        .I2(p_1_in[0]),
        .O(mux_out2[32]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[34]_i_1 
       (.I0(mux_out2[33]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[2]),
        .I3(p_0_in[31]),
        .I4(p_2_in[2]),
        .I5(start_IBUF),
        .O(\remainder[34]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[34]_i_2 
       (.I0(p_2_in[1]),
        .I1(p_0_in[31]),
        .I2(p_1_in[1]),
        .O(mux_out2[33]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[35]_i_1 
       (.I0(mux_out2[34]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[3]),
        .I3(p_0_in[31]),
        .I4(p_2_in[3]),
        .I5(start_IBUF),
        .O(\remainder[35]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[35]_i_10 
       (.I0(\y_r_reg_n_0_[2] ),
        .I1(p_0_in[2]),
        .O(\remainder[35]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[35]_i_11 
       (.I0(\y_r_reg_n_0_[1] ),
        .I1(p_0_in[1]),
        .O(\remainder[35]_i_11_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[35]_i_12 
       (.I0(\y_r_reg_n_0_[0] ),
        .I1(p_0_in[0]),
        .O(\remainder[35]_i_12_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[35]_i_2 
       (.I0(p_2_in[2]),
        .I1(p_0_in[31]),
        .I2(p_1_in[2]),
        .O(mux_out2[34]));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[35]_i_5 
       (.I0(p_0_in[3]),
        .I1(\y_r_reg_n_0_[3] ),
        .O(\remainder[35]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[35]_i_6 
       (.I0(p_0_in[2]),
        .I1(\y_r_reg_n_0_[2] ),
        .O(\remainder[35]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[35]_i_7 
       (.I0(p_0_in[1]),
        .I1(\y_r_reg_n_0_[1] ),
        .O(\remainder[35]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[35]_i_8 
       (.I0(p_0_in[0]),
        .I1(\y_r_reg_n_0_[0] ),
        .O(\remainder[35]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[35]_i_9 
       (.I0(\y_r_reg_n_0_[3] ),
        .I1(p_0_in[3]),
        .O(\remainder[35]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[36]_i_1 
       (.I0(mux_out2[35]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[4]),
        .I3(p_0_in[31]),
        .I4(p_2_in[4]),
        .I5(start_IBUF),
        .O(\remainder[36]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[36]_i_2 
       (.I0(p_2_in[3]),
        .I1(p_0_in[31]),
        .I2(p_1_in[3]),
        .O(mux_out2[35]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[37]_i_1 
       (.I0(mux_out2[36]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[5]),
        .I3(p_0_in[31]),
        .I4(p_2_in[5]),
        .I5(start_IBUF),
        .O(\remainder[37]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[37]_i_2 
       (.I0(p_2_in[4]),
        .I1(p_0_in[31]),
        .I2(p_1_in[4]),
        .O(mux_out2[36]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[38]_i_1 
       (.I0(mux_out2[37]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[6]),
        .I3(p_0_in[31]),
        .I4(p_2_in[6]),
        .I5(start_IBUF),
        .O(\remainder[38]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[38]_i_2 
       (.I0(p_2_in[5]),
        .I1(p_0_in[31]),
        .I2(p_1_in[5]),
        .O(mux_out2[37]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[39]_i_1 
       (.I0(mux_out2[38]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[7]),
        .I3(p_0_in[31]),
        .I4(p_2_in[7]),
        .I5(start_IBUF),
        .O(\remainder[39]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[39]_i_10 
       (.I0(\y_r_reg_n_0_[6] ),
        .I1(p_0_in[6]),
        .O(\remainder[39]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[39]_i_11 
       (.I0(\y_r_reg_n_0_[5] ),
        .I1(p_0_in[5]),
        .O(\remainder[39]_i_11_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[39]_i_12 
       (.I0(\y_r_reg_n_0_[4] ),
        .I1(p_0_in[4]),
        .O(\remainder[39]_i_12_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[39]_i_2 
       (.I0(p_2_in[6]),
        .I1(p_0_in[31]),
        .I2(p_1_in[6]),
        .O(mux_out2[38]));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[39]_i_5 
       (.I0(p_0_in[7]),
        .I1(\y_r_reg_n_0_[7] ),
        .O(\remainder[39]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[39]_i_6 
       (.I0(p_0_in[6]),
        .I1(\y_r_reg_n_0_[6] ),
        .O(\remainder[39]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[39]_i_7 
       (.I0(p_0_in[5]),
        .I1(\y_r_reg_n_0_[5] ),
        .O(\remainder[39]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[39]_i_8 
       (.I0(p_0_in[4]),
        .I1(\y_r_reg_n_0_[4] ),
        .O(\remainder[39]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[39]_i_9 
       (.I0(\y_r_reg_n_0_[7] ),
        .I1(p_0_in[7]),
        .O(\remainder[39]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[3]_i_1 
       (.I0(x_IBUF[2]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[3] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[2] ),
        .O(\remainder[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[40]_i_1 
       (.I0(mux_out2[39]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[8]),
        .I3(p_0_in[31]),
        .I4(p_2_in[8]),
        .I5(start_IBUF),
        .O(\remainder[40]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[40]_i_2 
       (.I0(p_2_in[7]),
        .I1(p_0_in[31]),
        .I2(p_1_in[7]),
        .O(mux_out2[39]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[41]_i_1 
       (.I0(mux_out2[40]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[9]),
        .I3(p_0_in[31]),
        .I4(p_2_in[9]),
        .I5(start_IBUF),
        .O(\remainder[41]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[41]_i_2 
       (.I0(p_2_in[8]),
        .I1(p_0_in[31]),
        .I2(p_1_in[8]),
        .O(mux_out2[40]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[42]_i_1 
       (.I0(mux_out2[41]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[10]),
        .I3(p_0_in[31]),
        .I4(p_2_in[10]),
        .I5(start_IBUF),
        .O(\remainder[42]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[42]_i_2 
       (.I0(p_2_in[9]),
        .I1(p_0_in[31]),
        .I2(p_1_in[9]),
        .O(mux_out2[41]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[43]_i_1 
       (.I0(mux_out2[42]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[11]),
        .I3(p_0_in[31]),
        .I4(p_2_in[11]),
        .I5(start_IBUF),
        .O(\remainder[43]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[43]_i_10 
       (.I0(\y_r_reg_n_0_[10] ),
        .I1(p_0_in[10]),
        .O(\remainder[43]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[43]_i_11 
       (.I0(\y_r_reg_n_0_[9] ),
        .I1(p_0_in[9]),
        .O(\remainder[43]_i_11_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[43]_i_12 
       (.I0(\y_r_reg_n_0_[8] ),
        .I1(p_0_in[8]),
        .O(\remainder[43]_i_12_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[43]_i_2 
       (.I0(p_2_in[10]),
        .I1(p_0_in[31]),
        .I2(p_1_in[10]),
        .O(mux_out2[42]));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[43]_i_5 
       (.I0(p_0_in[11]),
        .I1(\y_r_reg_n_0_[11] ),
        .O(\remainder[43]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[43]_i_6 
       (.I0(p_0_in[10]),
        .I1(\y_r_reg_n_0_[10] ),
        .O(\remainder[43]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[43]_i_7 
       (.I0(p_0_in[9]),
        .I1(\y_r_reg_n_0_[9] ),
        .O(\remainder[43]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[43]_i_8 
       (.I0(p_0_in[8]),
        .I1(\y_r_reg_n_0_[8] ),
        .O(\remainder[43]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[43]_i_9 
       (.I0(\y_r_reg_n_0_[11] ),
        .I1(p_0_in[11]),
        .O(\remainder[43]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[44]_i_1 
       (.I0(mux_out2[43]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[12]),
        .I3(p_0_in[31]),
        .I4(p_2_in[12]),
        .I5(start_IBUF),
        .O(\remainder[44]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[44]_i_2 
       (.I0(p_2_in[11]),
        .I1(p_0_in[31]),
        .I2(p_1_in[11]),
        .O(mux_out2[43]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[45]_i_1 
       (.I0(mux_out2[44]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[13]),
        .I3(p_0_in[31]),
        .I4(p_2_in[13]),
        .I5(start_IBUF),
        .O(\remainder[45]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[45]_i_2 
       (.I0(p_2_in[12]),
        .I1(p_0_in[31]),
        .I2(p_1_in[12]),
        .O(mux_out2[44]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[46]_i_1 
       (.I0(mux_out2[45]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[14]),
        .I3(p_0_in[31]),
        .I4(p_2_in[14]),
        .I5(start_IBUF),
        .O(\remainder[46]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[46]_i_2 
       (.I0(p_2_in[13]),
        .I1(p_0_in[31]),
        .I2(p_1_in[13]),
        .O(mux_out2[45]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[47]_i_1 
       (.I0(mux_out2[46]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[15]),
        .I3(p_0_in[31]),
        .I4(p_2_in[15]),
        .I5(start_IBUF),
        .O(\remainder[47]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[47]_i_10 
       (.I0(\y_r_reg_n_0_[14] ),
        .I1(p_0_in[14]),
        .O(\remainder[47]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[47]_i_11 
       (.I0(\y_r_reg_n_0_[13] ),
        .I1(p_0_in[13]),
        .O(\remainder[47]_i_11_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[47]_i_12 
       (.I0(\y_r_reg_n_0_[12] ),
        .I1(p_0_in[12]),
        .O(\remainder[47]_i_12_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[47]_i_2 
       (.I0(p_2_in[14]),
        .I1(p_0_in[31]),
        .I2(p_1_in[14]),
        .O(mux_out2[46]));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[47]_i_5 
       (.I0(p_0_in[15]),
        .I1(\y_r_reg_n_0_[15] ),
        .O(\remainder[47]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[47]_i_6 
       (.I0(p_0_in[14]),
        .I1(\y_r_reg_n_0_[14] ),
        .O(\remainder[47]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[47]_i_7 
       (.I0(p_0_in[13]),
        .I1(\y_r_reg_n_0_[13] ),
        .O(\remainder[47]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[47]_i_8 
       (.I0(p_0_in[12]),
        .I1(\y_r_reg_n_0_[12] ),
        .O(\remainder[47]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[47]_i_9 
       (.I0(\y_r_reg_n_0_[15] ),
        .I1(p_0_in[15]),
        .O(\remainder[47]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[48]_i_1 
       (.I0(mux_out2[47]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[16]),
        .I3(p_0_in[31]),
        .I4(p_2_in[16]),
        .I5(start_IBUF),
        .O(\remainder[48]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[48]_i_2 
       (.I0(p_2_in[15]),
        .I1(p_0_in[31]),
        .I2(p_1_in[15]),
        .O(mux_out2[47]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[49]_i_1 
       (.I0(mux_out2[48]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[17]),
        .I3(p_0_in[31]),
        .I4(p_2_in[17]),
        .I5(start_IBUF),
        .O(\remainder[49]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[49]_i_2 
       (.I0(p_2_in[16]),
        .I1(p_0_in[31]),
        .I2(p_1_in[16]),
        .O(mux_out2[48]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[4]_i_1 
       (.I0(x_IBUF[3]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[4] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[3] ),
        .O(\remainder[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[50]_i_1 
       (.I0(mux_out2[49]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[18]),
        .I3(p_0_in[31]),
        .I4(p_2_in[18]),
        .I5(start_IBUF),
        .O(\remainder[50]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[50]_i_2 
       (.I0(p_2_in[17]),
        .I1(p_0_in[31]),
        .I2(p_1_in[17]),
        .O(mux_out2[49]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[51]_i_1 
       (.I0(mux_out2[50]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[19]),
        .I3(p_0_in[31]),
        .I4(p_2_in[19]),
        .I5(start_IBUF),
        .O(\remainder[51]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[51]_i_10 
       (.I0(\y_r_reg_n_0_[18] ),
        .I1(p_0_in[18]),
        .O(\remainder[51]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[51]_i_11 
       (.I0(\y_r_reg_n_0_[17] ),
        .I1(p_0_in[17]),
        .O(\remainder[51]_i_11_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[51]_i_12 
       (.I0(\y_r_reg_n_0_[16] ),
        .I1(p_0_in[16]),
        .O(\remainder[51]_i_12_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[51]_i_2 
       (.I0(p_2_in[18]),
        .I1(p_0_in[31]),
        .I2(p_1_in[18]),
        .O(mux_out2[50]));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[51]_i_5 
       (.I0(p_0_in[19]),
        .I1(\y_r_reg_n_0_[19] ),
        .O(\remainder[51]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[51]_i_6 
       (.I0(p_0_in[18]),
        .I1(\y_r_reg_n_0_[18] ),
        .O(\remainder[51]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[51]_i_7 
       (.I0(p_0_in[17]),
        .I1(\y_r_reg_n_0_[17] ),
        .O(\remainder[51]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[51]_i_8 
       (.I0(p_0_in[16]),
        .I1(\y_r_reg_n_0_[16] ),
        .O(\remainder[51]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[51]_i_9 
       (.I0(\y_r_reg_n_0_[19] ),
        .I1(p_0_in[19]),
        .O(\remainder[51]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[52]_i_1 
       (.I0(mux_out2[51]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[20]),
        .I3(p_0_in[31]),
        .I4(p_2_in[20]),
        .I5(start_IBUF),
        .O(\remainder[52]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[52]_i_2 
       (.I0(p_2_in[19]),
        .I1(p_0_in[31]),
        .I2(p_1_in[19]),
        .O(mux_out2[51]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[53]_i_1 
       (.I0(mux_out2[52]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[21]),
        .I3(p_0_in[31]),
        .I4(p_2_in[21]),
        .I5(start_IBUF),
        .O(\remainder[53]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[53]_i_2 
       (.I0(p_2_in[20]),
        .I1(p_0_in[31]),
        .I2(p_1_in[20]),
        .O(mux_out2[52]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[54]_i_1 
       (.I0(mux_out2[53]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[22]),
        .I3(p_0_in[31]),
        .I4(p_2_in[22]),
        .I5(start_IBUF),
        .O(\remainder[54]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[54]_i_2 
       (.I0(p_2_in[21]),
        .I1(p_0_in[31]),
        .I2(p_1_in[21]),
        .O(mux_out2[53]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[55]_i_1 
       (.I0(mux_out2[54]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[23]),
        .I3(p_0_in[31]),
        .I4(p_2_in[23]),
        .I5(start_IBUF),
        .O(\remainder[55]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[55]_i_10 
       (.I0(\y_r_reg_n_0_[22] ),
        .I1(p_0_in[22]),
        .O(\remainder[55]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[55]_i_11 
       (.I0(\y_r_reg_n_0_[21] ),
        .I1(p_0_in[21]),
        .O(\remainder[55]_i_11_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[55]_i_12 
       (.I0(\y_r_reg_n_0_[20] ),
        .I1(p_0_in[20]),
        .O(\remainder[55]_i_12_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[55]_i_2 
       (.I0(p_2_in[22]),
        .I1(p_0_in[31]),
        .I2(p_1_in[22]),
        .O(mux_out2[54]));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[55]_i_5 
       (.I0(p_0_in[23]),
        .I1(\y_r_reg_n_0_[23] ),
        .O(\remainder[55]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[55]_i_6 
       (.I0(p_0_in[22]),
        .I1(\y_r_reg_n_0_[22] ),
        .O(\remainder[55]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[55]_i_7 
       (.I0(p_0_in[21]),
        .I1(\y_r_reg_n_0_[21] ),
        .O(\remainder[55]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[55]_i_8 
       (.I0(p_0_in[20]),
        .I1(\y_r_reg_n_0_[20] ),
        .O(\remainder[55]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[55]_i_9 
       (.I0(\y_r_reg_n_0_[23] ),
        .I1(p_0_in[23]),
        .O(\remainder[55]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[56]_i_1 
       (.I0(mux_out2[55]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[24]),
        .I3(p_0_in[31]),
        .I4(p_2_in[24]),
        .I5(start_IBUF),
        .O(\remainder[56]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[56]_i_2 
       (.I0(p_2_in[23]),
        .I1(p_0_in[31]),
        .I2(p_1_in[23]),
        .O(mux_out2[55]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[57]_i_1 
       (.I0(mux_out2[56]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[25]),
        .I3(p_0_in[31]),
        .I4(p_2_in[25]),
        .I5(start_IBUF),
        .O(\remainder[57]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[57]_i_2 
       (.I0(p_2_in[24]),
        .I1(p_0_in[31]),
        .I2(p_1_in[24]),
        .O(mux_out2[56]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[58]_i_1 
       (.I0(mux_out2[57]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[26]),
        .I3(p_0_in[31]),
        .I4(p_2_in[26]),
        .I5(start_IBUF),
        .O(\remainder[58]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[58]_i_2 
       (.I0(p_2_in[25]),
        .I1(p_0_in[31]),
        .I2(p_1_in[25]),
        .O(mux_out2[57]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[59]_i_1 
       (.I0(mux_out2[58]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[27]),
        .I3(p_0_in[31]),
        .I4(p_2_in[27]),
        .I5(start_IBUF),
        .O(\remainder[59]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[59]_i_10 
       (.I0(\y_r_reg_n_0_[26] ),
        .I1(p_0_in[26]),
        .O(\remainder[59]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[59]_i_11 
       (.I0(\y_r_reg_n_0_[25] ),
        .I1(p_0_in[25]),
        .O(\remainder[59]_i_11_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[59]_i_12 
       (.I0(\y_r_reg_n_0_[24] ),
        .I1(p_0_in[24]),
        .O(\remainder[59]_i_12_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[59]_i_2 
       (.I0(p_2_in[26]),
        .I1(p_0_in[31]),
        .I2(p_1_in[26]),
        .O(mux_out2[58]));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[59]_i_5 
       (.I0(p_0_in[27]),
        .I1(\y_r_reg_n_0_[27] ),
        .O(\remainder[59]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[59]_i_6 
       (.I0(p_0_in[26]),
        .I1(\y_r_reg_n_0_[26] ),
        .O(\remainder[59]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[59]_i_7 
       (.I0(p_0_in[25]),
        .I1(\y_r_reg_n_0_[25] ),
        .O(\remainder[59]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[59]_i_8 
       (.I0(p_0_in[24]),
        .I1(\y_r_reg_n_0_[24] ),
        .O(\remainder[59]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[59]_i_9 
       (.I0(\y_r_reg_n_0_[27] ),
        .I1(p_0_in[27]),
        .O(\remainder[59]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[5]_i_1 
       (.I0(x_IBUF[4]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[5] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[4] ),
        .O(\remainder[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[60]_i_1 
       (.I0(mux_out2[59]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[28]),
        .I3(p_0_in[31]),
        .I4(p_2_in[28]),
        .I5(start_IBUF),
        .O(\remainder[60]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[60]_i_2 
       (.I0(p_2_in[27]),
        .I1(p_0_in[31]),
        .I2(p_1_in[27]),
        .O(mux_out2[59]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[61]_i_1 
       (.I0(mux_out2[60]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[29]),
        .I3(p_0_in[31]),
        .I4(p_2_in[29]),
        .I5(start_IBUF),
        .O(\remainder[61]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[61]_i_2 
       (.I0(p_2_in[28]),
        .I1(p_0_in[31]),
        .I2(p_1_in[28]),
        .O(mux_out2[60]));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \remainder[62]_i_1 
       (.I0(mux_out2[61]),
        .I1(\remainder[63]_i_3_n_0 ),
        .I2(p_1_in[30]),
        .I3(p_0_in[31]),
        .I4(p_2_in[30]),
        .I5(start_IBUF),
        .O(\remainder[62]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[62]_i_2 
       (.I0(p_2_in[29]),
        .I1(p_0_in[31]),
        .I2(p_1_in[29]),
        .O(mux_out2[61]));
  LUT3 #(
    .INIT(8'hFE)) 
    \remainder[63]_i_1 
       (.I0(start_IBUF),
        .I1(busy_OBUF),
        .I2(\remainder[63]_i_3_n_0 ),
        .O(\remainder[63]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[63]_i_10 
       (.I0(p_0_in[28]),
        .I1(\y_r_reg_n_0_[28] ),
        .O(\remainder[63]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[63]_i_11 
       (.I0(\y_r_reg_n_0_[30] ),
        .I1(p_0_in[30]),
        .O(\remainder[63]_i_11_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[63]_i_12 
       (.I0(\y_r_reg_n_0_[29] ),
        .I1(p_0_in[29]),
        .O(\remainder[63]_i_12_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \remainder[63]_i_13 
       (.I0(\y_r_reg_n_0_[28] ),
        .I1(p_0_in[28]),
        .O(\remainder[63]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFE200E2)) 
    \remainder[63]_i_2 
       (.I0(p_1_in[30]),
        .I1(p_0_in[31]),
        .I2(p_2_in[30]),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(mux_out2[63]),
        .I5(start_IBUF),
        .O(\remainder[63]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \remainder[63]_i_3 
       (.I0(busy_OBUF),
        .I1(cnt_end),
        .O(\remainder[63]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \remainder[63]_i_6 
       (.I0(p_2_in[31]),
        .I1(p_0_in[31]),
        .I2(p_1_in[31]),
        .O(mux_out2[63]));
  LUT1 #(
    .INIT(2'h1)) 
    \remainder[63]_i_7 
       (.I0(p_0_in[31]),
        .O(\remainder[63]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[63]_i_8 
       (.I0(p_0_in[30]),
        .I1(\y_r_reg_n_0_[30] ),
        .O(\remainder[63]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \remainder[63]_i_9 
       (.I0(p_0_in[29]),
        .I1(\y_r_reg_n_0_[29] ),
        .O(\remainder[63]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[6]_i_1 
       (.I0(x_IBUF[5]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[6] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[5] ),
        .O(\remainder[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[7]_i_1 
       (.I0(x_IBUF[6]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[7] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[6] ),
        .O(\remainder[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[8]_i_1 
       (.I0(x_IBUF[7]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[8] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[7] ),
        .O(\remainder[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \remainder[9]_i_1 
       (.I0(x_IBUF[8]),
        .I1(start_IBUF),
        .I2(\remainder_reg_n_0_[9] ),
        .I3(\remainder[63]_i_3_n_0 ),
        .I4(\remainder_reg_n_0_[8] ),
        .O(\remainder[9]_i_1_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[10]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[10] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[11]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[11] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[12]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[12] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[13]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[13] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[14]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[14] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[15]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[15] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[16]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[16] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[17] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[17]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[17] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[18] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[18]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[18] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[19] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[19]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[19] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[1]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[20] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[20]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[20] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[21] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[21]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[21] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[22] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[22]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[22] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[23] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[23]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[23] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[24] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[24]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[24] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[25] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[25]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[25] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[26] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[26]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[26] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[27] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[27]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[27] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[28] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[28]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[28] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[29] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[29]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[29] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[2]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[2] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[30] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[30]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[30] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[31] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[31]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[31] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[32] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[32]_i_1_n_0 ),
        .Q(p_0_in[0]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[33] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[33]_i_1_n_0 ),
        .Q(p_0_in[1]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[34] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[34]_i_1_n_0 ),
        .Q(p_0_in[2]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[35] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[35]_i_1_n_0 ),
        .Q(p_0_in[3]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \remainder_reg[35]_i_3 
       (.CI(1'b0),
        .CO({\remainder_reg[35]_i_3_n_0 ,\remainder_reg[35]_i_3_n_1 ,\remainder_reg[35]_i_3_n_2 ,\remainder_reg[35]_i_3_n_3 }),
        .CYINIT(1'b1),
        .DI(p_0_in[3:0]),
        .O(p_1_in[3:0]),
        .S({\remainder[35]_i_5_n_0 ,\remainder[35]_i_6_n_0 ,\remainder[35]_i_7_n_0 ,\remainder[35]_i_8_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \remainder_reg[35]_i_4 
       (.CI(1'b0),
        .CO({\remainder_reg[35]_i_4_n_0 ,\remainder_reg[35]_i_4_n_1 ,\remainder_reg[35]_i_4_n_2 ,\remainder_reg[35]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI(p_0_in[3:0]),
        .O(p_2_in[3:0]),
        .S({\remainder[35]_i_9_n_0 ,\remainder[35]_i_10_n_0 ,\remainder[35]_i_11_n_0 ,\remainder[35]_i_12_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[36] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[36]_i_1_n_0 ),
        .Q(p_0_in[4]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[37] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[37]_i_1_n_0 ),
        .Q(p_0_in[5]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[38] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[38]_i_1_n_0 ),
        .Q(p_0_in[6]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[39] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[39]_i_1_n_0 ),
        .Q(p_0_in[7]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \remainder_reg[39]_i_3 
       (.CI(\remainder_reg[35]_i_3_n_0 ),
        .CO({\remainder_reg[39]_i_3_n_0 ,\remainder_reg[39]_i_3_n_1 ,\remainder_reg[39]_i_3_n_2 ,\remainder_reg[39]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI(p_0_in[7:4]),
        .O(p_1_in[7:4]),
        .S({\remainder[39]_i_5_n_0 ,\remainder[39]_i_6_n_0 ,\remainder[39]_i_7_n_0 ,\remainder[39]_i_8_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \remainder_reg[39]_i_4 
       (.CI(\remainder_reg[35]_i_4_n_0 ),
        .CO({\remainder_reg[39]_i_4_n_0 ,\remainder_reg[39]_i_4_n_1 ,\remainder_reg[39]_i_4_n_2 ,\remainder_reg[39]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI(p_0_in[7:4]),
        .O(p_2_in[7:4]),
        .S({\remainder[39]_i_9_n_0 ,\remainder[39]_i_10_n_0 ,\remainder[39]_i_11_n_0 ,\remainder[39]_i_12_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[3]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[3] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[40] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[40]_i_1_n_0 ),
        .Q(p_0_in[8]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[41] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[41]_i_1_n_0 ),
        .Q(p_0_in[9]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[42] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[42]_i_1_n_0 ),
        .Q(p_0_in[10]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[43] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[43]_i_1_n_0 ),
        .Q(p_0_in[11]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \remainder_reg[43]_i_3 
       (.CI(\remainder_reg[39]_i_3_n_0 ),
        .CO({\remainder_reg[43]_i_3_n_0 ,\remainder_reg[43]_i_3_n_1 ,\remainder_reg[43]_i_3_n_2 ,\remainder_reg[43]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI(p_0_in[11:8]),
        .O(p_1_in[11:8]),
        .S({\remainder[43]_i_5_n_0 ,\remainder[43]_i_6_n_0 ,\remainder[43]_i_7_n_0 ,\remainder[43]_i_8_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \remainder_reg[43]_i_4 
       (.CI(\remainder_reg[39]_i_4_n_0 ),
        .CO({\remainder_reg[43]_i_4_n_0 ,\remainder_reg[43]_i_4_n_1 ,\remainder_reg[43]_i_4_n_2 ,\remainder_reg[43]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI(p_0_in[11:8]),
        .O(p_2_in[11:8]),
        .S({\remainder[43]_i_9_n_0 ,\remainder[43]_i_10_n_0 ,\remainder[43]_i_11_n_0 ,\remainder[43]_i_12_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[44] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[44]_i_1_n_0 ),
        .Q(p_0_in[12]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[45] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[45]_i_1_n_0 ),
        .Q(p_0_in[13]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[46] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[46]_i_1_n_0 ),
        .Q(p_0_in[14]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[47] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[47]_i_1_n_0 ),
        .Q(p_0_in[15]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \remainder_reg[47]_i_3 
       (.CI(\remainder_reg[43]_i_3_n_0 ),
        .CO({\remainder_reg[47]_i_3_n_0 ,\remainder_reg[47]_i_3_n_1 ,\remainder_reg[47]_i_3_n_2 ,\remainder_reg[47]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI(p_0_in[15:12]),
        .O(p_1_in[15:12]),
        .S({\remainder[47]_i_5_n_0 ,\remainder[47]_i_6_n_0 ,\remainder[47]_i_7_n_0 ,\remainder[47]_i_8_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \remainder_reg[47]_i_4 
       (.CI(\remainder_reg[43]_i_4_n_0 ),
        .CO({\remainder_reg[47]_i_4_n_0 ,\remainder_reg[47]_i_4_n_1 ,\remainder_reg[47]_i_4_n_2 ,\remainder_reg[47]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI(p_0_in[15:12]),
        .O(p_2_in[15:12]),
        .S({\remainder[47]_i_9_n_0 ,\remainder[47]_i_10_n_0 ,\remainder[47]_i_11_n_0 ,\remainder[47]_i_12_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[48] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[48]_i_1_n_0 ),
        .Q(p_0_in[16]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[49] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[49]_i_1_n_0 ),
        .Q(p_0_in[17]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[4]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[4] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[50] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[50]_i_1_n_0 ),
        .Q(p_0_in[18]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[51] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[51]_i_1_n_0 ),
        .Q(p_0_in[19]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \remainder_reg[51]_i_3 
       (.CI(\remainder_reg[47]_i_3_n_0 ),
        .CO({\remainder_reg[51]_i_3_n_0 ,\remainder_reg[51]_i_3_n_1 ,\remainder_reg[51]_i_3_n_2 ,\remainder_reg[51]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI(p_0_in[19:16]),
        .O(p_1_in[19:16]),
        .S({\remainder[51]_i_5_n_0 ,\remainder[51]_i_6_n_0 ,\remainder[51]_i_7_n_0 ,\remainder[51]_i_8_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \remainder_reg[51]_i_4 
       (.CI(\remainder_reg[47]_i_4_n_0 ),
        .CO({\remainder_reg[51]_i_4_n_0 ,\remainder_reg[51]_i_4_n_1 ,\remainder_reg[51]_i_4_n_2 ,\remainder_reg[51]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI(p_0_in[19:16]),
        .O(p_2_in[19:16]),
        .S({\remainder[51]_i_9_n_0 ,\remainder[51]_i_10_n_0 ,\remainder[51]_i_11_n_0 ,\remainder[51]_i_12_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[52] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[52]_i_1_n_0 ),
        .Q(p_0_in[20]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[53] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[53]_i_1_n_0 ),
        .Q(p_0_in[21]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[54] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[54]_i_1_n_0 ),
        .Q(p_0_in[22]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[55] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[55]_i_1_n_0 ),
        .Q(p_0_in[23]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \remainder_reg[55]_i_3 
       (.CI(\remainder_reg[51]_i_3_n_0 ),
        .CO({\remainder_reg[55]_i_3_n_0 ,\remainder_reg[55]_i_3_n_1 ,\remainder_reg[55]_i_3_n_2 ,\remainder_reg[55]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI(p_0_in[23:20]),
        .O(p_1_in[23:20]),
        .S({\remainder[55]_i_5_n_0 ,\remainder[55]_i_6_n_0 ,\remainder[55]_i_7_n_0 ,\remainder[55]_i_8_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \remainder_reg[55]_i_4 
       (.CI(\remainder_reg[51]_i_4_n_0 ),
        .CO({\remainder_reg[55]_i_4_n_0 ,\remainder_reg[55]_i_4_n_1 ,\remainder_reg[55]_i_4_n_2 ,\remainder_reg[55]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI(p_0_in[23:20]),
        .O(p_2_in[23:20]),
        .S({\remainder[55]_i_9_n_0 ,\remainder[55]_i_10_n_0 ,\remainder[55]_i_11_n_0 ,\remainder[55]_i_12_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[56] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[56]_i_1_n_0 ),
        .Q(p_0_in[24]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[57] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[57]_i_1_n_0 ),
        .Q(p_0_in[25]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[58] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[58]_i_1_n_0 ),
        .Q(p_0_in[26]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[59] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[59]_i_1_n_0 ),
        .Q(p_0_in[27]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \remainder_reg[59]_i_3 
       (.CI(\remainder_reg[55]_i_3_n_0 ),
        .CO({\remainder_reg[59]_i_3_n_0 ,\remainder_reg[59]_i_3_n_1 ,\remainder_reg[59]_i_3_n_2 ,\remainder_reg[59]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI(p_0_in[27:24]),
        .O(p_1_in[27:24]),
        .S({\remainder[59]_i_5_n_0 ,\remainder[59]_i_6_n_0 ,\remainder[59]_i_7_n_0 ,\remainder[59]_i_8_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \remainder_reg[59]_i_4 
       (.CI(\remainder_reg[55]_i_4_n_0 ),
        .CO({\remainder_reg[59]_i_4_n_0 ,\remainder_reg[59]_i_4_n_1 ,\remainder_reg[59]_i_4_n_2 ,\remainder_reg[59]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI(p_0_in[27:24]),
        .O(p_2_in[27:24]),
        .S({\remainder[59]_i_9_n_0 ,\remainder[59]_i_10_n_0 ,\remainder[59]_i_11_n_0 ,\remainder[59]_i_12_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[5]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[5] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[60] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[60]_i_1_n_0 ),
        .Q(p_0_in[28]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[61] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[61]_i_1_n_0 ),
        .Q(p_0_in[29]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[62] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[62]_i_1_n_0 ),
        .Q(p_0_in[30]));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[63] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[63]_i_2_n_0 ),
        .Q(p_0_in[31]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \remainder_reg[63]_i_4 
       (.CI(\remainder_reg[59]_i_3_n_0 ),
        .CO({\NLW_remainder_reg[63]_i_4_CO_UNCONNECTED [3],\remainder_reg[63]_i_4_n_1 ,\remainder_reg[63]_i_4_n_2 ,\remainder_reg[63]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,p_0_in[30:28]}),
        .O(p_1_in[31:28]),
        .S({\remainder[63]_i_7_n_0 ,\remainder[63]_i_8_n_0 ,\remainder[63]_i_9_n_0 ,\remainder[63]_i_10_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \remainder_reg[63]_i_5 
       (.CI(\remainder_reg[59]_i_4_n_0 ),
        .CO({\NLW_remainder_reg[63]_i_5_CO_UNCONNECTED [3],\remainder_reg[63]_i_5_n_1 ,\remainder_reg[63]_i_5_n_2 ,\remainder_reg[63]_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,p_0_in[30:28]}),
        .O(p_2_in[31:28]),
        .S({p_0_in[31],\remainder[63]_i_11_n_0 ,\remainder[63]_i_12_n_0 ,\remainder[63]_i_13_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[6]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[6] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[7]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[7] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[8]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[8] ));
  FDCE #(
    .INIT(1'b0)) 
    \remainder_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(\remainder[63]_i_1_n_0 ),
        .CLR(rst_IBUF),
        .D(\remainder[9]_i_1_n_0 ),
        .Q(\remainder_reg_n_0_[9] ));
  IBUF rst_IBUF_inst
       (.I(rst),
        .O(rst_IBUF));
  IBUF start_IBUF_inst
       (.I(start),
        .O(start_IBUF));
  IBUF \x_IBUF[0]_inst 
       (.I(x[0]),
        .O(x_IBUF[0]));
  IBUF \x_IBUF[10]_inst 
       (.I(x[10]),
        .O(x_IBUF[10]));
  IBUF \x_IBUF[11]_inst 
       (.I(x[11]),
        .O(x_IBUF[11]));
  IBUF \x_IBUF[12]_inst 
       (.I(x[12]),
        .O(x_IBUF[12]));
  IBUF \x_IBUF[13]_inst 
       (.I(x[13]),
        .O(x_IBUF[13]));
  IBUF \x_IBUF[14]_inst 
       (.I(x[14]),
        .O(x_IBUF[14]));
  IBUF \x_IBUF[15]_inst 
       (.I(x[15]),
        .O(x_IBUF[15]));
  IBUF \x_IBUF[16]_inst 
       (.I(x[16]),
        .O(x_IBUF[16]));
  IBUF \x_IBUF[17]_inst 
       (.I(x[17]),
        .O(x_IBUF[17]));
  IBUF \x_IBUF[18]_inst 
       (.I(x[18]),
        .O(x_IBUF[18]));
  IBUF \x_IBUF[19]_inst 
       (.I(x[19]),
        .O(x_IBUF[19]));
  IBUF \x_IBUF[1]_inst 
       (.I(x[1]),
        .O(x_IBUF[1]));
  IBUF \x_IBUF[20]_inst 
       (.I(x[20]),
        .O(x_IBUF[20]));
  IBUF \x_IBUF[21]_inst 
       (.I(x[21]),
        .O(x_IBUF[21]));
  IBUF \x_IBUF[22]_inst 
       (.I(x[22]),
        .O(x_IBUF[22]));
  IBUF \x_IBUF[23]_inst 
       (.I(x[23]),
        .O(x_IBUF[23]));
  IBUF \x_IBUF[24]_inst 
       (.I(x[24]),
        .O(x_IBUF[24]));
  IBUF \x_IBUF[25]_inst 
       (.I(x[25]),
        .O(x_IBUF[25]));
  IBUF \x_IBUF[26]_inst 
       (.I(x[26]),
        .O(x_IBUF[26]));
  IBUF \x_IBUF[27]_inst 
       (.I(x[27]),
        .O(x_IBUF[27]));
  IBUF \x_IBUF[28]_inst 
       (.I(x[28]),
        .O(x_IBUF[28]));
  IBUF \x_IBUF[29]_inst 
       (.I(x[29]),
        .O(x_IBUF[29]));
  IBUF \x_IBUF[2]_inst 
       (.I(x[2]),
        .O(x_IBUF[2]));
  IBUF \x_IBUF[30]_inst 
       (.I(x[30]),
        .O(x_IBUF[30]));
  IBUF \x_IBUF[31]_inst 
       (.I(x[31]),
        .O(x_IBUF[31]));
  IBUF \x_IBUF[3]_inst 
       (.I(x[3]),
        .O(x_IBUF[3]));
  IBUF \x_IBUF[4]_inst 
       (.I(x[4]),
        .O(x_IBUF[4]));
  IBUF \x_IBUF[5]_inst 
       (.I(x[5]),
        .O(x_IBUF[5]));
  IBUF \x_IBUF[6]_inst 
       (.I(x[6]),
        .O(x_IBUF[6]));
  IBUF \x_IBUF[7]_inst 
       (.I(x[7]),
        .O(x_IBUF[7]));
  IBUF \x_IBUF[8]_inst 
       (.I(x[8]),
        .O(x_IBUF[8]));
  IBUF \x_IBUF[9]_inst 
       (.I(x[9]),
        .O(x_IBUF[9]));
  FDCE #(
    .INIT(1'b0)) 
    \x_r_reg[31] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(x_IBUF[31]),
        .Q(x_r));
  IBUF \y_IBUF[0]_inst 
       (.I(y[0]),
        .O(y_IBUF[0]));
  IBUF \y_IBUF[10]_inst 
       (.I(y[10]),
        .O(y_IBUF[10]));
  IBUF \y_IBUF[11]_inst 
       (.I(y[11]),
        .O(y_IBUF[11]));
  IBUF \y_IBUF[12]_inst 
       (.I(y[12]),
        .O(y_IBUF[12]));
  IBUF \y_IBUF[13]_inst 
       (.I(y[13]),
        .O(y_IBUF[13]));
  IBUF \y_IBUF[14]_inst 
       (.I(y[14]),
        .O(y_IBUF[14]));
  IBUF \y_IBUF[15]_inst 
       (.I(y[15]),
        .O(y_IBUF[15]));
  IBUF \y_IBUF[16]_inst 
       (.I(y[16]),
        .O(y_IBUF[16]));
  IBUF \y_IBUF[17]_inst 
       (.I(y[17]),
        .O(y_IBUF[17]));
  IBUF \y_IBUF[18]_inst 
       (.I(y[18]),
        .O(y_IBUF[18]));
  IBUF \y_IBUF[19]_inst 
       (.I(y[19]),
        .O(y_IBUF[19]));
  IBUF \y_IBUF[1]_inst 
       (.I(y[1]),
        .O(y_IBUF[1]));
  IBUF \y_IBUF[20]_inst 
       (.I(y[20]),
        .O(y_IBUF[20]));
  IBUF \y_IBUF[21]_inst 
       (.I(y[21]),
        .O(y_IBUF[21]));
  IBUF \y_IBUF[22]_inst 
       (.I(y[22]),
        .O(y_IBUF[22]));
  IBUF \y_IBUF[23]_inst 
       (.I(y[23]),
        .O(y_IBUF[23]));
  IBUF \y_IBUF[24]_inst 
       (.I(y[24]),
        .O(y_IBUF[24]));
  IBUF \y_IBUF[25]_inst 
       (.I(y[25]),
        .O(y_IBUF[25]));
  IBUF \y_IBUF[26]_inst 
       (.I(y[26]),
        .O(y_IBUF[26]));
  IBUF \y_IBUF[27]_inst 
       (.I(y[27]),
        .O(y_IBUF[27]));
  IBUF \y_IBUF[28]_inst 
       (.I(y[28]),
        .O(y_IBUF[28]));
  IBUF \y_IBUF[29]_inst 
       (.I(y[29]),
        .O(y_IBUF[29]));
  IBUF \y_IBUF[2]_inst 
       (.I(y[2]),
        .O(y_IBUF[2]));
  IBUF \y_IBUF[30]_inst 
       (.I(y[30]),
        .O(y_IBUF[30]));
  IBUF \y_IBUF[31]_inst 
       (.I(y[31]),
        .O(y_IBUF[31]));
  IBUF \y_IBUF[3]_inst 
       (.I(y[3]),
        .O(y_IBUF[3]));
  IBUF \y_IBUF[4]_inst 
       (.I(y[4]),
        .O(y_IBUF[4]));
  IBUF \y_IBUF[5]_inst 
       (.I(y[5]),
        .O(y_IBUF[5]));
  IBUF \y_IBUF[6]_inst 
       (.I(y[6]),
        .O(y_IBUF[6]));
  IBUF \y_IBUF[7]_inst 
       (.I(y[7]),
        .O(y_IBUF[7]));
  IBUF \y_IBUF[8]_inst 
       (.I(y[8]),
        .O(y_IBUF[8]));
  IBUF \y_IBUF[9]_inst 
       (.I(y[9]),
        .O(y_IBUF[9]));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[0]),
        .Q(\y_r_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[10]),
        .Q(\y_r_reg_n_0_[10] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[11]),
        .Q(\y_r_reg_n_0_[11] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[12]),
        .Q(\y_r_reg_n_0_[12] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[13]),
        .Q(\y_r_reg_n_0_[13] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[14]),
        .Q(\y_r_reg_n_0_[14] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[15]),
        .Q(\y_r_reg_n_0_[15] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[16]),
        .Q(\y_r_reg_n_0_[16] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[17] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[17]),
        .Q(\y_r_reg_n_0_[17] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[18] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[18]),
        .Q(\y_r_reg_n_0_[18] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[19] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[19]),
        .Q(\y_r_reg_n_0_[19] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[1]),
        .Q(\y_r_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[20] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[20]),
        .Q(\y_r_reg_n_0_[20] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[21] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[21]),
        .Q(\y_r_reg_n_0_[21] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[22] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[22]),
        .Q(\y_r_reg_n_0_[22] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[23] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[23]),
        .Q(\y_r_reg_n_0_[23] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[24] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[24]),
        .Q(\y_r_reg_n_0_[24] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[25] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[25]),
        .Q(\y_r_reg_n_0_[25] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[26] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[26]),
        .Q(\y_r_reg_n_0_[26] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[27] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[27]),
        .Q(\y_r_reg_n_0_[27] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[28] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[28]),
        .Q(\y_r_reg_n_0_[28] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[29] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[29]),
        .Q(\y_r_reg_n_0_[29] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[2]),
        .Q(\y_r_reg_n_0_[2] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[30] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[30]),
        .Q(\y_r_reg_n_0_[30] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[31] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[31]),
        .Q(y_r));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[3]),
        .Q(\y_r_reg_n_0_[3] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[4]),
        .Q(\y_r_reg_n_0_[4] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[5]),
        .Q(\y_r_reg_n_0_[5] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[6]),
        .Q(\y_r_reg_n_0_[6] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[7]),
        .Q(\y_r_reg_n_0_[7] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[8]),
        .Q(\y_r_reg_n_0_[8] ));
  FDCE #(
    .INIT(1'b0)) 
    \y_r_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(start_IBUF),
        .CLR(rst_IBUF),
        .D(y_IBUF[9]),
        .Q(\y_r_reg_n_0_[9] ));
  OBUF \z_OBUF[0]_inst 
       (.I(z_OBUF[0]),
        .O(z[0]));
  OBUF \z_OBUF[10]_inst 
       (.I(z_OBUF[10]),
        .O(z[10]));
  OBUF \z_OBUF[11]_inst 
       (.I(z_OBUF[11]),
        .O(z[11]));
  OBUF \z_OBUF[12]_inst 
       (.I(z_OBUF[12]),
        .O(z[12]));
  OBUF \z_OBUF[13]_inst 
       (.I(z_OBUF[13]),
        .O(z[13]));
  OBUF \z_OBUF[14]_inst 
       (.I(z_OBUF[14]),
        .O(z[14]));
  OBUF \z_OBUF[15]_inst 
       (.I(z_OBUF[15]),
        .O(z[15]));
  OBUF \z_OBUF[16]_inst 
       (.I(z_OBUF[16]),
        .O(z[16]));
  OBUF \z_OBUF[17]_inst 
       (.I(z_OBUF[17]),
        .O(z[17]));
  OBUF \z_OBUF[18]_inst 
       (.I(z_OBUF[18]),
        .O(z[18]));
  OBUF \z_OBUF[19]_inst 
       (.I(z_OBUF[19]),
        .O(z[19]));
  OBUF \z_OBUF[1]_inst 
       (.I(z_OBUF[1]),
        .O(z[1]));
  OBUF \z_OBUF[20]_inst 
       (.I(z_OBUF[20]),
        .O(z[20]));
  OBUF \z_OBUF[21]_inst 
       (.I(z_OBUF[21]),
        .O(z[21]));
  OBUF \z_OBUF[22]_inst 
       (.I(z_OBUF[22]),
        .O(z[22]));
  OBUF \z_OBUF[23]_inst 
       (.I(z_OBUF[23]),
        .O(z[23]));
  OBUF \z_OBUF[24]_inst 
       (.I(z_OBUF[24]),
        .O(z[24]));
  OBUF \z_OBUF[25]_inst 
       (.I(z_OBUF[25]),
        .O(z[25]));
  OBUF \z_OBUF[26]_inst 
       (.I(z_OBUF[26]),
        .O(z[26]));
  OBUF \z_OBUF[27]_inst 
       (.I(z_OBUF[27]),
        .O(z[27]));
  OBUF \z_OBUF[28]_inst 
       (.I(z_OBUF[28]),
        .O(z[28]));
  OBUF \z_OBUF[29]_inst 
       (.I(z_OBUF[29]),
        .O(z[29]));
  OBUF \z_OBUF[2]_inst 
       (.I(z_OBUF[2]),
        .O(z[2]));
  OBUF \z_OBUF[30]_inst 
       (.I(z_OBUF[30]),
        .O(z[30]));
  OBUF \z_OBUF[31]_inst 
       (.I(z_OBUF[31]),
        .O(z[31]));
  LUT2 #(
    .INIT(4'h6)) 
    \z_OBUF[31]_inst_i_1 
       (.I0(y_r),
        .I1(x_r),
        .O(z_OBUF[31]));
  OBUF \z_OBUF[3]_inst 
       (.I(z_OBUF[3]),
        .O(z[3]));
  OBUF \z_OBUF[4]_inst 
       (.I(z_OBUF[4]),
        .O(z[4]));
  OBUF \z_OBUF[5]_inst 
       (.I(z_OBUF[5]),
        .O(z[5]));
  OBUF \z_OBUF[6]_inst 
       (.I(z_OBUF[6]),
        .O(z[6]));
  OBUF \z_OBUF[7]_inst 
       (.I(z_OBUF[7]),
        .O(z[7]));
  OBUF \z_OBUF[8]_inst 
       (.I(z_OBUF[8]),
        .O(z[8]));
  OBUF \z_OBUF[9]_inst 
       (.I(z_OBUF[9]),
        .O(z[9]));
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
