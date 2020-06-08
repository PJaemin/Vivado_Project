`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 18:35:00
// Design Name: 
// Module Name: tx
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


module fpga_tx(
	/* Clock and Reset*/
	input	clk_61,
	input   clk_122,
	input	resetn,
	/* RF CLK from VCTCXO @ 26 MHz */
	// now revised to be 122.88 MHz from system PLL usisng VCTCXO_CLK
	input  clk_rf_4x,
	/* SPI signals */
	input  RPI_CS,
	input  RPI_CK,
	input  RPI_MOSI,
	output RPI_MISO,
	/* SPI signals */
	output  SPI_CS,
	output  SPI_CK,
	output  SPI_DW,
	input   spi_dr_i,
	output  spi_dr_e,
	output  spi_dr_o,
	/* AFC DAC signals */
	output  AFC_DAC_SCLK,
	output  AFC_DAC_LDAC,
	output  AFC_DAC_CS,
	output  AFC_DAC_DIN
	/* GPR signals */
	//output  [4:0] gpio_rf,
    );
	
	reg r_rpi_ck, r_rpi_ck_d;
	reg r_rpi_cs, r_rpi_cs_d;
	reg r_rpi_dw;
	reg r_rpi_dr;
	reg [4:0] rpi_cnt;
	reg rpi_rw;
	reg rpi_rw_24b;
	
	always@ (posedge clk_122 or negedge resetn) begin
	   if (!resetn) begin
	       r_rpi_cs <= 1'b1;
	       r_rpi_ck <= 1'b0;
           r_rpi_dw <= 1'b0;
           r_rpi_dr <= 1'b0;
           //
           r_rpi_cs_d <= 1'b1;
           r_rpi_ck_d <= 1'b0;
           //
           rpi_rw <= 1'b0;
           rpi_rw_24b <= 1'b0;
	   end
	   else begin
	       r_rpi_cs <= RPI_CS;
	       r_rpi_ck <= RPI_CK;
	       r_rpi_dw <= RPI_MOSI;
	       r_rpi_dr <= spi_dr_i;
	       //
	       r_rpi_cs_d <= r_rpi_cs;
	       r_rpi_ck_d <= r_rpi_ck;
	       if ((r_rpi_cs == 1'b0)) begin
	           if (r_rpi_cs_d == 1'b1) begin
	               rpi_cnt <= 5'd0;
	               rpi_rw <= 1'b0; // write
	               rpi_rw_24b <= 1'b0; // write
	           end else if ((r_rpi_ck_d == 1'b0) && (r_rpi_ck == 1'b1)) begin
	               rpi_cnt <= rpi_cnt + 5'd1;
	               if (rpi_cnt == 5'd0) begin // 1st bit
	                   rpi_rw_24b <= r_rpi_dw; // write or read
	               end
	               if (rpi_cnt == 5'd8) begin
	                   rpi_rw <= rpi_rw_24b;
	               end
	           end
	       end
	   end
	end

    assign spi_dr_e = r_rpi_cs ? 1'b1 : ~rpi_rw;
    assign spi_dr_o = 1'b0;

	assign SPI_CK = r_rpi_ck;
	assign SPI_CS = r_rpi_cs;
	assign SPI_DW = r_rpi_dw;
	assign RPI_MISO = r_rpi_dr; 
	
	// counting RF_CLK(VCTCXO_CLK) to generate 1MHz clock
	//     runs in range [4 .. 29]
	reg [4:0] count_1us_26mhz;
	always@ (posedge clk_rf_4x or negedge resetn) begin
	   if (!resetn) begin
           count_1us_26mhz <= 5'd4;
	   end
	   else begin
            if (count_1us_26mhz < 5'd29) begin
                count_1us_26mhz <= count_1us_26mhz + 5'd1;
            end
            else begin
                count_1us_26mhz <= 5'd4;
            end
        end
    end
	
	assign AFC_DAC_CS = 1'b1;
	assign AFC_DAC_LDAC = 1'b1;
	assign AFC_DAC_SCLK = 1'b1;
	assign AFC_DAC_DIN = 1'b1;


    //assign gpio_rf = count_1us_26mhz[4:0];
    
	//assign ADC_CLK = start ? clk_20 : 1'b0;
	
endmodule
