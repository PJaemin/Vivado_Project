`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/24 17:06:23
// Design Name: 
// Module Name: pss_searcher
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PSS_Searcher (
    clk,
    resetn,
    pss_search_start,
    pss_accumulation_num,
    pss_search_mode,
    pss_sequence_select,
    pss_antenna_combining,
    pss_output_mode,
    pss_sum_shift_bit,
    pss_pow_shift_bit,
    pss_div_shift_bit,
    pss_output_thres,
    pss_search_done,
    pss_state_output,
    /* DL data */
    dl_i_1,
    dl_q_1,
    dl_valid_1,
    dl_i_2,
    dl_q_2,
    dl_valid_2,
    BRAM_PORTA_OUT_1_addr,
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
    BRAM_PORTB_SEQ_we
    );
    
	input clk;
    input resetn;
    input pss_search_start;
    input [1:0] pss_accumulation_num;
    input [1:0] pss_search_mode;
    input [2:0] pss_sequence_select;
    input [1:0] pss_antenna_combining;
    input pss_output_mode;
    input signed [2:0] pss_sum_shift_bit;
    input signed [2:0] pss_pow_shift_bit;
    input signed [2:0] pss_div_shift_bit;
    input [43:0] pss_output_thres;
    output pss_search_done;
    output [1:0] pss_state_output;
    
    /* DL data */
    input signed [11:0] dl_i_1;
    input signed [11:0] dl_q_1;
    input dl_valid_1;
    input signed [11:0] dl_i_2;
    input signed [11:0] dl_q_2;
    input dl_valid_2;
	
    input [16:0]BRAM_PORTA_OUT_1_addr;
    input BRAM_PORTA_OUT_1_clk;
    input [31:0]BRAM_PORTA_OUT_1_din;
    output [31:0]BRAM_PORTA_OUT_1_dout;
    input BRAM_PORTA_OUT_1_en;
    input BRAM_PORTA_OUT_1_rst;
    input [3:0]BRAM_PORTA_OUT_1_we;
    input [16:0]BRAM_PORTA_OUT_2_addr;
    input BRAM_PORTA_OUT_2_clk;
    input [31:0]BRAM_PORTA_OUT_2_din;
    output [31:0]BRAM_PORTA_OUT_2_dout;
    input BRAM_PORTA_OUT_2_en;
    input BRAM_PORTA_OUT_2_rst;
    input [3:0]BRAM_PORTA_OUT_2_we;
    input [16:0]BRAM_PORTA_OUT_3_addr;
    input BRAM_PORTA_OUT_3_clk;
    input [31:0]BRAM_PORTA_OUT_3_din;
    output [31:0]BRAM_PORTA_OUT_3_dout;
    input BRAM_PORTA_OUT_3_en;
    input BRAM_PORTA_OUT_3_rst;
    input [3:0]BRAM_PORTA_OUT_3_we;
    input [11:0]BRAM_PORTA_SEQ_addr;
    input BRAM_PORTA_SEQ_clk;
    input [31:0]BRAM_PORTA_SEQ_din;
    output [31:0]BRAM_PORTA_SEQ_dout;
    input BRAM_PORTA_SEQ_en;
    input BRAM_PORTA_SEQ_rst;
    input [3:0]BRAM_PORTA_SEQ_we;
    input [16:0]BRAM_PORTB_OUT_1_addr;
    input BRAM_PORTB_OUT_1_clk;
    input [31:0]BRAM_PORTB_OUT_1_din;
    output [31:0]BRAM_PORTB_OUT_1_dout;
    input BRAM_PORTB_OUT_1_en;
    input BRAM_PORTB_OUT_1_rst;
    input [3:0]BRAM_PORTB_OUT_1_we;
    input [16:0]BRAM_PORTB_OUT_2_addr;
    input BRAM_PORTB_OUT_2_clk;
    input [31:0]BRAM_PORTB_OUT_2_din;
    output [31:0]BRAM_PORTB_OUT_2_dout;
    input BRAM_PORTB_OUT_2_en;
    input BRAM_PORTB_OUT_2_rst;
    input [3:0]BRAM_PORTB_OUT_2_we;
    input [16:0]BRAM_PORTB_OUT_3_addr;
    input BRAM_PORTB_OUT_3_clk;
    input [31:0]BRAM_PORTB_OUT_3_din;
    output [31:0]BRAM_PORTB_OUT_3_dout;
    input BRAM_PORTB_OUT_3_en;
    input BRAM_PORTB_OUT_3_rst;
    input [3:0]BRAM_PORTB_OUT_3_we;
    input [11:0]BRAM_PORTB_SEQ_addr;
    input BRAM_PORTB_SEQ_clk;
    input [31:0]BRAM_PORTB_SEQ_din;
    output [31:0]BRAM_PORTB_SEQ_dout;
    input BRAM_PORTB_SEQ_en;
    input BRAM_PORTB_SEQ_rst;
    input [3:0]BRAM_PORTB_SEQ_we;
	
	wire clk;
    wire resetn;
    wire pss_search_start;
    wire [1:0] pss_accumulation_num;
    wire [1:0] pss_search_mode;
    wire [2:0] pss_sequence_select;
    wire [1:0] pss_antenna_combining;
    wire pss_output_mode;
    wire signed [2:0] pss_sum_shift_bit;
    wire signed [2:0] pss_pow_shift_bit;
    wire signed [2:0] pss_div_shift_bit;
    wire[43:0] pss_output_thres;
    wire pss_search_done;
    wire [1:0] pss_state_output;

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

    /*---------------------------------------- PSS FSM -------------------------------------------*/
    
    wire pss_ref_time;
    wire pss_search_done_wire;
    assign pss_search_done = pss_search_done_wire;
    wire [1:0] pss_state;
    assign pss_state_output = pss_state;
    
    PSS_FSM PSS_FSM_0 (
        .clk(clk),
        .resetn(resetn),
        
        .pss_search_start(pss_search_start),
        .pss_ref_time(pss_ref_time),
        .pss_search_done(pss_search_done_wire),
        
        .pss_state(pss_state)
        );
    
    /*---------------------------------------- PSS FSM -------------------------------------------*/
    
    /*--------------------------------------- PSS Timer ------------------------------------------*/
    
    PSS_Timer PSS_Timer_0 (
        .clk(clk),
        .resetn(resetn),
        .pss_state(pss_state),
        .pss_ref_time(pss_ref_time)
        );
        
    /*----------------------------------------PSS Timer ------------------------------------------*/
    
    /*----------------------------------- Antenna Data Load --------------------------------------*/
    
    /*wire signed [11:0] ant_data_i_1;
    wire signed [11:0] ant_data_q_1;
    wire signed [11:0] ant_data_i_2;
    wire signed [11:0] ant_data_q_2;
    wire ant_valid;
    
    Ant_BRAM_Ctrl Ant_BRAM_Ctrl_0 (
        .clk(clk),
        .resetn(resetn),
        .pss_state(pss_state),
        .pss_accumulation_num(pss_accumulation_num),
        .pss_search_mode(pss_search_mode),
        .ant_data_i_1(ant_data_i_1),
        .ant_data_q_1(ant_data_q_1),
        .ant_data_i_2(ant_data_i_2),
        .ant_data_q_2(ant_data_q_2),
		.ant_valid(ant_valid)
        );*/
    
    /*----------------------------------- Antenna Data Load --------------------------------------*/
    
    /*------------------------------------- Sequence Load ----------------------------------------*/
    
    wire [255:0] seq_data_i;
    wire [255:0] seq_data_q;
    wire seq_change_1;
    wire seq_change_2;
    wire seq_change = (pss_antenna_combining == 2'b11) ? seq_change_1 & seq_change_2 :
					  (pss_antenna_combining == 2'b10) ? seq_change_1 :
														 seq_change_2;
    wire seq_valid;
    
    Seq_BRAM_Ctrl Seq_BRAM_Ctrl_0 (
        .clk(clk),
        .resetn(resetn),
        .pss_search_start(pss_search_start),
        .pss_accumulation_num(pss_accumulation_num),
        .pss_search_mode(pss_search_mode),
        .pss_sequence_select(pss_sequence_select),
        .seq_change(seq_change),
        .pss_search_done(pss_search_done_wire),
        .seq_data_i(seq_data_i),
        .seq_data_q(seq_data_q),
		.seq_valid(seq_valid),
		.BRAM_PORTA_SEQ_addr(BRAM_PORTA_SEQ_addr),
        .BRAM_PORTA_SEQ_clk(BRAM_PORTA_SEQ_clk),
        .BRAM_PORTA_SEQ_din(BRAM_PORTA_SEQ_din),
        .BRAM_PORTA_SEQ_dout(BRAM_PORTA_SEQ_dout),
        .BRAM_PORTA_SEQ_en(BRAM_PORTA_SEQ_en),
        .BRAM_PORTA_SEQ_rst(BRAM_PORTA_SEQ_rst),
        .BRAM_PORTA_SEQ_we(BRAM_PORTA_SEQ_we),
        .BRAM_PORTB_SEQ_addr(BRAM_PORTB_SEQ_addr),
        .BRAM_PORTB_SEQ_clk(BRAM_PORTB_SEQ_clk),
        .BRAM_PORTB_SEQ_din(BRAM_PORTB_SEQ_din),
        .BRAM_PORTB_SEQ_dout(BRAM_PORTB_SEQ_dout),
        .BRAM_PORTB_SEQ_en(BRAM_PORTB_SEQ_en),
        .BRAM_PORTB_SEQ_rst(BRAM_PORTB_SEQ_rst),
        .BRAM_PORTB_SEQ_we(BRAM_PORTB_SEQ_we)
        );
        
    /*------------------------------------- Sequence Load ----------------------------------------*/
    
    /*------------------------------------ Matched Filter ----------------------------------------*/

    wire [19:0] matched_power_1;
    wire [19:0] matched_power_2;
    wire output_valid_1;
    wire output_valid_2;
    wire output_valid = (pss_antenna_combining == 2'b11) ? output_valid_1 & output_valid_2 :
						(pss_antenna_combining == 2'b10) ? output_valid_1 :
														   output_valid_2;
    
    Matched_Filter Matched_Filter_1 (
        .clk(clk),
        .resetn(resetn),
        .pss_state(pss_state),
        .pss_accumulation_num(pss_accumulation_num),
        .pss_search_mode(pss_search_mode),
        .pss_search_done(pss_search_done_wire),
        .pss_sum_shift_bit(pss_sum_shift_bit),
        .pss_pow_shift_bit(pss_pow_shift_bit),
        .ant_data_i(dl_i_1),
        .ant_data_q(dl_q_1),
		.ant_valid(dl_valid_1),
        .seq_data_i(seq_data_i),
        .seq_data_q(seq_data_q),
		.seq_valid(seq_valid),
        .seq_change(seq_change_1),
        .matched_power(matched_power_1),
		.output_valid(output_valid_1)
        );
        
    Matched_Filter Matched_Filter_2 (
        .clk(clk),
        .resetn(resetn),
        .pss_state(pss_state),
        .pss_accumulation_num(pss_accumulation_num),
        .pss_search_mode(pss_search_mode),
        .pss_search_done(pss_search_done_wire),
        .pss_sum_shift_bit(pss_sum_shift_bit),
        .pss_pow_shift_bit(pss_pow_shift_bit),
        .ant_data_i(dl_i_2),
        .ant_data_q(dl_q_2),
		.ant_valid(dl_valid_2),
        .seq_data_i(seq_data_i),
        .seq_data_q(seq_data_q),
		.seq_valid(seq_valid),
        .seq_change(seq_change_2),
        .matched_power(matched_power_2),
		.output_valid(output_valid_2)
        );
        
    /*------------------------------------ Matched Filter ----------------------------------------*/
    
    /*------------------------------------- Output Store -----------------------------------------*/
    
    wire dma_start;

    Out_BRAM_Ctrl Out_BRAM_Ctrl_0 (
        .clk(clk),
        .resetn(resetn),
        .pss_search_start(pss_search_start),
        .pss_accumulation_num(pss_accumulation_num),
        .pss_search_mode(pss_search_mode),
        .pss_antenna_combining(pss_antenna_combining),
        .pss_div_shift_bit(pss_div_shift_bit),
        .pss_output_mode(pss_output_mode),
        .pss_output_thres(pss_output_thres),
        .matched_power_1(matched_power_1),
        .matched_power_2(matched_power_2),
		.output_valid(output_valid),
        .dma_start(dma_start),
        .pss_search_done(pss_search_done_wire),
        .BRAM_PORTA_OUT_1_addr(BRAM_PORTA_OUT_1_addr),
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
        .BRAM_PORTB_OUT_3_we(BRAM_PORTB_OUT_3_we)
        );
    
    /*------------------------------------- Output Store -----------------------------------------*/
    
endmodule
