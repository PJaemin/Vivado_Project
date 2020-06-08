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


module afcdac_if( // ADI AD5541A on AFER7b
	/* Clock and Reset*/
	input	clk_61,
	input   clk_122,
	input	resetn,
	
	//
	input sel_src,
	input [15:0] afc_16b_vio,

	/* SPI signals from RPI */
	input  RPI_CS,
	input  RPI_CK,
	input  RPI_MOSI,
	output RPI_MISO,

	/* SPI signals to AFC-DAC */
	output  DAC_CS,
	output  DAC_CK,
	output  DAC_DW,
	output  DAC_LD
    );
	
	reg r_rpi_ck, r_rpi_ck_d;
	reg r_rpi_cs, r_rpi_cs_d;
	reg r_rpi_dw;
	reg r_rpi_dr;
	reg [4:0] rpi_cnt;
	reg rpi_rw;
	reg rpi_rw_24b;

	reg [15:0] afcdac_16b;
	reg afcdac_on, afcdac_off;
	reg afcdac_dr;
	
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
	    //
	    afcdac_16b <= 16'd0;
	    afcdac_on <= 1'b0;
	   end
	   else begin
	       r_rpi_cs <= RPI_CS;
	       r_rpi_ck <= RPI_CK;
	       r_rpi_dw <= RPI_MOSI;
	       r_rpi_dr <= afcdac_dr & rpi_rw;
	       //
	       r_rpi_cs_d <= r_rpi_cs;
	       r_rpi_ck_d <= r_rpi_ck;
	       if ((r_rpi_cs == 1'b0)) begin // {
	           if (r_rpi_cs_d == 1'b1) begin
	               rpi_cnt <= 5'd0;
	               rpi_rw <= 1'b0; // write
	               rpi_rw_24b <= 1'b0; // write
	               
	           end else if ((r_rpi_ck_d == 1'b0) && (r_rpi_ck == 1'b1)) begin // rising edge.
	               rpi_cnt <= rpi_cnt + 5'd1;
	               if (rpi_cnt == 5'd0) begin // 1st bit
	                   rpi_rw_24b <= r_rpi_dw; // write or read
	               end
	               if (rpi_cnt == 5'd8) begin
	                   rpi_rw <= rpi_rw_24b;
	               end
	               if (rpi_cnt >= 5'd16) begin
			    if (rpi_rw == 1'b0) begin // write
				afcdac_16b <= {afcdac_16b[14:0], r_rpi_dw};
			    end
		       end
	           end else if ((r_rpi_ck_d == 1'b1) && (r_rpi_ck == 1'b0)) begin // falling edge.
		       //if (rpi_cnt == 5'd31) begin
			   //afcdac_on <= 1'b1;
		       //end
	           end
	       end // }
	       if ((r_rpi_cs == 1'b1)) begin // {
	           if (r_rpi_cs_d == 1'b0) begin	       
	                   afcdac_on <= 1'b1;
	           end
	       end
	       if (afcdac_off == 1'b1) begin
		      afcdac_on = 1'b0;
	       end
	   end
	end
    
    assign RPI_MISO = r_rpi_dr; 

    always @ (afcdac_16b or rpi_cnt) begin
	case (rpi_cnt)
	5'd16 : afcdac_dr <= afcdac_16b[15];
	5'd17 : afcdac_dr <= afcdac_16b[14];
	5'd18 : afcdac_dr <= afcdac_16b[13];
	5'd19 : afcdac_dr <= afcdac_16b[12];
	5'd20 : afcdac_dr <= afcdac_16b[11];
	5'd21 : afcdac_dr <= afcdac_16b[10];
	5'd22 : afcdac_dr <= afcdac_16b[ 9];
	5'd23 : afcdac_dr <= afcdac_16b[ 8];
	5'd24 : afcdac_dr <= afcdac_16b[ 7];
	5'd25 : afcdac_dr <= afcdac_16b[ 6];
	5'd26 : afcdac_dr <= afcdac_16b[ 5];
	5'd27 : afcdac_dr <= afcdac_16b[ 4];
	5'd28 : afcdac_dr <= afcdac_16b[ 3];
	5'd29 : afcdac_dr <= afcdac_16b[ 2];
	5'd30 : afcdac_dr <= afcdac_16b[ 1];
	5'd31 : afcdac_dr <= afcdac_16b[ 0];
	default : afcdac_dr <= 1'b0;
	endcase
    end

    //
    // afcdac core
    //
    reg afcdac_on_d;
    //reg r_dac_ck;
    reg r_dac_cs, r_dac_cs_d;
    reg [1:0] r_dac_ld;
    reg [4:0] dac_cnt;
    reg [15:0] dac_val;
    
    reg vio_chgd;
    reg [15:0] afc_16b_vio_d;
    
    always @ (posedge clk_61 or negedge resetn) begin
	if (!resetn) begin
	    afcdac_on_d <= 1'b0;
	    afcdac_off <= 1'b0;
	    //r_dac_ck <= 1'b1;
	    r_dac_cs <= 1'b0;
	    r_dac_ld <= 2'b00;
	    dac_cnt <= 5'd0;
	    dac_val <= 16'd0;	
	    //
	    afc_16b_vio_d <= 16'd0;
	    vio_chgd <= 1'b0;    
	end else begin
	    afcdac_off <= 1'b0;
	    afcdac_on_d <= afcdac_on;
	    if (afcdac_on_d == 1'b1 && sel_src == 1'b0) begin // SPI from RPI
		  r_dac_cs <= 1'b1;
		  dac_val <= afcdac_16b;
		  afcdac_off <= 1'b1;
	    end	   
	    afc_16b_vio_d <= afc_16b_vio;
	    if (afc_16b_vio_d != afc_16b_vio)
	       vio_chgd <= 1'b1;
	    else
	       vio_chgd <= 1'b0;
	    if ((sel_src == 1'b1) && (vio_chgd == 1'b1)) begin // value changed from vio
	       r_dac_cs <= 1'b1;
	       dac_val <= afc_16b_vio_d;
	    end
	    if ((dac_cnt != 6'd0) || (r_dac_cs == 1'b1)) begin
		dac_cnt <= dac_cnt + 6'd1;
		  if (dac_cnt == 5'd31) begin
		    r_dac_cs <= 1'b0;		    
		  end
	    end
	    r_dac_cs_d <= r_dac_cs;
	    if (dac_cnt[0]) dac_val <= {dac_val[14:0], 1'b0};
	    if ((r_dac_cs_d == 1'b1) && (r_dac_cs == 1'b0)) begin // r_dac_cs is active high...
		r_dac_ld <= 2'd1;
	    end else if (r_dac_ld != 2'd0) begin
		r_dac_ld <= r_dac_ld + 2'd1;
	    end
	end
    end

    assign DAC_DW = dac_val[15];
    assign DAC_CS = ~r_dac_cs; // active low
    assign DAC_CK = dac_cnt[0];
    assign DAC_LD = ~r_dac_ld[1]; // active low

endmodule // afcdac_if
