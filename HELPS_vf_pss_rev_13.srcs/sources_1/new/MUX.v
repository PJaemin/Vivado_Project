`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/30 02:40:23
// Design Name: 
// Module Name: mux
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


module MUX (
    input clk,
    input resetn,
    input [1:0] buf_sel,
    input check,
    input enb_1,
    input [14:0] addrb_1,
	input enb_2,
    input [14:0] addrb_2,
	input enb_3,
    input [14:0] addrb_3,
    output enb_1_tmp,
    output [14:0] addrb_1_tmp,
    output enb_2_tmp,
    output [14:0] addrb_2_tmp,
    output enb_3_tmp,
    output [14:0] addrb_3_tmp
    );
    
    reg enb_reg;
    assign enb_1_tmp = (check) ? enb_reg : enb_1;
    assign enb_2_tmp = (check) ? enb_reg : enb_2;
    assign enb_3_tmp = (check) ? enb_reg : enb_3;
    
    reg [14:0] addrb_reg;
    assign addrb_1_tmp = (check) ? addrb_reg : addrb_1;
    assign addrb_2_tmp = (check) ? addrb_reg : addrb_2;
    assign addrb_3_tmp = (check) ? addrb_reg : addrb_3;
    
    reg [14:0] idx;
    always@ (posedge clk or negedge resetn) begin
        if (~resetn) begin
            enb_reg <= 1'b0;
            addrb_reg <= 15'd0;
            idx <= 15'd0;
        end
        else begin
            if (check) begin
                enb_reg <= 1'b1;
                addrb_reg <= idx;
                if (idx < 15'd19199)
                    idx <= idx + 15'd1;
                else
                    idx <= 15'd0;
            end
            else begin
                enb_reg <= 1'b0;
                addrb_reg <= 15'd0;
                idx <= 15'd0;
            end
        end
    end
    
endmodule
