`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/17 15:29:28
// Design Name: 
// Module Name: seq_BRAM_ctrl
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

`define SEQUNCE_IDLE 3'd0
`define SEQUENCE_WITH_CHANGE 3'd1
`define SEQUENCE_CHANGE 3'd2
`define SEQUENCE_WITHOUT_CHANGE 3'd3
`define SEQUENCE_WAIT_DONE 3'd4

module Seq_BRAM_Ctrl(
    /* Clock & Reset */
    input clk,
    input resetn,
    /* Control Signals */
    input pss_search_start,
    input [1:0] pss_accumulation_num,
    input [1:0] pss_search_mode,
    input [2:0] pss_sequence_select,
    input seq_change,
    input pss_search_done,
    /* Output Data */
    output [255:0] seq_data_i,
    output [255:0] seq_data_q,
	output seq_valid,
	input [11:0]BRAM_PORTA_SEQ_addr,
	input BRAM_PORTA_SEQ_clk,
    input [31:0]BRAM_PORTA_SEQ_din,
    output [31:0]BRAM_PORTA_SEQ_dout,
    input BRAM_PORTA_SEQ_en,
    input BRAM_PORTA_SEQ_rst,
    input [3:0]BRAM_PORTA_SEQ_we,
	input [11:0]BRAM_PORTB_SEQ_addr,
	input BRAM_PORTB_SEQ_clk,
    input [31:0]BRAM_PORTB_SEQ_din,
    output [31:0]BRAM_PORTB_SEQ_dout,
    input BRAM_PORTB_SEQ_en,
    input BRAM_PORTB_SEQ_rst,
    input [3:0]BRAM_PORTB_SEQ_we
    );
    
    wire [5:0] accumulation_num = 6'b0010 <<< pss_accumulation_num;
    
    /*-------------------------------------- Index Setup -----------------------------------------*/
    
    wire [2:0] start_seq;
    wire [2:0] end_seq;
    wire [1:0] seq_idx;
    
    assign start_seq = (pss_search_mode == 2'b00) ? 3'd0 :
                       (pss_search_mode == 2'b10) ? 3'd3 :
													3'd0;
    assign end_seq = (pss_search_mode == 2'b00) ? 3'd2 : 3'd0;
    assign seq_idx = (pss_search_mode == 2'b01) ? pss_sequence_select[1:0] : 2'd0;
    
    /*-------------------------------------- Index Setup -----------------------------------------*/
    
    reg ena_reg;
    reg [6:0] addra_reg;
    reg enb_reg;
    reg [6:0] addrb_reg;
    
    reg [2:0] STATE;
    reg [6:0] seq;
    reg [5:0] accumulation_count;
	reg [2:0] count;
	
	reg seq_valid_reg[1:0];
	assign seq_valid = seq_valid_reg[1];
    
    always@ (posedge clk or negedge resetn) begin
        if (~resetn) begin
            ena_reg <= 1'b0;
            addra_reg <= 7'd0;
            enb_reg <= 1'b0;
            addrb_reg <= 7'd0;
        
            STATE <= `SEQUNCE_IDLE;
            seq <= 7'd0;
            accumulation_count <= 6'd0;
			count <= 3'd0;
			
			seq_valid_reg[0] <= 1'b0;
			seq_valid_reg[1] <= 1'b0;
        end
        else begin
			seq_valid_reg[1] <= seq_valid_reg[0];
            case (STATE)
                `SEQUNCE_IDLE: begin
                    ena_reg <= 1'b0;
                    enb_reg <= 1'b0;
					count <= 3'd0;
					seq_valid_reg[0] <= 1'b0;
                    if (pss_search_start) begin
                        if (pss_search_mode != 2'b01) begin
                            STATE <= `SEQUENCE_WITH_CHANGE;
                            seq <= start_seq;
                        end
                        else begin
                            STATE <= `SEQUENCE_WITHOUT_CHANGE;
                            seq <= seq_idx;
                        end
                    end
                    else begin
                        STATE <= `SEQUNCE_IDLE;
                    end
                end
                `SEQUENCE_WITH_CHANGE: begin
                    ena_reg <= 1'b1;
                    addra_reg <= (seq << 4) + count;
                    enb_reg <= 1'b1;
                    addrb_reg <= (seq << 4) + 7'd8 + count;
					seq_valid_reg[0] <= 1'b1;
					if (count == 3'd7) begin
						count <= 3'd0;
						case (pss_search_mode)
							2'b00: begin
								if (seq == end_seq)
									STATE <= `SEQUENCE_WAIT_DONE;
								else
									STATE <= `SEQUENCE_CHANGE;
							end
							2'b10: begin
								if (accumulation_count == (accumulation_num << 6'd1)  - 6'd1)
									STATE <= `SEQUENCE_WAIT_DONE;
								else
									STATE <= `SEQUENCE_CHANGE;
							end
							default: begin
							end
						endcase
					end
					else begin
						count <= count + 3'd1;
						STATE <= `SEQUENCE_WITH_CHANGE;
					end
                end
                `SEQUENCE_CHANGE: begin
                    ena_reg <= 1'b0;
                    enb_reg <= 1'b0;
					seq_valid_reg[0] <= 1'b0;
					count <= 3'd0;
                    if (seq_change) begin
                        case (pss_search_mode)
                            2'b00: begin
                                seq <= seq + 7'd1;
                            end
                            2'b10: begin
                                accumulation_count <= accumulation_count + 6'd1;
                                if (accumulation_count != accumulation_num - 6'd1)
                                    seq <= seq ^ 7'b0000111;
                                else
                                    seq <= seq;
                            end
                            default: begin
                            end
                        endcase
                        STATE <= `SEQUENCE_WITH_CHANGE;
                    end
                    else begin
                        STATE <= `SEQUENCE_CHANGE;
                    end
                end
                `SEQUENCE_WITHOUT_CHANGE: begin
                    ena_reg <= 1'b1;
                    addra_reg <= (seq << 4) + count;
                    enb_reg <= 1'b1;
                    addrb_reg <= (seq << 4) + 7'd8 + count;
					seq_valid_reg[0] <= 1'b1;
					if (count == 3'd7) begin
						count <= 3'd0;
						STATE <= `SEQUENCE_WAIT_DONE;
					end
					else begin
						count <= count + 3'd1;
						STATE <= `SEQUENCE_WITH_CHANGE;
					end
                end
                `SEQUENCE_WAIT_DONE: begin
                    ena_reg <= 1'b0;
                    enb_reg <= 1'b0;
                    accumulation_count <= 6'd0;
					seq_valid_reg[0] <= 1'b0;
					count <= 3'd0;
                    if (pss_search_done)
                        STATE <= `SEQUNCE_IDLE;
                    else
                        STATE <= `SEQUENCE_WAIT_DONE;
                end
                default:begin
                end
            endcase
        end
    end
    
    /*--------------------------------- Access Sequence BRAM -------------------------------------*/
	
	wire [255:0] douta;
	wire [255:0] doutb;
	
	reg BRAM_PORTA_SEQ_en_reg;
	reg [3:0] BRAM_PORTA_SEQ_we_reg;
	reg [11:0] BRAM_PORTA_SEQ_addr_reg;
	reg [31:0] BRAM_PORTA_SEQ_din_reg;
	reg BRAM_PORTA_SEQ_time;
	reg BRAM_PORTB_SEQ_en_reg;
	reg [3:0] BRAM_PORTB_SEQ_we_reg;
	reg [11:0] BRAM_PORTB_SEQ_addr_reg;
	reg [31:0] BRAM_PORTB_SEQ_din_reg;
	reg BRAM_PORTB_SEQ_time;
	
	always @ (posedge clk or negedge resetn) begin
		if (!resetn) begin
			BRAM_PORTA_SEQ_addr_reg <= 12'd0;
			BRAM_PORTA_SEQ_din_reg <= 32'd0;
			BRAM_PORTA_SEQ_en_reg <= 1'b0;
			BRAM_PORTA_SEQ_we_reg <= 4'd0;
			BRAM_PORTA_SEQ_time <= 1'b0;
			BRAM_PORTB_SEQ_addr_reg <= 12'd0;
			BRAM_PORTB_SEQ_din_reg <= 32'd0;
			BRAM_PORTB_SEQ_en_reg <= 1'b0;
			BRAM_PORTB_SEQ_we_reg <= 4'd0;
			BRAM_PORTB_SEQ_time <= 1'b0;
		end
		else begin
			if (BRAM_PORTA_SEQ_en) begin
				BRAM_PORTA_SEQ_addr_reg <= BRAM_PORTA_SEQ_addr;
				BRAM_PORTA_SEQ_din_reg <= BRAM_PORTA_SEQ_din;
				BRAM_PORTA_SEQ_en_reg <= BRAM_PORTA_SEQ_en;
				BRAM_PORTA_SEQ_we_reg <= BRAM_PORTA_SEQ_we;
				BRAM_PORTA_SEQ_time <= 1'b1;
			end
			else begin
				BRAM_PORTA_SEQ_addr_reg <= 12'd0;
				BRAM_PORTA_SEQ_din_reg <= 32'd0;
				BRAM_PORTA_SEQ_en_reg <= 1'b0;
				BRAM_PORTA_SEQ_we_reg <= 4'd0;
				BRAM_PORTA_SEQ_time <= 1'b0;
			end
			if (BRAM_PORTB_SEQ_en) begin
				BRAM_PORTB_SEQ_addr_reg <= BRAM_PORTB_SEQ_addr;
				BRAM_PORTB_SEQ_din_reg <= BRAM_PORTB_SEQ_din;
				BRAM_PORTB_SEQ_en_reg <= BRAM_PORTB_SEQ_en;
				BRAM_PORTB_SEQ_we_reg <= BRAM_PORTB_SEQ_we;
				BRAM_PORTB_SEQ_time <= 1'b1;
			end
			else begin
				BRAM_PORTB_SEQ_addr_reg <= 12'd0;
				BRAM_PORTB_SEQ_din_reg <= 32'd0;
				BRAM_PORTB_SEQ_en_reg <= 1'b0;
				BRAM_PORTB_SEQ_we_reg <= 4'd0;
				BRAM_PORTB_SEQ_time <= 1'b0;
			end
		end
	end
	
	wire BRAM_PORTA_SEQ_en_wire = BRAM_PORTA_SEQ_time ? BRAM_PORTA_SEQ_en_reg : BRAM_PORTA_SEQ_en;
	wire BRAM_PORTA_SEQ_we_wire = BRAM_PORTA_SEQ_time ? (BRAM_PORTA_SEQ_we_reg != 4'd0) ? 1'b1 : 1'b0 : 1'b0 ;
	wire [6:0] BRAM_PORTA_SEQ_addr_wire = BRAM_PORTA_SEQ_time ? BRAM_PORTA_SEQ_addr_reg >> 5 : BRAM_PORTA_SEQ_addr >> 5;
	wire [255:0] BRAM_PORTA_SEQ_din_wire = BRAM_PORTA_SEQ_time ? ({224'd0, BRAM_PORTA_SEQ_din_reg} << (32 * ((BRAM_PORTA_SEQ_addr_reg >> 2) & 3'b111))) + douta : 256'd0;
	wire BRAM_PORTB_SEQ_en_wire = BRAM_PORTB_SEQ_time ? BRAM_PORTB_SEQ_en_reg : BRAM_PORTB_SEQ_en;
	wire BRAM_PORTB_SEQ_we_wire = BRAM_PORTB_SEQ_time ? (BRAM_PORTB_SEQ_we_reg != 4'd0) ? 1'b1 : 1'b0 : 1'b0 ;
	wire [6:0] BRAM_PORTB_SEQ_addr_wire = BRAM_PORTB_SEQ_time ? BRAM_PORTB_SEQ_addr_reg >> 5 : BRAM_PORTB_SEQ_addr >> 5;
	wire [255:0] BRAM_PORTB_SEQ_din_wire = BRAM_PORTB_SEQ_time ? ({224'd0, BRAM_PORTB_SEQ_din_reg} << (32 * ((BRAM_PORTB_SEQ_addr_reg >> 2) & 3'b111))) + doutb : 256'd0;
    
    wire ena = (pss_search_start) ? ena_reg : BRAM_PORTA_SEQ_en_wire;
	wire wea = (pss_search_start) ? 0 : BRAM_PORTA_SEQ_we_wire;
    wire [6:0] addra = (pss_search_start) ? addra_reg : BRAM_PORTA_SEQ_addr_wire;
	wire [255:0] dina = (pss_search_start) ? 0 : BRAM_PORTA_SEQ_din_wire;
    assign seq_data_i = (pss_search_start) ? douta : 0;
	assign BRAM_PORTA_SEQ_dout = (pss_search_start) ? 0 : douta;
    wire enb = (pss_search_start) ? enb_reg : BRAM_PORTB_SEQ_en_wire;
	wire web = (pss_search_start) ? 0 : BRAM_PORTB_SEQ_we_wire;
    wire [6:0] addrb = (pss_search_start) ? addrb_reg : BRAM_PORTB_SEQ_addr_wire;
	wire [255:0] dinb = (pss_search_start) ? 0 : BRAM_PORTB_SEQ_din_wire;
    assign seq_data_q = (pss_search_start) ? doutb : 0;
	assign BRAM_PORTB_SEQ_dout = (pss_search_start) ? 0 : doutb;
    
    Seq_BRAM Seq_BRAM_0 (
        .clka(clk),    // input wire clka
        .ena(ena),      // input wire ena
        .wea(wea),      // input wire [0 : 0] wea
        .addra(addra),  // input wire [3 : 0] addra
        .dina(dina),    // input wire [1279 : 0] dina
        .douta(douta),  // output wire [1279 : 0] douta
        .clkb(clk),    // input wire clkb
        .enb(enb),      // input wire enb
        .web(web),      // input wire [0 : 0] web
        .addrb(addrb),  // input wire [3 : 0] addrb
        .dinb(dinb),    // input wire [1279 : 0] dinb
        .doutb(doutb)  // output wire [1279 : 0] doutb
        );
    
    /*--------------------------------- Access Sequence BRAM -------------------------------------*/
    
endmodule
