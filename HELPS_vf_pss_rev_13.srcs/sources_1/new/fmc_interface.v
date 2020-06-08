`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/14 16:30:57
// Design Name: 
// Module Name: fmc_interface
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


module fmc_interface(
    /* Clock and Reset*/
    input reset,
    input clk_in1_p,
    input clk_in1_n,
    /* RF CLK from VCTCXO @ 26 MHz */
	input  VCTCXO_CLK,
    /* SPI signals : RPI => ZCU102 */
    input  RPI_CS0,
    input  RPI_CS1,
    input  RPI_CK,
    input  RPI_MOSI,
    output RPI_MISO,
    /* SPI signals : ZCU102 => FC7880 */
    output  SPI_CS,
    output  SPI_CK,
    output  SPI_DW,
    inout   SPI_DR,
    /* AFC DAC signals */
    output  AFC_DAC_SCLK,
    output  AFC_DAC_LDAC,
    output  AFC_DAC_DIN,
    output  AFC_DAC_CS,
    /* GPR signals */
    output [4:0] GPR,
    /* ADC clk signal */
    output ADC_CLK,
    input [11:0] DL_RX0_I, // RX0_I
    input [11:0] DL_RX0_Q, // RX0_Q
    input [11:0] DL_RX1_I, // RX2_I
    input [11:0] DL_RX1_Q, // RX2_Q
    input [11:0] UL_RX0_I, // RX1_I
    input [11:0] UL_RX0_Q, // RX1_Q
    input [11:0] UL_RX1_I, // RX3_I
    input [11:0] UL_RX1_Q,  // RX3_Q
    /* Test & debugging */
    input  [7:0] DBG_SW,
    output [7:0] DBG_LED,
    /* 61.44 MHz clock */
    output clk,
    /* DL data */
    output signed [11:0] dl_i_1,
    output signed [11:0] dl_q_1,
    output dl_valid_1,
    output signed [11:0] dl_i_2,
    output signed [11:0] dl_q_2,
    output dl_valid_2
    );
    
    wire clk_61;
    wire clk_122;
    wire clk_rf_4x; // 122.88 MHz clock
    wire clk_rf_2x; // 61.44 MHz clock
    wire clk_rf_1x; // 30.72 MHz clock
    wire clk_rf_7p68;
    
    assign clk = clk_rf_2x;
    
    wire [3:0] md_vio;
    wire [3:0] sel_adc, sel_adc_vio;
    wire [15:0] afc_16b, afc_16b_vio;

    clk_wiz clk_wiz_0 (
        // Clock out ports
        .clk_out1(clk_61),     // output clk_out1
        .clk_out2(clk_122),     // output clk_out2
        // Status and control signals
        .reset(reset), // input reset
        // Clock in ports
        .clk_in1_p(clk_in1_p),    // input clk_in1_p
        .clk_in1_n(clk_in1_n)    // input clk_in1_n
        );
    
    wire spi_dr_o, spi_dr_e, spi_dr_i;
    assign spi_dr_i = SPI_DR;
    assign SPI_DR = spi_dr_e ? spi_dr_o : 1'bz;
        
    wire [4:0] gpio_rf;
    
    wire RPI_MISO_CS0, RPI_MISO_CS1;
    assign RPI_MISO = (~RPI_CS0) ? RPI_MISO_CS0 : RPI_MISO_CS1;
    
    fpga_tx fpga_tx_0 (
        /* Clock and Reset*/
        .clk_61(clk_61),
        .clk_122(clk_122),
        .resetn(resetn),
        /* RF CLK from VCTCXO @ 26 MHz */
        .clk_rf_4x(clk_rf_4x),
        /* RPI SPI signals : input */
        .RPI_CS(RPI_CS0),
        .RPI_CK(RPI_CK),
        .RPI_MOSI(RPI_MOSI),
        .RPI_MISO(RPI_MISO_CS0),
        /* RF SPI signals : output */
        .SPI_CS(SPI_CS),
        .SPI_CK(SPI_CK),
        .SPI_DW(SPI_DW),
        .spi_dr_o(spi_dr_o),
        .spi_dr_e(spi_dr_e),
        .spi_dr_i(spi_dr_i),
		/* AFC DAC signals */
        .AFC_DAC_CS(),
        .AFC_DAC_SCLK(),
        .AFC_DAC_LDAC(),
        .AFC_DAC_DIN()
        /* GPR signals */
        //.gpio_rf(gpio_rf),
        );
        
    assign GPR = gpio_rf;
    
    reg [11:0] adc_i, adc_q;
    reg dl_valid_reg[1:0][1:0];
    reg [5:0] adc_clk_32mhz; // 1MHz count 
    
    fpga_rx fpga_rx_0 (
        /* Clock and Reset*/
        //.clk_ila(clk_122),
        .clk_ila(clk_rf_7p68),
        .resetn(resetn),
        /* SPI signals */
        .SPI_CS(SPI_CS),
		.SPI_CK(SPI_CK),
		.SPI_DW(SPI_DW),
		.SPI_DR(SPI_DR),
		/* AFC DAC signals */
		.AFC_DAC_CS(AFC_DAC_CS),
		.AFC_DAC_SCLK(AFC_DAC_SCLK),
		.AFC_DAC_LDAC(AFC_DAC_LDAC),
		.AFC_DAC_DIN(AFC_DAC_DIN),
		// REF_CLK
		.adc_clk_32mhz(adc_clk_32mhz),
		.gpio_rf(gpio_rf),
		// ADC
		.ADC_CLK(ADC_CLK),
		.ADC_I(adc_i),
		.ADC_Q(adc_q)
		/* LED */
		/*.LED_0(LED_0),
		.LED_1(LED_1),
		.LED_2(LED_2),
		.LED_3(LED_3),
		.LED_4(LED_4),
		.LED_5(LED_5)*/
        );
    
    assign sel_adc = md_vio[0] ? sel_adc_vio : DBG_SW[3:0];
    
    reg clk_rf_2x_reg;
    assign clk_rf_2x = clk_rf_2x_reg;
    
    always @ (posedge clk_rf_4x or negedge resetn) begin
        if (!resetn) begin
            adc_clk_32mhz <= 6'd0;
            adc_i <= 12'd0;
            adc_q <= 12'd0;
            dl_valid_reg[1][0] <= 1'b0;
            dl_valid_reg[1][1] <= 1'b0;
            dl_valid_reg[0][0] <= 1'b0;
            dl_valid_reg[0][1] <= 1'b0;
            clk_rf_2x_reg <= 1'b0;
        end
        else begin // clk
            adc_clk_32mhz <= adc_clk_32mhz + 6'd1;
            clk_rf_2x_reg <= ~clk_rf_2x_reg;
            dl_valid_reg[1][1] <= dl_valid_reg[1][0];
            dl_valid_reg[0][1] <= dl_valid_reg[0][0];
            //if (adc_clk_32mhz[1:0] == 2'b01) begin // 30.72 MHz
            if (adc_clk_32mhz[4:0] == 5'b01000) begin // 3.84 MHz
                case (sel_adc[1:0])
                2'b00: begin // Rx0
                    adc_i <= DL_RX0_I;
                    adc_q <= DL_RX0_Q;
                    dl_valid_reg[1][0] <= 1'b0;
                    dl_valid_reg[0][0] <= 1'b1;
                end
                2'b01: begin // Rx2
                    adc_i <= DL_RX1_I;
                    adc_q <= DL_RX1_Q;
                    dl_valid_reg[1][0] <= 1'b1;
                    dl_valid_reg[0][0] <= 1'b0;
                end
                2'b10: begin // Rx1
                    adc_i <= UL_RX0_I;
                    adc_q <= UL_RX0_Q;
                    dl_valid_reg[1][0] <= 1'b0;
                    dl_valid_reg[0][0] <= 1'b0;
                end
                default : begin // Rx3
                    adc_i <= UL_RX1_I;
                    adc_q <= UL_RX1_Q;
                    dl_valid_reg[1][0] <= 1'b0;
                    dl_valid_reg[0][0] <= 1'b0;
                end
                endcase
            end
            else begin
                dl_valid_reg[1][0] <= 1'b0;
                dl_valid_reg[0][0] <= 1'b0;
            end
        end
    end
    
    assign dl_valid_1 = dl_valid_reg[0][1];
    assign dl_i_1 = dl_valid_1 ? adc_i : 12'd0;
    assign dl_q_1 = dl_valid_1 ? adc_q : 12'd0;
    assign dl_valid_2 = dl_valid_reg[1][1];
    assign dl_i_2 = dl_valid_2 ? adc_i : 12'd0;
    assign dl_q_2 = dl_valid_2 ? adc_q : 12'd0;
    
    assign ADC_CLK = adc_clk_32mhz[4]; // 3.84 MHz
    assign DBG_LED = DBG_SW;
    
    afcdac_if afcdac_if_0 (
        /* Clock and Reset*/
        .clk_61(clk_61),
        .clk_122(clk_122),
        .resetn(resetn),
        //
        .sel_src(md_vio[1]),
        .afc_16b_vio(afc_16b_vio),
        /* RPI SPI signals : input */
        .RPI_CS(RPI_CS1),
        .RPI_CK(RPI_CK),
        .RPI_MOSI(RPI_MOSI),
        .RPI_MISO(RPI_MISO_CS1),
        /* AFC DAC signals */
        .DAC_CS(AFC_DAC_CS),
        .DAC_CK(AFC_DAC_SCLK),
        .DAC_LD(AFC_DAC_LDAC),
        .DAC_DW(AFC_DAC_DIN)
        ); // afcdac_if
   
    vio vio_0 ( // Added for error-free communication with HYU LPC.
        .clk(clk_61),
        .probe_in0(DBG_SW[3:0]), 
        .probe_out0(md_vio),
        .probe_out1(sel_adc_vio),
        .probe_out2(afc_16b_vio)
        ); // vio_0   
    
    wire clk_26mhz;

    BUFG u_bufg_26mhz (
        .I(VCTCXO_CLK),
        .O(clk_26mhz)
        ); // u_bufg_26mhz

    syspll syspll_0 (
        // Clock out ports
        .clk_out1(clk_rf_4x),     // 122.88 MHz clock
        .clk_out2(clk_rf_7p68),
        //.clk_out2(clk_122),     // output clk_out2
        // Status and control signals
        .reset(reset), // input reset
        // Clock in ports
        .clk_in1(clk_26mhz)    // input clk_in1
        ); // u_syspll
        
    reg [5:0] rf_clk_32mhz;
    always @ (posedge clk_rf_4x or negedge resetn) begin
        if (!resetn) begin
            rf_clk_32mhz <= 6'd0;
        end
        else begin // clk
            rf_clk_32mhz <= rf_clk_32mhz + 6'd1;
        end
    end
    
    assign gpio_rf = rf_clk_32mhz[5:1];
    
endmodule
