`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/17 15:29:28
// Design Name: 
// Module Name: SFR_decoder
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


module SFR_Decoder (
    input clk,
    input resetn,
    input [63:0] SFR_command,
    output [63:0] SFR_state,
    output SFR_state_valid,
    output pss_search_start,
    output [1:0] pss_accumulation_num,
    output [1:0] pss_search_mode,
    output [2:0] pss_sequence_select,
    output [1:0] pss_antenna_combining,
    output pss_output_mode,
    output signed [2:0] pss_sum_shift_bit,
    output signed [2:0] pss_pow_shift_bit,
    output signed [2:0] pss_div_shift_bit,
    output [43:0] pss_output_thres,
    input pss_search_done,
    input [1:0] pss_state
    );
    
    /*--------------------------------------- SFR Access -----------------------------------------*/
    
                //SFR <= 64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_000_000_000_0_11_001_01_10_1;     // 10
                //SFR <= 64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_110_111_001_0_11_000_10_01_1;   // 9
                //SFR <= 64'b0000_0000_0000_0000_0000_0000_0000_0001_0011_1000_1000_000_000_000_1_11_000_10_01_1;   // 8
                //SFR <= 64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_000_000_000_0_01_000_10_01_1;   // 7
                //SFR <= 64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_000_000_000_0_11_000_10_00_1;   // 6
                //SFR <= 64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_000_000_000_0_11_000_10_01_1;   // 5
                //SFR <= 64'b0000_0000_0000_0000_0000_0000_0000_0000_1011_1011_1000_001_001_111_1_11_000_01_11_1;   // 4
                //SFR <= 64'b0000_0000_0000_0000_0000_0000_0000_0000_0011_1110_1000_111_111_001_1_01_000_00_10_1;   // 3
                //SFR <= 64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_000_000_000_0_10_000_00_01_1;   // 2
                //SFR <= 64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_000_000_000_0_11_000_00_00_1;   // 1
                
    reg [1:0] pss_state_reg;
    always @ (posedge clk or negedge resetn) begin
        if (!resetn) begin
            pss_state_reg <= 2'd0;
        end
        else begin
            pss_state_reg <= pss_state;
        end
    end
                
    assign SFR_state_valid = ((pss_state != pss_state_reg) || pss_search_done) ? 1'b1 : 1'b0;
    assign SFR_state = ({62'd0, pss_state} << 1) + {63'd0, pss_search_done};
    
    assign pss_search_start = SFR_command[0];
    assign pss_accumulation_num = SFR_command[2:1];
    assign pss_search_mode = SFR_command[4:3];
    assign pss_sequence_select = SFR_command[7:5];
    assign pss_antenna_combining = SFR_command[9:8];
    assign pss_output_mode = SFR_command[10];
    assign pss_sum_shift_bit = SFR_command[13:11];
    assign pss_pow_shift_bit = SFR_command[16:14];
    assign pss_div_shift_bit = SFR_command[19:17];
    assign pss_output_thres = SFR_command[63:20];
        
    /*--------------------------------------- SFR Access -----------------------------------------*/
    
endmodule
