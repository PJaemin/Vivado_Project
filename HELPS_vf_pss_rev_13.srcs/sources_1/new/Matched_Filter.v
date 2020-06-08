`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/10 14:10:28
// Design Name: 
// Module Name: matched_filter
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

`define MATCHED_IDLE 1'd0
`define MATCHED_OP 1'd1

`define SEQUNCE_IDLE 3'd0
`define SEQUENCE_WITH_CHANGE 3'd1
`define SEQUENCE_CHANGE 3'd2
`define SEQUENCE_WITHOUT_CHANGE 3'd3
`define SEQUENCE_WAIT_DONE 3'd4

`define ANTENNA_IDLE 1'b0
`define ANTENNA_LOAD 1'b1

`define PSS_IDLE 2'd0
`define PSS_REFERENCE_TIME_WAIT 2'd1
`define PSS_SEARCH 2'd2

module Matched_Filter # (
    parameter MULTIPLIER_NUM = 16 
    )(
    input clk,
    input resetn,
    input [1:0] pss_state,
    input [1:0] pss_accumulation_num,
    input [1:0] pss_search_mode,
    input pss_search_done,
    input signed [2:0] pss_sum_shift_bit,
    input signed [2:0] pss_pow_shift_bit,
    input signed [11:0] ant_data_i,
    input signed [11:0] ant_data_q,
	input ant_valid,
    input [255:0] seq_data_i,
    input [255:0] seq_data_q,
	input seq_valid,
    output seq_change,
    output [19:0] matched_power,
	output output_valid
    );

    /*------------------------------------- Sequence Load ----------------------------------------*/
    
    reg signed [4:0] seq_reg_i [255:0];
    reg signed [4:0] seq_reg_q [255:0];
    wire signed [4:0] seq_data_i_wire [31:0];
    wire signed [4:0] seq_data_q_wire [31:0];
    genvar val;
    generate
        for (val = 0; val <= 31; val = val + 1) begin
            assign seq_data_i_wire[val] = seq_data_i[8*val+4:8*val];
            assign seq_data_q_wire[val] = seq_data_q[8*val+4:8*val];
        end
    endgenerate
    
	reg [2:0] seq_count;
	always@ (posedge clk or negedge resetn) begin
        if (~resetn) begin
			seq_count <= 3'd0;
        end
        else begin
            if (seq_valid) begin
                if (seq_count == 3'd7)
					seq_count <= 3'd0;
				else
					seq_count <= seq_count + 3'd1;
            end
            else begin
            end
        end
    end
	
    integer i;
    always@ (posedge clk or negedge resetn) begin
        if (~resetn) begin
            for (i = 0; i <= 255; i = i + 1) begin
                seq_reg_i[i] <= 5'b00000;
                seq_reg_q[i] <= 5'b00000;
            end
        end
        else begin
            if (seq_valid) begin
                for (i = 0; i <= 31; i = i + 1) begin
                    seq_reg_i[32*seq_count+i] <= seq_data_i_wire[i];
                    seq_reg_q[32*seq_count+i] <= seq_data_q_wire[i];
                end
            end
            else begin
            end
        end
    end
    
    /*------------------------------------- Sequence Load ----------------------------------------*/
    
    /*------------------------------------- Antenna Load -----------------------------------------*/
    
    reg signed [11:0] shift_reg_i [255:0];
    reg signed [11:0] shift_reg_q [255:0];

    always@ (posedge clk or negedge resetn) begin
        if (~resetn) begin
            for (i = 0; i <= 255; i = i + 1) begin
                shift_reg_i[i] <= 12'b000000000000;
                shift_reg_q[i] <= 12'b000000000000;
            end
        end
        else begin
            if (pss_state == `PSS_SEARCH) begin
                if (ant_valid) begin
                    shift_reg_i[255] <= ant_data_i;
                    shift_reg_q[255] <= ant_data_q;
                    for (i = 0; i <= 254; i = i+1) begin
                        shift_reg_i[255-i-1] <= shift_reg_i[255-i];
                        shift_reg_q[255-i-1] <= shift_reg_q[255-i];
                    end
                end
                else begin
                end
            end
            else begin
            end
        end
    end
	
	/*------------------------------------- Antenna Load -----------------------------------------*/
	
	/*------------------------------------ Sequence Change ---------------------------------------*/
	
	wire [19:0] acc_num = (pss_search_mode == 2'b10) ? 20'd19200 : 20'd38400 <<< pss_accumulation_num;
	wire [19:0] ant_num = (pss_search_mode == 2'b00) ? (20'd115200 <<< pss_accumulation_num) :
					      (pss_search_mode == 2'b10) ? (20'd76800 <<< pss_accumulation_num) :
													   (20'd38400 <<< pss_accumulation_num);
   
	reg [19:0] load_count;
	reg [19:0] count_load;
	always@ (posedge clk or negedge resetn) begin
        if (~resetn) begin
            load_count <= 20'd0;
            count_load <= 20'd0;
        end
		else begin
		    if (pss_state == `PSS_SEARCH) begin
                if (ant_valid) begin
                    if (count_load == acc_num - 20'd1)
                        count_load <= 20'd0;
                    else
                        count_load <= count_load + 20'd1;
                    if (load_count == ant_num - 20'd1)
                        load_count <= 20'd0;
                    else
                        load_count <= load_count + 20'd1;
                end
                else begin  
                end
		    end
		    else begin
		    end
		end
	end
	
    /*------------------------------------ Sequence Change ---------------------------------------*/
    
	/*--------------------------------- Matched Filter State -------------------------------------*/
	
    reg [3:0] idx;
	reg ce_reg_reg;
	reg STATE;
	always@ (posedge clk or negedge resetn) begin
        if (~resetn) begin
			idx <= 4'd0;
			ce_reg_reg <= 1'b0;
			STATE <= 1'b0;
		end
		else begin
			case (STATE)
				`MATCHED_IDLE: begin
					if (pss_state == `PSS_SEARCH) begin
					    if (ant_valid) begin
					       STATE <= `MATCHED_OP;
						   ce_reg_reg <= 1'b1;
					    end
					    else begin
						    STATE <= `MATCHED_IDLE;
						    idx <= 4'd0;
						    ce_reg_reg <= 1'b0;
                        end
                    end
					else begin
						STATE <= `MATCHED_IDLE;
						idx <= 4'd0;
						ce_reg_reg <= 1'b0;
                    end
                end
                `MATCHED_OP: begin
                    if (idx < 4'd15) begin
                        STATE <= `MATCHED_OP;
                        idx <= idx + 4'd1;
						ce_reg_reg <= 1'b1;
                    end
                    else begin
                        if (ant_valid) begin
                            STATE <= `MATCHED_OP;
                            ce_reg_reg <= 1'b1;
                        end
                        else begin
                            STATE <= `MATCHED_IDLE;
                            ce_reg_reg <= 1'b0;
                        end
                        idx <= 4'd0;
                    end
                end
				default: begin
				end
			endcase
		end
	end
	
	/*--------------------------------- Matched Filter State -------------------------------------*/
	
	/*---------------------------------- Matched Filtering ---------------------------------------*/
	
	wire ce = (ce_reg_reg) ? 1'b1 : 1'b0;
	reg ce_reg [8:0];
	always@ (posedge clk or negedge resetn) begin
        if (~resetn) begin
			for (i = 0; i <= 8 ; i = i + 1) begin
				ce_reg[i] <= 1'b0;
			end
        end
        else begin
			ce_reg[0] <= ce;
			for (i = 0; i <= 7 ; i = i + 1) begin
				ce_reg[i+1] <= ce_reg[i];
			end
        end
    end
    
    assign seq_change = ((count_load == acc_num - 20'd1) && (idx == 4'd12) && ce);
    
    reg output_valid_reg[6:0];
    always @ (posedge clk or negedge resetn) begin
        if (!resetn) begin
            for (i = 0; i <= 6; i = i + 1) begin
                output_valid_reg[i] <= 1'b0;
            end
        end
        else begin
            for (i = 0; i <= 5; i = i + 1) begin
                output_valid_reg[i+1] <= output_valid_reg[i];
            end
            if (idx == 4'd15 && ce)
                output_valid_reg[0] <= 1'b1;
            else
                output_valid_reg[0] <= 1'b0;
        end
    end
	
	assign output_valid = output_valid_reg[6];
	
	reg sclr_reg[5:0];
    always @ (posedge clk or negedge resetn) begin
        if (!resetn) begin
            for (i = 0; i <= 5; i = i + 1) begin
                sclr_reg[i] <= 1'b0;
            end
        end
        else begin
            for (i = 0; i <= 4; i = i + 1) begin
                sclr_reg[i+1] <= sclr_reg[i];
            end
            if (idx == 4'd0 && ce)
                sclr_reg[0] <= 1'b1;
            else
                sclr_reg[0] <= 1'b0;
        end
    end
	
	wire sclr = sclr_reg[5];
	
    wire [11:0] shift_reg_i_wire [MULTIPLIER_NUM-1:0];
	wire [11:0] shift_reg_q_wire [MULTIPLIER_NUM-1:0];
	wire [4:0] seq_reg_i_wire [MULTIPLIER_NUM-1:0];
	wire [4:0] seq_reg_q_wire [MULTIPLIER_NUM-1:0];
	
	generate
		for (val = 0; val < MULTIPLIER_NUM; val = val + 1) begin
			assign shift_reg_i_wire[val] = shift_reg_i[255-(idx<<4)-(15-val)];
			assign shift_reg_q_wire[val] = shift_reg_q[255-(idx<<4)-(15-val)];
			assign seq_reg_i_wire[val] = seq_reg_i[255-(idx<<4)-(15-val)];
			assign seq_reg_q_wire[val] = seq_reg_q[255-(idx<<4)-(15-val)];
		end
	endgenerate

    wire signed [15:0] mult_result_i_l [MULTIPLIER_NUM-1:0];
    wire signed [15:0] mult_result_i_r [MULTIPLIER_NUM-1:0];
    wire signed [15:0] mult_result_q_l [MULTIPLIER_NUM-1:0];
    wire signed [15:0] mult_result_q_r [MULTIPLIER_NUM-1:0];
    
    wire signed [16:0] sum_result_i_lr [MULTIPLIER_NUM-1:0]; // L-R sum
    wire signed [16:0] sum_result_q_lr [MULTIPLIER_NUM-1:0];
    
    wire signed [17:0] sum_result_i_128 [MULTIPLIER_NUM/2-1:0];
    wire signed [17:0] sum_result_q_128 [MULTIPLIER_NUM/2-1:0];
    
    wire signed [18:0] sum_result_i_64 [MULTIPLIER_NUM/4-1:0];
    wire signed [18:0] sum_result_q_64 [MULTIPLIER_NUM/4-1:0];
    
    wire signed [19:0] sum_result_i_32 [MULTIPLIER_NUM/8-1:0];
    wire signed [19:0] sum_result_q_32 [MULTIPLIER_NUM/8-1:0];
    
    wire signed [20:0] sum_result_i_16 [MULTIPLIER_NUM/16-1:0];
    wire signed [20:0] sum_result_q_16 [MULTIPLIER_NUM/16-1:0];
    
    wire signed [24:0] sum_result_i_1;
    wire signed [24:0] sum_result_q_1;
    
    wire signed [15:0] sum_result_i_1_reduced;
    wire signed [15:0] sum_result_q_1_reduced;
    
    wire [29:0] matched_output_i;
    wire [29:0] matched_output_q;
    
    wire [18:0] matched_output_i_reduced;
    wire [18:0] matched_output_q_reduced;
    
    generate
        for (val = 0; val < MULTIPLIER_NUM; val = val+1) begin
            mult_s_12_5_16 mult_s_12_5_16_i_l (
                .CLK(clk),
				.CE(ce),
                .A(shift_reg_i_wire[val]),
                .B(seq_reg_i_wire[val]),
                .P(mult_result_i_l[val])
                );
            mult_s_12_5_16 mult_s_12_5_16_i_r (
                .CLK(clk),
				.CE(ce),
                .A(shift_reg_q_wire[val]),
                .B(seq_reg_q_wire[val]),
                .P(mult_result_i_r[val])
                );
            mult_s_12_5_16 mult_s_12_5_16_q_l (
                .CLK(clk),
				.CE(ce),
                .A(shift_reg_i_wire[val]),
                .B(~seq_reg_q_wire[val]+1),
                .P(mult_result_q_l[val])
                );
            mult_s_12_5_16 mult_s_12_5_16_q_r (
                .CLK(clk),
				.CE(ce),
                .A(shift_reg_q_wire[val]),
                .B(seq_reg_i_wire[val]),
                .P(mult_result_q_r[val])
                );
            add_s_16_16_17 add_s_16_16_17_i (
                .CLK(clk),
				.CE(ce_reg[0]),
                .A(mult_result_i_l[val]),
                .B(mult_result_i_r[val]),
                .S(sum_result_i_lr[val])
                );
            add_s_16_16_17 add_s_16_16_17_q (
                .CLK(clk),
				.CE(ce_reg[0]),
                .A(mult_result_q_l[val]),
                .B(mult_result_q_r[val]),
                .S(sum_result_q_lr[val])
                );
        end
        for (val = 0; val < MULTIPLIER_NUM/2; val = val+1) begin
            add_s_17_17_18 add_s_17_17_18_i (
                .CLK(clk),
				.CE(ce_reg[1]),
                .A(sum_result_i_lr[val*2]),
                .B(sum_result_i_lr[val*2+1]),
                .S(sum_result_i_128[val])
                );
            add_s_17_17_18 add_s_17_17_18_q (
                .CLK(clk),
				.CE(ce_reg[1]),
                .A(sum_result_q_lr[val*2]),
                .B(sum_result_q_lr[val*2+1]),
                .S(sum_result_q_128[val])
                );
        end
        for (val = 0; val < MULTIPLIER_NUM/4; val = val+1) begin
            add_s_18_18_19 add_s_18_18_19_i (
                .CLK(clk),
				.CE(ce_reg[2]),
                .A(sum_result_i_128[val*2]),
                .B(sum_result_i_128[val*2+1]),
                .S(sum_result_i_64[val])
                );
            add_s_18_18_19 add_s_18_18_19_q (
                .CLK(clk),
				.CE(ce_reg[2]),
                .A(sum_result_q_128[val*2]),
                .B(sum_result_q_128[val*2+1]),
                .S(sum_result_q_64[val])
                );
        end
        for (val = 0; val < MULTIPLIER_NUM/8; val = val+1) begin
            add_s_19_19_20 add_s_19_19_20_i (
                .CLK(clk),
				.CE(ce_reg[3]),
                .A(sum_result_i_64[val*2]),
                .B(sum_result_i_64[val*2+1]),
                .S(sum_result_i_32[val])
                );
            add_s_19_19_20 add_s_19_19_20_q (
                .CLK(clk),
				.CE(ce_reg[3]),
                .A(sum_result_q_64[val*2]),
                .B(sum_result_q_64[val*2+1]),
                .S(sum_result_q_32[val])
                );
        end
        for (val = 0; val < MULTIPLIER_NUM/16; val = val+1) begin
            add_s_20_20_21 add_s_20_20_21_i (
                .CLK(clk),
				.CE(ce_reg[4]),
                .A(sum_result_i_32[val*2]),
                .B(sum_result_i_32[val*2+1]),
                .S(sum_result_i_16[val])
                );
            add_s_20_20_21 add_s_20_20_21_q (
                .CLK(clk),
				.CE(ce_reg[4]),
                .A(sum_result_q_32[val*2]),
                .B(sum_result_q_32[val*2+1]),
                .S(sum_result_q_16[val])
                );
        end
    endgenerate
        
    reg signed [24:0] sum_result_i_1_reg;
    reg signed [24:0] sum_result_q_1_reg;
    always @ (posedge clk or negedge resetn) begin
        if (!resetn) begin
            sum_result_i_1_reg <= 25'd0;
            sum_result_q_1_reg <= 25'd0;
        end
        else begin
            if (ce_reg[5]) begin
                if (sclr) begin
                    sum_result_i_1_reg <= {{4{sum_result_i_16[0][20]}}, sum_result_i_16[0]};
                    sum_result_q_1_reg <= {{4{sum_result_q_16[0][20]}}, sum_result_q_16[0]};
                end
                else begin
                    sum_result_i_1_reg <= sum_result_i_1_reg + {{4{sum_result_i_16[0][20]}}, sum_result_i_16[0]};
                    sum_result_q_1_reg <= sum_result_q_1_reg + {{4{sum_result_q_16[0][20]}}, sum_result_q_16[0]};
                end
            end
            else begin
            end
        end
    end
    
    assign sum_result_i_1 = sum_result_i_1_reg;
    assign sum_result_q_1 = sum_result_q_1_reg;
        
    /*accum_s_21_25 accum_s_21_25_0 (
		.CLK(clk),
		.CE(ce_reg[5]),
		.SCLR(sclr),
		.B({{4{sum_result_i_16[20]}}, sum_result_i_16[0]}),
		.Q(sum_result_i_1)
		);
		
	accum_s_21_25 accum_s_21_25_1 (
		.CLK(clk),
		.CE(ce_reg[5]),
		.SCLR(sclr),
		.B({{4{sum_result_q_16[20]}}, sum_result_q_16[0]}),
		.Q(sum_result_q_1)
		);*/
	
	wire signed [4:0] sum_shift_bit_ext = {{2{pss_sum_shift_bit[2]}}, pss_sum_shift_bit} <<< 1'b1;
    wire signed [4:0] pow_shift_bit_ext = {{2{pss_pow_shift_bit[2]}}, pss_pow_shift_bit} <<< 1'b1;
		
    shift_s shift_s_0 (
        .dir(1'b1),
        .shift_bit(5'd8 + sum_shift_bit_ext),
        .input_val({{7{sum_result_i_1[24]}}, sum_result_i_1}),
        .output_bit(5'd16),
        .output_val(sum_result_i_1_reduced)
        );
        
    shift_s shift_s_1 (
        .dir(1'b1),
        .shift_bit(5'd8 + sum_shift_bit_ext),
        .input_val({{7{sum_result_q_1[24]}}, sum_result_q_1}),
        .output_bit(5'd16),
        .output_val(sum_result_q_1_reduced)
        );
        
    mult_s_16_16_30 mult_s_16_16_30_i (
        .CLK(clk),
		.CE(ce_reg[6]),
        .A(sum_result_i_1_reduced),
        .B(sum_result_i_1_reduced),
        .P(matched_output_i)
        );
    mult_s_16_16_30 mult_s_16_16_30_q (
        .CLK(clk),
		.CE(ce_reg[6]),
        .A(sum_result_q_1_reduced),
        .B(sum_result_q_1_reduced),
        .P(matched_output_q)
        );
        
    shift_u shift_u_0 (
        .dir(1'b1),
        .shift_bit(5'd10 + pow_shift_bit_ext),
        .input_val({{2{matched_output_i[29]}}, matched_output_i}),
        .output_bit(5'd19),
        .output_val(matched_output_i_reduced)
        );
    
    shift_u shift_u_1 (
        .dir(1'b1),
        .shift_bit(5'd10 + pow_shift_bit_ext),
        .input_val({{2{matched_output_q[29]}}, matched_output_q}),
        .output_bit(5'd19),
        .output_val(matched_output_q_reduced)
        );
        
    add_u_19_19_20 add_u_19_19_20_0 (
        .CLK(clk),
		.CE(ce_reg[7]),
        .A(matched_output_i_reduced),
        .B(matched_output_q_reduced),
        .S(matched_power)
        );
    
    /*---------------------------------- Matched Filtering ---------------------------------------*/
    
endmodule
