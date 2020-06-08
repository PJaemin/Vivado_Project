`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 19:50:44
// Design Name: 
// Module Name: out_bram_ctrl_mux
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


module Out_BRAM_Ctrl_MUX (
    input clk,
    input resetn,
    input [1:0] buf_sel,
    input ena_1,
    input wea_1,
    input [14:0] addra_1,
    input [31:0] dina_1,
    output [31:0] douta_1,
    input enb_1,
    input web_1,
    input [14:0] addrb_1,
    input [31:0] dinb_1,
    output [31:0] doutb_1,
	input ena_2,
    input wea_2,
    input [14:0] addra_2,
    input [31:0] dina_2,
    output [31:0] douta_2,
    input enb_2,
    input web_2,
    input [14:0] addrb_2,
    input [31:0] dinb_2,
    output [31:0] doutb_2,
	input ena_3,
    input wea_3,
    input [14:0] addra_3,
    input [31:0] dina_3,
    output [31:0] douta_3,
    input enb_3,
    input web_3,
    input [14:0] addrb_3,
    input [31:0] dinb_3,
    output [31:0] doutb_3
    /*input pss_search_done,
    output enb_1_wire,
    output [14:0] addrb_1_wire,
    output [19:0] doutb_1_wire,
    output enb_2_wire,
    output [14:0] addrb_2_wire,
    output [19:0] doutb_2_wire,
    output enb_3_wire,
    output [14:0] addrb_3_wire,
    output [19:0] doutb_3_wire*/
    );
	
    /*wire enb_1_tmp;
    wire [14:0] addrb_1_tmp;
    wire [31:0] doutb_1_tmp;
    
    wire enb_2_tmp;
    wire [14:0] addrb_2_tmp;
    wire [31:0] doutb_2_tmp;
    
    wire enb_3_tmp;
    wire [14:0] addrb_3_tmp;
	wire [31:0] doutb_3_tmp;
	
	assign doutb_1 = doutb_1_tmp;
	assign doutb_2 = doutb_2_tmp;
	assign doutb_3 = doutb_3_tmp;
                                       
    assign enb_1_wire = enb_1_tmp;
    assign addrb_1_wire = addrb_1_tmp;
    assign doutb_1_wire = doutb_1_tmp[19:0];
    assign enb_2_wire = enb_2_tmp;
    assign addrb_2_wire = addrb_2_tmp;
    assign doutb_2_wire = doutb_2_tmp[19:0];
    assign enb_3_wire = enb_3_tmp;
    assign addrb_3_wire = addrb_3_tmp;
    assign doutb_3_wire = doutb_3_tmp[19:0];
    
    reg check;
    always@ (posedge clk or negedge resetn) begin
        if (~resetn) begin
            check <= 1'b0;
        end
        else begin
            if (pss_search_done)
                check <= 1'b1;
        end
    end
    
    MUX MUX_0 (
        .clk(clk),
        .resetn(resetn),
        .buf_sel(buf_sel),
        .check(check),
        .enb_1(enb_1),
        .addrb_1(addrb_1),
		.enb_2(enb_2),
        .addrb_2(addrb_2),
		.enb_3(enb_3),
        .addrb_3(addrb_3),
        .enb_1_tmp(enb_1_tmp),
        .addrb_1_tmp(addrb_1_tmp),
        .enb_2_tmp(enb_2_tmp),
        .addrb_2_tmp(addrb_2_tmp),
        .enb_3_tmp(enb_3_tmp),
        .addrb_3_tmp(addrb_3_tmp)
        );*/

    Out_BRAM Out_BRAM_1 (
        .clka(clk),    // input wire clka
        .ena(ena_1),      // input wire ena
        .wea(wea_1),      // input wire [0 : 0] wea
        .addra(addra_1),  // input wire [14 : 0] addra
        .dina(dina_1),    // input wire [19 : 0] dina
        .douta(douta_1),  // output wire [19 : 0] douta
        .clkb(clk),    // input wire clkb
        .enb(enb_1),//_tmp),      // input wire enb
        .web(web_1),      // input wire [0 : 0] web
        .addrb(addrb_1),//_tmp),  // input wire [14 : 0] addrb
        .dinb(dinb_1),    // input wire [19 : 0] dinb
        .doutb(doutb_1)//_tmp)  // output wire [19 : 0] doutb
        );
        
    Out_BRAM Out_BRAM_2 (
        .clka(clk),    // input wire clka
        .ena(ena_2),      // input wire ena
        .wea(wea_2),      // input wire [0 : 0] wea
        .addra(addra_2),  // input wire [14 : 0] addra
        .dina(dina_2),    // input wire [19 : 0] dina
        .douta(douta_2),  // output wire [19 : 0] douta
        .clkb(clk),    // input wire clkb
        .enb(enb_2),//_tmp),      // input wire enb
        .web(web_2),      // input wire [0 : 0] web
        .addrb(addrb_2),//_tmp),  // input wire [14 : 0] addrb
        .dinb(dinb_2),    // input wire [19 : 0] dinb
        .doutb(doutb_2)//_tmp)  // output wire [19 : 0] doutb
        );
        
    Out_BRAM Out_BRAM_3 (
        .clka(clk),    // input wire clka
        .ena(ena_3),      // input wire ena
        .wea(wea_3),      // input wire [0 : 0] wea
        .addra(addra_3),  // input wire [14 : 0] addra
        .dina(dina_3),    // input wire [19 : 0] dina
        .douta(douta_3),  // output wire [19 : 0] douta
        .clkb(clk),    // input wire clkb
        .enb(enb_3),//_tmp),      // input wire enb
        .web(web_3),      // input wire [0 : 0] web
        .addrb(addrb_3),//_tmp),  // input wire [14 : 0] addrb
        .dinb(dinb_3),    // input wire [19 : 0] dinb
        .doutb(doutb_3)//_tmp)  // output wire [19 : 0] doutb
        );
        
endmodule
