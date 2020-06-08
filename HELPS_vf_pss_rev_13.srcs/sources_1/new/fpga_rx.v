`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 18:35:00
// Design Name: 
// Module Name: rx
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


module fpga_rx(
    input clk_ila,
    input resetn,
    
    input SPI_CS,
    input SPI_CK,
    input SPI_DW,
    input SPI_DR,
    
    input AFC_DAC_CS,
    input AFC_DAC_SCLK,
    input AFC_DAC_LDAC,
    input AFC_DAC_DIN,
    // ADC
    input ADC_CLK,
    input [11:0] ADC_I,
    input [11:0] ADC_Q,
    
    input [5:0] adc_clk_32mhz,
    input [4:0] gpio_rf
    );
    
    ila ila_0 (
        .clk(clk_ila),  // 122.88 MHz => 7.68 MHz
        .probe0(SPI_CS),
        .probe1(SPI_CK),
        .probe2(SPI_DW),
        .probe3(SPI_DR),
        .probe4(ADC_CLK),
        // 1 bit => 12 bits
        .probe5(ADC_I),
        .probe6(ADC_Q),
        .probe7(AFC_DAC_CS),
        //
        .probe8(gpio_rf[4]),
        .probe9(adc_clk_32mhz[5])
    );
        
    /*assign LED_0 = SPI_DO0 ? 1'b1 : 1'b0;
    assign LED_1 = SPI_DI0 ? 1'b1 : 1'b0;
    assign LED_2 = AFC_DAC_CS ? 1'b1 : 1'b0;
    assign LED_3 = AFC_DAC_DIN ? 1'b1 : 1'b0;
    assign LED_4 = GPR1 ? 1'b1 : 1'b0;
    assign LED_5 = GPR3 ? 1'b1 : 1'b0;*/
    
endmodule // rx
