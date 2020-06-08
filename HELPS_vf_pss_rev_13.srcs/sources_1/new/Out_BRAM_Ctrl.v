`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/18 17:21:55
// Design Name: 
// Module Name: out_BRAM_ctrl
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

`define OUTPUT_IDLE 2'd0
`define OUTPUT_TMP 2'd1
`define OUTPUT_STORE_1 2'd2
`define OUTPUT_STORE_2 2'd3

module Out_BRAM_Ctrl(
    clk,
    resetn,
	pss_search_start,
    pss_accumulation_num,
    pss_search_mode,
    pss_antenna_combining,
    pss_div_shift_bit,
    pss_output_mode,
    pss_output_thres,
    matched_power_1,
    matched_power_2,
	output_valid,
    dma_start,
    pss_search_done,
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
    BRAM_PORTB_OUT_3_we
    );
	
	input clk;
    input resetn;
	input pss_search_start;
    input [1:0] pss_accumulation_num;
    input [1:0] pss_search_mode;
    input [1:0] pss_antenna_combining;
    input signed [2:0] pss_div_shift_bit;
    input pss_output_mode;
    input [43:0] pss_output_thres;
    input [19:0] matched_power_1;
    input [19:0] matched_power_2;
	input output_valid;
    output dma_start;
    output pss_search_done;
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
	
	wire clk;
    wire resetn;
	wire pss_search_start;
    wire [1:0] pss_accumulation_num;
    wire [1:0] pss_search_mode;
    wire [1:0] pss_antenna_combining;
    wire signed [2:0] pss_div_shift_bit;
    wire pss_wire_mode;
    wire [43:0] pss_wire_thres;
    wire [19:0] matched_power_1;
    wire [19:0] matched_power_2;
	wire wire_valid;
    wire dma_start;
    wire pss_search_done;
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

    wire [20:0] matched_power_total = (pss_antenna_combining == 2'b11) ? {1'b0, matched_power_1} + {1'b0, matched_power_2} :
									  (pss_antenna_combining == 2'b10) ? {1'b0, matched_power_1} :
																		 {1'b0, matched_power_2};
    wire [19:0] matched_power_total_reduced;
    
    wire signed [4:0] div_shift_bit_ext = {{2{pss_div_shift_bit[2]}}, pss_div_shift_bit};

    shift_u shift_u_0 (
        .dir(1'b1),
        .shift_bit(5'd3 + div_shift_bit_ext),
        .input_val({{11{matched_power_total[20]}}, matched_power_total}),
        .output_bit(5'd16),
        .output_val(matched_power_total_reduced)
        );
	
    wire [4:0] accumulation_num = 5'b0010 <<< pss_accumulation_num;
    
    reg ena_reg;
    reg wea_reg;
    reg [14:0] addra_reg;
    reg [19:0] dina_reg;
    reg enb_reg;
    reg [14:0] addrb_reg;
	
	wire [19:0] doutb;
    
    reg [14:0] addr_mode_1;
	reg [19:0] data;
    
    reg [1:0] STATE;
    reg [4:0] accumulation_count;
    reg [14:0] idx;
    reg [1:0] buf_sel;
    
    reg dma_start_reg;
    assign dma_start = dma_start_reg;
    reg pss_search_done_reg;
    assign pss_search_done = pss_search_done_reg;
    wire pss_search_done_wire = pss_search_done_reg;
    
    always@ (posedge clk or negedge resetn) begin
        if (~resetn) begin
			STATE <= `OUTPUT_IDLE;
            ena_reg <= 1'b0;
            wea_reg <= 1'b0;
            addra_reg <= 15'd0;
            dina_reg <= 20'd0;
            enb_reg <= 1'b0;
            addrb_reg <= 15'd0;
            addr_mode_1 <= 15'd0;
			data <= 20'd0;
            idx <= 15'd0;
            buf_sel <= 2'd0;
			accumulation_count <= 5'd0;
            dma_start_reg <= 1'b0;
            pss_search_done_reg <= 1'b0;
        end
        else begin
            case (STATE)
                `OUTPUT_IDLE: begin
                    if (output_valid) begin
                        STATE <= `OUTPUT_TMP;
						ena_reg <= 1'b0;
						wea_reg <= 1'b0;
						addra_reg <= 15'd0;
                        enb_reg <= 1'b1;
						addrb_reg <= idx;
                    end
                    else begin
						STATE <= `OUTPUT_IDLE;
						ena_reg <= 1'b0;
						wea_reg <= 1'b0;
						addra_reg <= 15'd0;
						enb_reg <= 1'b0;
						addrb_reg <= 15'd0;
						
                    end
					if (dma_start_reg == 1'b1)
						addr_mode_1 <= 15'd0;
					else
						addr_mode_1 <= addr_mode_1;
					dma_start_reg <= 1'b0;
					data <= 20'd0;
					pss_search_done_reg <= 1'b0;
                end
                `OUTPUT_TMP: begin
					STATE <= `OUTPUT_STORE_1;
					ena_reg <= 1'b0;
					wea_reg <= 1'b0;
					addra_reg <= 15'd0;
                    enb_reg <= 1'b0;
					addrb_reg <= 15'd0;
					dma_start_reg <= 1'b0;
					data <= 20'd0;
					pss_search_done_reg <= 1'b0;
                end
                `OUTPUT_STORE_1: begin
                    if (accumulation_count == (accumulation_num - 5'd1)) begin
                        case (pss_output_mode)
                            1'b0: begin
								STATE <= `OUTPUT_IDLE;
                                ena_reg <= 1'b1;
                                wea_reg <= 1'b1;
                                addra_reg <= idx;
                                dina_reg <= matched_power_total_reduced + doutb;
								enb_reg <= 1'b0;
								addrb_reg <= 15'd0;
								data <= 20'd0;
                            end
                            1'b1: begin
                                if (addr_mode_1 < 15'd19200) begin
                                    if ((matched_power_total_reduced + doutb) > pss_output_thres) begin
										STATE <= `OUTPUT_STORE_2;
                                        ena_reg <= 1'b1;
                                        wea_reg <= 1'b1;
                                        addra_reg <= addr_mode_1;
                                        dina_reg <= idx;
										enb_reg <= 1'b0;
										addrb_reg <= 15'd0;
										data <= matched_power_total_reduced + doutb;
                                    end
                                    else begin
										STATE <= `OUTPUT_IDLE;
                                        ena_reg <= 1'b0;
                                        wea_reg <= 1'b0;
                                        addra_reg <= 15'd0;
                                        dina_reg <= 20'd0;
                                        enb_reg <= 1'b0;
                                        data <= 20'd0;
                                    end
                                end
                                else begin
                                    ena_reg <= 1'b0;
									wea_reg <= 1'b0;
									addra_reg <= 15'd0;
									enb_reg <= 1'b0;
									addrb_reg <= 15'd0;
									data <= 20'd0;
                                end
                            end
                            default: begin
                            end
                        endcase
                        if (idx < 15'd19199) begin
                            idx <= idx + 15'd1;
							buf_sel <= buf_sel;
                            dma_start_reg <= 1'b0;
                            pss_search_done_reg <= 1'b0;
                        end
                        else begin
                            idx <= 15'd0;
                            dma_start_reg <= 1'b1;
                            accumulation_count <= 5'd0;
							if (addr_mode_1 == 15'd19200)
								addr_mode_1 <= 15'd0;
							case (pss_search_mode)
								2'b00: begin
									if (buf_sel < 2'd2) begin
										buf_sel <= buf_sel + 2'd1;
									end
									else begin
										pss_search_done_reg <= 1'b1;
										buf_sel <= 2'd0;
									end
								end
								2'b01: begin
									pss_search_done_reg <= 1'b1;
									buf_sel <= 2'd0;
								end
								2'b10: begin
									if (buf_sel < 2'd1) begin
										buf_sel <= buf_sel + 2'd1;
									end
									else begin
										pss_search_done_reg <= 1'b1;
										buf_sel <= 2'd0;
									end
								end
								default: begin
								end
							endcase
                        end
                    end
					else begin
						STATE <= `OUTPUT_IDLE;
                        ena_reg <= 1'b1;
                        wea_reg <= 1'b1;
                        addra_reg <= idx;
                        enb_reg <= 1'b0;
						addrb_reg <= 15'd0;
                        if (accumulation_count == 5'd0)
                            dina_reg <= matched_power_total_reduced;
                        else
                            dina_reg <= matched_power_total_reduced + doutb;
                        if (idx < 15'd19199) begin
                            idx <= idx + 15'd1;
                        end
                        else begin
                            idx <= 15'd0;
                            accumulation_count <= accumulation_count + 5'd1;
                        end
					end
                end
				`OUTPUT_STORE_2: begin
					STATE <= `OUTPUT_IDLE;
					ena_reg <= 1'b1;
					wea_reg <= 1'b1;
					addra_reg <= addr_mode_1 + 15'd1;
					dina_reg <= data;
					enb_reg <= 1'b0;
					addrb_reg <= 15'd0;
					if (dma_start_reg)
						addr_mode_1 <= 15'd0;
                    else
                        addr_mode_1 <= addr_mode_1 + 15'd2;
					dma_start_reg <= 1'b0;
					pss_search_done_reg <= 1'b0;
				end
                default: begin
                end
            endcase
        end
    end
	
	wire BRAM_PORTA_OUT_1_we_wire = (BRAM_PORTA_OUT_1_we != 4'd0) ? 1'b1 : 1'b0;
    wire [14:0] BRAM_PORTA_OUT_1_addr_wire = BRAM_PORTA_OUT_1_addr >> 2;
	wire BRAM_PORTA_OUT_2_we_wire = (BRAM_PORTA_OUT_2_we != 4'd0) ? 1'b1 : 1'b0;
    wire [14:0] BRAM_PORTA_OUT_2_addr_wire = BRAM_PORTA_OUT_2_addr >> 2;
	wire BRAM_PORTA_OUT_3_we_wire = (BRAM_PORTA_OUT_3_we != 4'd0) ? 1'b1 : 1'b0;
    wire [14:0] BRAM_PORTA_OUT_3_addr_wire = BRAM_PORTA_OUT_3_addr >> 2;
    
	wire BRAM_PORTB_OUT_1_we_wire = (BRAM_PORTB_OUT_1_we != 4'd0) ? 1'b1 : 1'b0;
    wire [14:0] BRAM_PORTB_OUT_1_addr_wire = BRAM_PORTB_OUT_1_addr >> 2;
	wire BRAM_PORTB_OUT_2_we_wire = (BRAM_PORTB_OUT_2_we != 4'd0) ? 1'b1 : 1'b0;
    wire [14:0] BRAM_PORTB_OUT_2_addr_wire = BRAM_PORTB_OUT_2_addr >> 2;
	wire BRAM_PORTB_OUT_3_we_wire = (BRAM_PORTB_OUT_3_we != 4'd0) ? 1'b1 : 1'b0;
    wire [14:0] BRAM_PORTB_OUT_3_addr_wire = BRAM_PORTB_OUT_3_addr >> 2;
	
	wire ena_1 = (pss_search_start) ? (buf_sel == 2'd0) ? ena_reg : 1'b0 : BRAM_PORTA_OUT_1_en;
    wire wea_1 = (pss_search_start) ? (buf_sel == 2'd0) ? wea_reg : 1'b0 : BRAM_PORTA_OUT_1_we_wire;
    wire [14:0] addra_1 = (pss_search_start) ? (buf_sel == 2'd0) ? addra_reg : 15'd0 : BRAM_PORTA_OUT_1_addr_wire;
    wire [31:0] dina_1 = (pss_search_start) ? (buf_sel == 2'd0) ? dina_reg : 32'd0 : BRAM_PORTA_OUT_1_din;
    wire [31:0] douta_1;
	assign BRAM_PORTA_OUT_1_dout = (pss_search_start) ? 32'd0 : douta_1;
	
	wire ena_2 = (pss_search_start) ? (buf_sel == 2'd1) ? ena_reg : 1'b0 : BRAM_PORTA_OUT_2_en;
    wire wea_2 = (pss_search_start) ? (buf_sel == 2'd1) ? wea_reg : 1'b0 : BRAM_PORTA_OUT_2_we_wire;
    wire [14:0] addra_2 = (pss_search_start) ? (buf_sel == 2'd1) ? addra_reg : 15'd0 : BRAM_PORTA_OUT_2_addr_wire;
    wire [31:0] dina_2 = (pss_search_start) ? (buf_sel == 2'd1) ? dina_reg : 32'd0 : BRAM_PORTA_OUT_2_din;
    wire [31:0] douta_2;
	assign BRAM_PORTA_OUT_2_dout = (pss_search_start) ? 32'd0 : douta_2;
	
	wire ena_3 = (pss_search_start) ? (buf_sel == 2'd2) ? ena_reg : 1'b0 : BRAM_PORTA_OUT_3_en;
    wire wea_3 = (pss_search_start) ? (buf_sel == 2'd2) ? wea_reg : 1'b0 : BRAM_PORTA_OUT_3_we_wire;
    wire [14:0] addra_3 = (pss_search_start) ? (buf_sel == 2'd2) ? addra_reg : 15'd0 : BRAM_PORTA_OUT_3_addr_wire;
    wire [31:0] dina_3 = (pss_search_start) ? (buf_sel == 2'd2) ? dina_reg : 32'd0 : BRAM_PORTA_OUT_3_din;
    wire [31:0] douta_3;
	assign BRAM_PORTA_OUT_3_dout = (pss_search_start) ? 32'd0 : douta_3;
	
	wire enb_1 = (pss_search_start) ? (buf_sel == 2'd0) ? enb_reg : 1'b0 : BRAM_PORTB_OUT_1_en;
    wire web_1 = (pss_search_start) ? 1'b0 : BRAM_PORTB_OUT_1_we_wire;
    wire [14:0] addrb_1 = (pss_search_start) ? (buf_sel == 2'd0) ? addrb_reg : 15'd0 : BRAM_PORTB_OUT_1_addr_wire;
    wire [31:0] dinb_1 = (pss_search_start) ? 32'd0 : BRAM_PORTB_OUT_1_din;
    wire [31:0] doutb_1;
	assign BRAM_PORTB_OUT_1_dout = (pss_search_start) ? 32'd0 : doutb_1;
	
	wire enb_2 = (pss_search_start) ? (buf_sel == 2'd1) ? enb_reg : 1'b0 : BRAM_PORTB_OUT_2_en;
    wire web_2 = (pss_search_start) ? 1'b0 : BRAM_PORTB_OUT_2_we_wire;
    wire [14:0] addrb_2 = (pss_search_start) ? (buf_sel == 2'd1) ? addrb_reg : 15'd0 : BRAM_PORTB_OUT_2_addr_wire;
    wire [31:0] dinb_2 = (pss_search_start) ? 32'd0 : BRAM_PORTB_OUT_2_din;
    wire [31:0] doutb_2;
	assign BRAM_PORTB_OUT_2_dout = (pss_search_start) ? 32'd0 : doutb_2;
	
	wire enb_3 = (pss_search_start) ? (buf_sel == 2'd2) ? enb_reg : 1'b0 : BRAM_PORTB_OUT_3_en;
    wire web_3 = (pss_search_start) ? 1'b0 : BRAM_PORTB_OUT_3_we_wire;
    wire [14:0] addrb_3 = (pss_search_start) ? (buf_sel == 2'd2) ? addrb_reg : 15'd0 : BRAM_PORTB_OUT_3_addr_wire;
    wire [31:0] dinb_3 = (pss_search_start) ? 32'd0 : BRAM_PORTB_OUT_3_din;
    wire [31:0] doutb_3;
	assign BRAM_PORTB_OUT_3_dout = (pss_search_start) ? 32'd0 : doutb_3;
	
	assign doutb = (pss_search_start) ? (buf_sel == 2'd0) ? doutb_1[19:0] :
									    (buf_sel == 2'd1) ? doutb_2[19:0] :
										(buf_sel == 2'd2) ? doutb_3[19:0] : 20'd0 : 20'd0;
    
    Out_BRAM Out_BRAM_1 (
        .clka(clk),        // input wire clka           
        .ena(ena_1),       // input wire ena            
        .wea(wea_1),       // input wire [0 : 0] wea    
        .addra(addra_1),   // input wire [14 : 0] addra 
        .dina(dina_1),     // input wire [31 : 0] dina  
        .douta(douta_1),   // output wire [31 : 0] douta
        .clkb(clk),        // input wire clkb           
        .enb(enb_1),       // input wire enb            
        .web(web_1),       // input wire [0 : 0] web    
        .addrb(addrb_1),   // input wire [14 : 0] addrb 
        .dinb(dinb_1),     // input wire [31 : 0] dinb  
        .doutb(doutb_1)    // output wire [31 : 0] doutb 
        );
        
    Out_BRAM Out_BRAM_2 (
        .clka(clk),        // input wire clka           
        .ena(ena_2),       // input wire ena            
        .wea(wea_2),       // input wire [0 : 0] wea    
        .addra(addra_2),   // input wire [14 : 0] addra 
        .dina(dina_2),     // input wire [31 : 0] dina  
        .douta(douta_2),   // output wire [31 : 0] douta
        .clkb(clk),        // input wire clkb           
        .enb(enb_2),       // input wire enb            
        .web(web_2),       // input wire [0 : 0] web    
        .addrb(addrb_2),   // input wire [14 : 0] addrb 
        .dinb(dinb_2),     // input wire [31 : 0] dinb  
        .doutb(doutb_2)    // output wire [31 : 0] doutb 
        );
        
    Out_BRAM Out_BRAM_3 (
        .clka(clk),        // input wire clka           
        .ena(ena_3),       // input wire ena            
        .wea(wea_3),       // input wire [0 : 0] wea    
        .addra(addra_3),   // input wire [14 : 0] addra 
        .dina(dina_3),     // input wire [31 : 0] dina  
        .douta(douta_3),   // output wire [31 : 0] douta
        .clkb(clk),        // input wire clkb           
        .enb(enb_3),       // input wire enb            
        .web(web_3),       // input wire [0 : 0] web    
        .addrb(addrb_3),   // input wire [14 : 0] addrb 
        .dinb(dinb_3),     // input wire [31 : 0] dinb  
        .doutb(doutb_3)    // output wire [31 : 0] doutb 
        );
    
endmodule
