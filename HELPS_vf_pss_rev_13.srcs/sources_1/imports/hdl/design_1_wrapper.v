//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3.1 (win64) Build 2489853 Tue Mar 26 04:20:25 MDT 2019
//Date        : Thu May 14 14:56:28 2020
//Host        : DESKTOP-85VM9EM running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (BRAM_PORTA_OUT_1_addr,
    BRAM_PORTA_OUT_1_clk,
    BRAM_PORTA_OUT_1_din,
    BRAM_PORTA_OUT_1_dout,
    BRAM_PORTA_OUT_1_en,
    BRAM_PORTA_OUT_1_rst,
    BRAM_PORTA_OUT_1_we,
    BRAM_PORTA_OUT_2_addr,
    BRAM_PORTA_OUT_2_clk,
    BRAM_PORTA_OUT_2_din,
    BRAM_PORTA_OUT_2_dout,
    BRAM_PORTA_OUT_2_en,
    BRAM_PORTA_OUT_2_rst,
    BRAM_PORTA_OUT_2_we,
    BRAM_PORTA_OUT_3_addr,
    BRAM_PORTA_OUT_3_clk,
    BRAM_PORTA_OUT_3_din,
    BRAM_PORTA_OUT_3_dout,
    BRAM_PORTA_OUT_3_en,
    BRAM_PORTA_OUT_3_rst,
    BRAM_PORTA_OUT_3_we,
    BRAM_PORTA_SEQ_addr,
    BRAM_PORTA_SEQ_clk,
    BRAM_PORTA_SEQ_din,
    BRAM_PORTA_SEQ_dout,
    BRAM_PORTA_SEQ_en,
    BRAM_PORTA_SEQ_rst,
    BRAM_PORTA_SEQ_we,
    BRAM_PORTB_OUT_1_addr,
    BRAM_PORTB_OUT_1_clk,
    BRAM_PORTB_OUT_1_din,
    BRAM_PORTB_OUT_1_dout,
    BRAM_PORTB_OUT_1_en,
    BRAM_PORTB_OUT_1_rst,
    BRAM_PORTB_OUT_1_we,
    BRAM_PORTB_OUT_2_addr,
    BRAM_PORTB_OUT_2_clk,
    BRAM_PORTB_OUT_2_din,
    BRAM_PORTB_OUT_2_dout,
    BRAM_PORTB_OUT_2_en,
    BRAM_PORTB_OUT_2_rst,
    BRAM_PORTB_OUT_2_we,
    BRAM_PORTB_OUT_3_addr,
    BRAM_PORTB_OUT_3_clk,
    BRAM_PORTB_OUT_3_din,
    BRAM_PORTB_OUT_3_dout,
    BRAM_PORTB_OUT_3_en,
    BRAM_PORTB_OUT_3_rst,
    BRAM_PORTB_OUT_3_we,
    BRAM_PORTB_SEQ_addr,
    BRAM_PORTB_SEQ_clk,
    BRAM_PORTB_SEQ_din,
    BRAM_PORTB_SEQ_dout,
    BRAM_PORTB_SEQ_en,
    BRAM_PORTB_SEQ_rst,
    BRAM_PORTB_SEQ_we,
    SFR_command,
    SFR_state,
    SFR_state_valid,
    clk,
    reset,
    resetn);
  output [16:0]BRAM_PORTA_OUT_1_addr;
  output BRAM_PORTA_OUT_1_clk;
  output [31:0]BRAM_PORTA_OUT_1_din;
  input [31:0]BRAM_PORTA_OUT_1_dout;
  output BRAM_PORTA_OUT_1_en;
  output BRAM_PORTA_OUT_1_rst;
  output [3:0]BRAM_PORTA_OUT_1_we;
  output [16:0]BRAM_PORTA_OUT_2_addr;
  output BRAM_PORTA_OUT_2_clk;
  output [31:0]BRAM_PORTA_OUT_2_din;
  input [31:0]BRAM_PORTA_OUT_2_dout;
  output BRAM_PORTA_OUT_2_en;
  output BRAM_PORTA_OUT_2_rst;
  output [3:0]BRAM_PORTA_OUT_2_we;
  output [16:0]BRAM_PORTA_OUT_3_addr;
  output BRAM_PORTA_OUT_3_clk;
  output [31:0]BRAM_PORTA_OUT_3_din;
  input [31:0]BRAM_PORTA_OUT_3_dout;
  output BRAM_PORTA_OUT_3_en;
  output BRAM_PORTA_OUT_3_rst;
  output [3:0]BRAM_PORTA_OUT_3_we;
  output [11:0]BRAM_PORTA_SEQ_addr;
  output BRAM_PORTA_SEQ_clk;
  output [31:0]BRAM_PORTA_SEQ_din;
  input [31:0]BRAM_PORTA_SEQ_dout;
  output BRAM_PORTA_SEQ_en;
  output BRAM_PORTA_SEQ_rst;
  output [3:0]BRAM_PORTA_SEQ_we;
  output [16:0]BRAM_PORTB_OUT_1_addr;
  output BRAM_PORTB_OUT_1_clk;
  output [31:0]BRAM_PORTB_OUT_1_din;
  input [31:0]BRAM_PORTB_OUT_1_dout;
  output BRAM_PORTB_OUT_1_en;
  output BRAM_PORTB_OUT_1_rst;
  output [3:0]BRAM_PORTB_OUT_1_we;
  output [16:0]BRAM_PORTB_OUT_2_addr;
  output BRAM_PORTB_OUT_2_clk;
  output [31:0]BRAM_PORTB_OUT_2_din;
  input [31:0]BRAM_PORTB_OUT_2_dout;
  output BRAM_PORTB_OUT_2_en;
  output BRAM_PORTB_OUT_2_rst;
  output [3:0]BRAM_PORTB_OUT_2_we;
  output [16:0]BRAM_PORTB_OUT_3_addr;
  output BRAM_PORTB_OUT_3_clk;
  output [31:0]BRAM_PORTB_OUT_3_din;
  input [31:0]BRAM_PORTB_OUT_3_dout;
  output BRAM_PORTB_OUT_3_en;
  output BRAM_PORTB_OUT_3_rst;
  output [3:0]BRAM_PORTB_OUT_3_we;
  output [11:0]BRAM_PORTB_SEQ_addr;
  output BRAM_PORTB_SEQ_clk;
  output [31:0]BRAM_PORTB_SEQ_din;
  input [31:0]BRAM_PORTB_SEQ_dout;
  output BRAM_PORTB_SEQ_en;
  output BRAM_PORTB_SEQ_rst;
  output [3:0]BRAM_PORTB_SEQ_we;
  output [63:0]SFR_command;
  input [63:0]SFR_state;
  input SFR_state_valid;
  input clk;
  input reset;
  output [0:0]resetn;

  wire [16:0]BRAM_PORTA_OUT_1_addr;
  wire BRAM_PORTA_OUT_1_clk;
  wire [31:0]BRAM_PORTA_OUT_1_din;
  wire [31:0]BRAM_PORTA_OUT_1_dout;
  wire BRAM_PORTA_OUT_1_en;
  wire BRAM_PORTA_OUT_1_rst;
  wire [3:0]BRAM_PORTA_OUT_1_we;
  wire [16:0]BRAM_PORTA_OUT_2_addr;
  wire BRAM_PORTA_OUT_2_clk;
  wire [31:0]BRAM_PORTA_OUT_2_din;
  wire [31:0]BRAM_PORTA_OUT_2_dout;
  wire BRAM_PORTA_OUT_2_en;
  wire BRAM_PORTA_OUT_2_rst;
  wire [3:0]BRAM_PORTA_OUT_2_we;
  wire [16:0]BRAM_PORTA_OUT_3_addr;
  wire BRAM_PORTA_OUT_3_clk;
  wire [31:0]BRAM_PORTA_OUT_3_din;
  wire [31:0]BRAM_PORTA_OUT_3_dout;
  wire BRAM_PORTA_OUT_3_en;
  wire BRAM_PORTA_OUT_3_rst;
  wire [3:0]BRAM_PORTA_OUT_3_we;
  wire [11:0]BRAM_PORTA_SEQ_addr;
  wire BRAM_PORTA_SEQ_clk;
  wire [31:0]BRAM_PORTA_SEQ_din;
  wire [31:0]BRAM_PORTA_SEQ_dout;
  wire BRAM_PORTA_SEQ_en;
  wire BRAM_PORTA_SEQ_rst;
  wire [3:0]BRAM_PORTA_SEQ_we;
  wire [16:0]BRAM_PORTB_OUT_1_addr;
  wire BRAM_PORTB_OUT_1_clk;
  wire [31:0]BRAM_PORTB_OUT_1_din;
  wire [31:0]BRAM_PORTB_OUT_1_dout;
  wire BRAM_PORTB_OUT_1_en;
  wire BRAM_PORTB_OUT_1_rst;
  wire [3:0]BRAM_PORTB_OUT_1_we;
  wire [16:0]BRAM_PORTB_OUT_2_addr;
  wire BRAM_PORTB_OUT_2_clk;
  wire [31:0]BRAM_PORTB_OUT_2_din;
  wire [31:0]BRAM_PORTB_OUT_2_dout;
  wire BRAM_PORTB_OUT_2_en;
  wire BRAM_PORTB_OUT_2_rst;
  wire [3:0]BRAM_PORTB_OUT_2_we;
  wire [16:0]BRAM_PORTB_OUT_3_addr;
  wire BRAM_PORTB_OUT_3_clk;
  wire [31:0]BRAM_PORTB_OUT_3_din;
  wire [31:0]BRAM_PORTB_OUT_3_dout;
  wire BRAM_PORTB_OUT_3_en;
  wire BRAM_PORTB_OUT_3_rst;
  wire [3:0]BRAM_PORTB_OUT_3_we;
  wire [11:0]BRAM_PORTB_SEQ_addr;
  wire BRAM_PORTB_SEQ_clk;
  wire [31:0]BRAM_PORTB_SEQ_din;
  wire [31:0]BRAM_PORTB_SEQ_dout;
  wire BRAM_PORTB_SEQ_en;
  wire BRAM_PORTB_SEQ_rst;
  wire [3:0]BRAM_PORTB_SEQ_we;
  wire [63:0]SFR_command;
  wire [63:0]SFR_state;
  wire SFR_state_valid;
  wire clk;
  wire reset;
  wire [0:0]resetn;

  design_1 design_1_i
       (.BRAM_PORTA_OUT_1_addr(BRAM_PORTA_OUT_1_addr),
        .BRAM_PORTA_OUT_1_clk(BRAM_PORTA_OUT_1_clk),
        .BRAM_PORTA_OUT_1_din(BRAM_PORTA_OUT_1_din),
        .BRAM_PORTA_OUT_1_dout(BRAM_PORTA_OUT_1_dout),
        .BRAM_PORTA_OUT_1_en(BRAM_PORTA_OUT_1_en),
        .BRAM_PORTA_OUT_1_rst(BRAM_PORTA_OUT_1_rst),
        .BRAM_PORTA_OUT_1_we(BRAM_PORTA_OUT_1_we),
        .BRAM_PORTA_OUT_2_addr(BRAM_PORTA_OUT_2_addr),
        .BRAM_PORTA_OUT_2_clk(BRAM_PORTA_OUT_2_clk),
        .BRAM_PORTA_OUT_2_din(BRAM_PORTA_OUT_2_din),
        .BRAM_PORTA_OUT_2_dout(BRAM_PORTA_OUT_2_dout),
        .BRAM_PORTA_OUT_2_en(BRAM_PORTA_OUT_2_en),
        .BRAM_PORTA_OUT_2_rst(BRAM_PORTA_OUT_2_rst),
        .BRAM_PORTA_OUT_2_we(BRAM_PORTA_OUT_2_we),
        .BRAM_PORTA_OUT_3_addr(BRAM_PORTA_OUT_3_addr),
        .BRAM_PORTA_OUT_3_clk(BRAM_PORTA_OUT_3_clk),
        .BRAM_PORTA_OUT_3_din(BRAM_PORTA_OUT_3_din),
        .BRAM_PORTA_OUT_3_dout(BRAM_PORTA_OUT_3_dout),
        .BRAM_PORTA_OUT_3_en(BRAM_PORTA_OUT_3_en),
        .BRAM_PORTA_OUT_3_rst(BRAM_PORTA_OUT_3_rst),
        .BRAM_PORTA_OUT_3_we(BRAM_PORTA_OUT_3_we),
        .BRAM_PORTA_SEQ_addr(BRAM_PORTA_SEQ_addr),
        .BRAM_PORTA_SEQ_clk(BRAM_PORTA_SEQ_clk),
        .BRAM_PORTA_SEQ_din(BRAM_PORTA_SEQ_din),
        .BRAM_PORTA_SEQ_dout(BRAM_PORTA_SEQ_dout),
        .BRAM_PORTA_SEQ_en(BRAM_PORTA_SEQ_en),
        .BRAM_PORTA_SEQ_rst(BRAM_PORTA_SEQ_rst),
        .BRAM_PORTA_SEQ_we(BRAM_PORTA_SEQ_we),
        .BRAM_PORTB_OUT_1_addr(BRAM_PORTB_OUT_1_addr),
        .BRAM_PORTB_OUT_1_clk(BRAM_PORTB_OUT_1_clk),
        .BRAM_PORTB_OUT_1_din(BRAM_PORTB_OUT_1_din),
        .BRAM_PORTB_OUT_1_dout(BRAM_PORTB_OUT_1_dout),
        .BRAM_PORTB_OUT_1_en(BRAM_PORTB_OUT_1_en),
        .BRAM_PORTB_OUT_1_rst(BRAM_PORTB_OUT_1_rst),
        .BRAM_PORTB_OUT_1_we(BRAM_PORTB_OUT_1_we),
        .BRAM_PORTB_OUT_2_addr(BRAM_PORTB_OUT_2_addr),
        .BRAM_PORTB_OUT_2_clk(BRAM_PORTB_OUT_2_clk),
        .BRAM_PORTB_OUT_2_din(BRAM_PORTB_OUT_2_din),
        .BRAM_PORTB_OUT_2_dout(BRAM_PORTB_OUT_2_dout),
        .BRAM_PORTB_OUT_2_en(BRAM_PORTB_OUT_2_en),
        .BRAM_PORTB_OUT_2_rst(BRAM_PORTB_OUT_2_rst),
        .BRAM_PORTB_OUT_2_we(BRAM_PORTB_OUT_2_we),
        .BRAM_PORTB_OUT_3_addr(BRAM_PORTB_OUT_3_addr),
        .BRAM_PORTB_OUT_3_clk(BRAM_PORTB_OUT_3_clk),
        .BRAM_PORTB_OUT_3_din(BRAM_PORTB_OUT_3_din),
        .BRAM_PORTB_OUT_3_dout(BRAM_PORTB_OUT_3_dout),
        .BRAM_PORTB_OUT_3_en(BRAM_PORTB_OUT_3_en),
        .BRAM_PORTB_OUT_3_rst(BRAM_PORTB_OUT_3_rst),
        .BRAM_PORTB_OUT_3_we(BRAM_PORTB_OUT_3_we),
        .BRAM_PORTB_SEQ_addr(BRAM_PORTB_SEQ_addr),
        .BRAM_PORTB_SEQ_clk(BRAM_PORTB_SEQ_clk),
        .BRAM_PORTB_SEQ_din(BRAM_PORTB_SEQ_din),
        .BRAM_PORTB_SEQ_dout(BRAM_PORTB_SEQ_dout),
        .BRAM_PORTB_SEQ_en(BRAM_PORTB_SEQ_en),
        .BRAM_PORTB_SEQ_rst(BRAM_PORTB_SEQ_rst),
        .BRAM_PORTB_SEQ_we(BRAM_PORTB_SEQ_we),
        .SFR_command(SFR_command),
        .SFR_state(SFR_state),
        .SFR_state_valid(SFR_state_valid),
        .clk(clk),
        .reset(reset),
        .resetn(resetn));
endmodule
