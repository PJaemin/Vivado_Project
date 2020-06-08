`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/29 17:28:56
// Design Name: 
// Module Name: shift
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


module shift_s(
    //input clk,
    //input resetn,
    input dir,                          // 0 : left, 1 : right
    input [4:0] shift_bit,
    //input [5:0] input_bit,
    input signed [31:0] input_val,
    input [4:0] output_bit,
    output signed [31:0] output_val
    );
    
    wire signed [31:0] shifted_val;
    assign shifted_val = (dir == 0) ? (input_val <<< shift_bit) : (input_val >>> shift_bit);
    wire signed [31:0] thres_val;
    assign thres_val = (input_val[31] == 0) ? (32'b1 <<< (output_bit - 5'd1)) - 32'b1 : 32'hffffffff <<< (output_bit - 5'd1);
    assign output_val = (input_val[31] == 0) ? (shifted_val >= thres_val) ? thres_val : shifted_val : (shifted_val <= thres_val) ? thres_val + 32'd1 : shifted_val;
        
endmodule
