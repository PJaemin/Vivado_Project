`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/25 02:53:22
// Design Name: 
// Module Name: pss_fsm
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

`define PSS_IDLE 2'd0
`define PSS_REFERENCE_TIME_WAIT 2'd1
`define PSS_SEARCH 2'd2

module PSS_FSM(
    input clk,
    input resetn,
    
    input pss_search_start,
    input pss_ref_time,
    input pss_search_done,
    
    output [1:0] pss_state
    );
    
    reg [1:0] STATE;
    assign pss_state = STATE;
    
    always@(posedge clk or negedge resetn) begin
        if(~resetn) begin
            STATE <= `PSS_IDLE;
        end
        else begin
            case(STATE)
                `PSS_IDLE: begin
                    if (pss_search_start)
                        STATE <= `PSS_REFERENCE_TIME_WAIT;
                    else
                        STATE <= `PSS_IDLE;
                end
                `PSS_REFERENCE_TIME_WAIT: begin
                    if (pss_ref_time)
                        STATE <= `PSS_SEARCH;
                    else
                        STATE <= `PSS_REFERENCE_TIME_WAIT;
                end
                `PSS_SEARCH: begin
                    if (pss_search_done)
                        STATE <= `PSS_IDLE;
                    else
                        STATE <= `PSS_SEARCH;
                end
                default: begin
                end
            endcase
        end
    end
    
endmodule
