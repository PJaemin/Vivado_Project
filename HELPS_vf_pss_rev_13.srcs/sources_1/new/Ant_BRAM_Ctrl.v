`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/17 15:29:28
// Design Name: 
// Module Name: ant_BRAM_ctrl
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

`define ANTENNA_IDLE 1'b0
`define ANTENNA_LOAD 1'b1

`define PSS_IDLE 2'd0
`define PSS_REFERENCE_TIME_WAIT 2'd1
`define PSS_SEARCH 2'd2

module Ant_BRAM_Ctrl(
    /* Clock & Reset */
    input clk,
    input resetn,
    /* Control Signals */
    input [1:0] pss_state,
    input [1:0] pss_accumulation_num,
    input [1:0] pss_search_mode,
    /* Output Data */
    output signed [11:0] ant_data_i_1,
    output signed [11:0] ant_data_q_1,
    output signed [11:0] ant_data_i_2,
    output signed [11:0] ant_data_q_2,
	output ant_valid
    );

    wire [19:0] ant_num = (pss_search_mode == 2'b00) ? (20'd115200 <<< pss_accumulation_num) :
					      (pss_search_mode == 2'b10) ? (20'd76800 <<< pss_accumulation_num) :
													   (20'd38400 <<< pss_accumulation_num);
    
    reg ena_reg;
    reg [16:0] addra_reg;
    reg enb_reg;
    reg [16:0] addrb_reg;
    
    reg STATE;
    reg [16:0] sample_idx;
    reg [19:0] load_count;
    reg [5:0] count;
    
    reg ant_valid_reg[1:0];
    assign ant_valid = ant_valid_reg[1];

    always@ (posedge clk or negedge resetn) begin
        if (~resetn) begin
            ena_reg <= 1'b0;
            addra_reg <= 17'd0;
            enb_reg <= 1'b0;
            addrb_reg <= 17'd0;
        
            STATE <= `ANTENNA_IDLE;
            sample_idx <= 17'd0;
            load_count <= 20'd0;
            count <= 6'd1;
            
            ant_valid_reg[0] <= 1'b0;
			ant_valid_reg[1] <= 1'b0;
        end
        else begin
			ant_valid_reg[1] <= ant_valid_reg[0];
            case (STATE)
                `ANTENNA_IDLE: begin
                    ena_reg <= 1'b0;
                    enb_reg <= 1'b0;
                    count <= 6'd1;
                    ant_valid_reg[0] <= 1'b0;
                    if (pss_state == `PSS_SEARCH)
                        STATE <= `ANTENNA_LOAD;
                    else
                        STATE <= `ANTENNA_IDLE;
                end
                `ANTENNA_LOAD: begin
                    if (count == 6'd29) begin
                        ena_reg <= 1'b1;
                        enb_reg <= 1'b1;
                        addra_reg <= sample_idx;
                        addrb_reg <= 17'd38400 + sample_idx;
                        count <= 6'd1;
                        ant_valid_reg[0] <= 1'b1;
                        if (load_count == ant_num - 20'd1) begin
							STATE <= `ANTENNA_IDLE;
							sample_idx <= 17'd0;
							load_count <= 20'd0;
						end
                        else begin
							STATE <= `ANTENNA_LOAD;
                            load_count <= load_count + 20'd1;
							if (sample_idx == 17'd38399) begin
								sample_idx <= 17'd0;
							end
							else begin
								sample_idx <= sample_idx + 17'd1;
							end
                        end
                    end
                    else begin
                        count <= count + 6'd1;
						ena_reg <= 1'b0;
						enb_reg <= 1'b0;
						ant_valid_reg[0] <= 1'b0;
					end
                end
				default: begin
				end
            endcase
        end
    end
       
    wire ena = ena_reg;
    wire [16:0] addra = addra_reg;
    wire enb = enb_reg;
    wire [16:0] addrb = addrb_reg;
    wire [11:0] douta_1;
    wire [11:0] doutb_1;
    wire [11:0] douta_2;
    wire [11:0] doutb_2;
    assign ant_data_i_1 = douta_1;
    assign ant_data_q_1 = doutb_1;
    assign ant_data_i_2 = douta_2;
    assign ant_data_q_2 = doutb_2;

    Ant_BRAM_1 Ant_BRAM_1_0 (
        .clka(clk),    // input wire clka
        .ena(ena),      // input wire ena
        .wea(0),      // input wire [0 : 0] wea
        .addra(addra),  // input wire [16 : 0] addra
        .dina(0),    // input wire [11 : 0] dina
        .douta(douta_1),  // output wire [11 : 0] douta
        .clkb(clk),    // input wire clkb
        .enb(enb),      // input wire enb
        .web(0),      // input wire [0 : 0] web
        .addrb(addrb),  // input wire [16 : 0] addrb
        .dinb(0),    // input wire [11 : 0] dinb
        .doutb(doutb_1)  // output wire [11 : 0] doutb
        );
        
    Ant_BRAM_2 Ant_BRAM_2_0 (
        .clka(clk),    // input wire clka
        .ena(ena),      // input wire ena
        .wea(0),      // input wire [0 : 0] wea
        .addra(addra),  // input wire [16 : 0] addra
        .dina(0),    // input wire [11 : 0] dina
        .douta(douta_2),  // output wire [11 : 0] douta
        .clkb(clk),    // input wire clkb
        .enb(enb),      // input wire enb
        .web(0),      // input wire [0 : 0] web
        .addrb(addrb),  // input wire [16 : 0] addrb
        .dinb(0),    // input wire [11 : 0] dinb
        .doutb(doutb_2)  // output wire [11 : 0] doutb
        );
    
endmodule
