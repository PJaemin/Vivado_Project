`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/25 13:33:26
// Design Name: 
// Module Name: pss_timer
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

`define TIMER_IDLE 1'b0
`define TIMER_GO 1'b1

`define PSS_IDLE 2'd0
`define PSS_REFERENCE_TIME_WAIT 2'd1
`define PSS_SEARCH 2'd2

module PSS_Timer(
    input clk,
    input resetn,
    input [1:0] pss_state,
    output pss_ref_time
    );
    
    reg [31:0] count;
    
    assign pss_ref_time = (count == 32'h00000fff) ? 1'b1 : 1'b0;
    
    reg STATE;
    
    always@ (posedge clk or negedge resetn) begin
        if (~resetn) begin
            count <= 32'd0;
            STATE <= `TIMER_IDLE;
        end
        else begin
            case (STATE)
                `TIMER_IDLE: begin
                    if (pss_state == `PSS_REFERENCE_TIME_WAIT) begin
                        STATE <= `TIMER_GO;
                    end
                    else begin
                        STATE <= `TIMER_IDLE;
                    end
                end
                `TIMER_GO: begin
                    if (count == 32'h00000fff) begin
						STATE <= `TIMER_IDLE;
                        count <= 32'd0;
                    end
                    else begin
						STATE <= `TIMER_GO;
                        count <= count + 32'd1;
                    end
                end
				default: begin
				end
            endcase
        end
    end
    
endmodule
