set_property IOSTANDARD  LVCMOS18 [get_ports "AFC_DAC_*"]
set_property PACKAGE_PIN T7       [get_ports "AFC_DAC_LDAC"]
set_property PACKAGE_PIN V8       [get_ports "AFC_DAC_CS"]
set_property PACKAGE_PIN K12      [get_ports "AFC_DAC_DIN"] 
set_property PACKAGE_PIN U8       [get_ports "AFC_DAC_SCLK"]


set_property PACKAGE_PIN AH11     [get_ports "VCTCXO_CLK"]
set_property IOSTANDARD  LVCMOS18 [get_ports "VCTCXO_CLK"]
set_property CLOCK_DEDICATED_ROUTE FALSE  [get_nets VCTCXO_CLK_IBUF_inst/O]

#
# DRIVE 24 is not allowed in LCMOS18
# DRIVE 16 is not allowed in the I/O bank.
#
set_property PACKAGE_PIN V12      [get_ports "SPI_CS"]
set_property IOSTANDARD  LVCMOS18 [get_ports "SPI_CS"]
set_property SLEW  FAST [get_ports "SPI_CS"]
set_property DRIVE 12 [get_ports "SPI_CS"]
set_property PACKAGE_PIN V6       [get_ports "SPI_DR"]
set_property IOSTANDARD  LVCMOS18 [get_ports "SPI_DR"]
set_property PULLDOWN  TRUE [get_ports "SPI_DR"]
set_property PACKAGE_PIN T6       [get_ports "SPI_DW"]
set_property IOSTANDARD  LVCMOS18 [get_ports "SPI_DW"]
set_property SLEW  FAST [get_ports "SPI_DW"]
set_property DRIVE 12 [get_ports "SPI_DW"]
set_property PACKAGE_PIN V7       [get_ports "SPI_CK"]
set_property IOSTANDARD  LVCMOS18 [get_ports "SPI_CK"]
set_property SLEW  FAST [get_ports "SPI_CK"]
set_property DRIVE 12 [get_ports "SPI_CK"]

set_property IOSTANDARD  LVCMOS33 [get_ports "RPI_*"]
# PMOD1_4, J87.2, RPI.GPIO(8)
set_property PACKAGE_PIN F20      [get_ports "RPI_CS0"] 
# PMOD1_3, J87.7, RPI.GPIO(7)
set_property PACKAGE_PIN E22      [get_ports "RPI_CS1"]
# PMOD1_5, J87.4, RPI.GPIO(9)
set_property PULLUP  TRUE         [get_ports "RPI_MISO"]
set_property PACKAGE_PIN G20      [get_ports "RPI_MISO"] 
# PMOD1_6, J87.6, RPI.GPIO(10)
set_property PACKAGE_PIN J20      [get_ports "RPI_MOSI"]
# PMOD1_7, J87.8, RPI.GPIO(11)
set_property PACKAGE_PIN J19      [get_ports "RPI_CK"]

#set_property IOSTANDARD  LVCMOS33 [get_ports "UART_*"]
# PMOD1_0, J87.1, RPI.GPIO(14)
#set_property PACKAGE_PIN D20      [get_ports "UART_TXD"]
# PMOD1_1, J87.3, RPI.GPIO(15)
#set_property PACKAGE_PIN E20      [get_ports "UART_RXD"]
# PMOD1_2, J87.5, reserved
#set_property PACKAGE_PIN D22      [get_ports "Reserved"]

set_property IOSTANDARD  LVCMOS18 [get_ports "GPR*"]
set_property PACKAGE_PIN U6       [get_ports "GPR[0]"]
set_property PACKAGE_PIN U11      [get_ports "GPR[1]"]
set_property PACKAGE_PIN T11      [get_ports "GPR[2]"]
set_property PACKAGE_PIN T13      [get_ports "GPR[3]"]
set_property PACKAGE_PIN R13      [get_ports "GPR[4]"]


# ADC
set_property IOSTANDARD  LVCMOS18 [get_ports "DL_RX*"]
set_property IOSTANDARD  LVCMOS18 [get_ports "UL_RX*"]
set_property IOSTANDARD  LVCMOS18 [get_ports "ADC_CLK"]
set_property PACKAGE_PIN  Y4      [get_ports "ADC_CLK"]

# DL_RX0_I[11:0]
set_property PACKAGE_PIN AC2      [get_ports "DL_RX0_I[11]"]
set_property PACKAGE_PIN AC1      [get_ports "DL_RX0_I[10]"]
set_property PACKAGE_PIN  W5      [get_ports "DL_RX0_I[9]"]
set_property PACKAGE_PIN  W4      [get_ports "DL_RX0_I[8]"]
set_property PACKAGE_PIN AC7      [get_ports "DL_RX0_I[7]"]
set_property PACKAGE_PIN AC6      [get_ports "DL_RX0_I[6]"]
set_property PACKAGE_PIN  N9      [get_ports "DL_RX0_I[5]"]
set_property PACKAGE_PIN  N8      [get_ports "DL_RX0_I[4]"]
set_property PACKAGE_PIN  M10     [get_ports "DL_RX0_I[3]"]
set_property PACKAGE_PIN  L10     [get_ports "DL_RX0_I[2]"]
set_property PACKAGE_PIN AB4      [get_ports "DL_RX0_I[1]"]
set_property PACKAGE_PIN AC4      [get_ports "DL_RX0_I[0]"]
# DL_RX0_Q[11:0]
set_property PACKAGE_PIN AB3      [get_ports "DL_RX0_Q[11]"]
set_property PACKAGE_PIN AC3      [get_ports "DL_RX0_Q[10]"]
set_property PACKAGE_PIN  W2      [get_ports "DL_RX0_Q[9]"]
set_property PACKAGE_PIN  W1      [get_ports "DL_RX0_Q[8]"]
set_property PACKAGE_PIN AB8      [get_ports "DL_RX0_Q[7]"]
set_property PACKAGE_PIN AC8      [get_ports "DL_RX0_Q[6]"]
set_property PACKAGE_PIN  P11     [get_ports "DL_RX0_Q[5]"]
set_property PACKAGE_PIN  N11     [get_ports "DL_RX0_Q[4]"]
set_property PACKAGE_PIN  L16     [get_ports "DL_RX0_Q[3]"]
set_property PACKAGE_PIN  K16     [get_ports "DL_RX0_Q[2]"]
set_property PACKAGE_PIN  L15     [get_ports "DL_RX0_Q[1]"]
set_property PACKAGE_PIN  K15     [get_ports "DL_RX0_Q[0]"]
# DL_RX1_I[11:0]
set_property PACKAGE_PIN  Y2      [get_ports "DL_RX1_I[11]"]
set_property PACKAGE_PIN  Y1      [get_ports "DL_RX1_I[10]"]
set_property PACKAGE_PIN  V4      [get_ports "DL_RX1_I[9]"]
set_property PACKAGE_PIN  V3      [get_ports "DL_RX1_I[8]"]
set_property PACKAGE_PIN  W7      [get_ports "DL_RX1_I[7]"]
set_property PACKAGE_PIN  W6      [get_ports "DL_RX1_I[6]"]
set_property PACKAGE_PIN  Y12     [get_ports "DL_RX1_I[5]"]
set_property PACKAGE_PIN AA12     [get_ports "DL_RX1_I[4]"]
set_property PACKAGE_PIN  N13     [get_ports "DL_RX1_I[3]"]
set_property PACKAGE_PIN  M13     [get_ports "DL_RX1_I[2]"]
set_property PACKAGE_PIN  M15     [get_ports "DL_RX1_I[1]"]
set_property PACKAGE_PIN  M14     [get_ports "DL_RX1_I[0]"]
# DL_RX1_Q[11:0]
set_property PACKAGE_PIN  V2      [get_ports "DL_RX1_Q[11]"]
set_property PACKAGE_PIN  V1      [get_ports "DL_RX1_Q[10]"]
set_property PACKAGE_PIN AA2      [get_ports "DL_RX1_Q[9]"]
set_property PACKAGE_PIN AA1      [get_ports "DL_RX1_Q[8]"]
set_property PACKAGE_PIN  U5      [get_ports "DL_RX1_Q[7]"]
set_property PACKAGE_PIN  U4      [get_ports "DL_RX1_Q[6]"]
set_property PACKAGE_PIN AB6      [get_ports "DL_RX1_Q[5]"]
set_property PACKAGE_PIN AB5      [get_ports "DL_RX1_Q[4]"]
set_property PACKAGE_PIN  Y10     [get_ports "DL_RX1_Q[3]"]
set_property PACKAGE_PIN  Y9      [get_ports "DL_RX1_Q[2]"]
set_property PACKAGE_PIN  L13     [get_ports "DL_RX1_Q[1]"]
set_property PACKAGE_PIN  K13     [get_ports "DL_RX1_Q[0]"]
# UL_RX0_I[11:0]
set_property PACKAGE_PIN AH2      [get_ports "UL_RX0_I[11]"]
set_property PACKAGE_PIN AJ2      [get_ports "UL_RX0_I[10]"]
set_property PACKAGE_PIN AH4      [get_ports "UL_RX0_I[9]"]
set_property PACKAGE_PIN AJ4      [get_ports "UL_RX0_I[8]"]
set_property PACKAGE_PIN AH7      [get_ports "UL_RX0_I[7]"]
set_property PACKAGE_PIN AH6      [get_ports "UL_RX0_I[6]"]
set_property PACKAGE_PIN  Y8      [get_ports "UL_RX0_I[5]"]
set_property PACKAGE_PIN  Y7      [get_ports "UL_RX0_I[4]"]
set_property PACKAGE_PIN  U10     [get_ports "UL_RX0_I[3]"]
set_property PACKAGE_PIN  T10     [get_ports "UL_RX0_I[2]"]
set_property PACKAGE_PIN AJ6      [get_ports "UL_RX0_I[1]"]
set_property PACKAGE_PIN AJ5      [get_ports "UL_RX0_I[0]"]
# UL_RX0_Q[11:0]
set_property PACKAGE_PIN AG3      [get_ports "UL_RX0_Q[11]"]
set_property PACKAGE_PIN AH3      [get_ports "UL_RX0_Q[10]"]
set_property PACKAGE_PIN AE2      [get_ports "UL_RX0_Q[9]"]
set_property PACKAGE_PIN AE1      [get_ports "UL_RX0_Q[8]"]
set_property PACKAGE_PIN AG8      [get_ports "UL_RX0_Q[7]"]
set_property PACKAGE_PIN AH8      [get_ports "UL_RX0_Q[6]"]
set_property PACKAGE_PIN  Y5      [get_ports "UL_RX0_Q[5]"]
set_property PACKAGE_PIN AA5      [get_ports "UL_RX0_Q[4]"]
set_property PACKAGE_PIN AE12     [get_ports "UL_RX0_Q[3]"]
set_property PACKAGE_PIN AF12     [get_ports "UL_RX0_Q[2]"]
set_property PACKAGE_PIN  T12     [get_ports "UL_RX0_Q[1]"]
set_property PACKAGE_PIN  R12     [get_ports "UL_RX0_Q[0]"]
# UL_RX1_I[11:0]
set_property PACKAGE_PIN AH1      [get_ports "UL_RX1_I[11]"]
set_property PACKAGE_PIN AJ1      [get_ports "UL_RX1_I[10]"]
set_property PACKAGE_PIN AE3      [get_ports "UL_RX1_I[9]"]
set_property PACKAGE_PIN AF3      [get_ports "UL_RX1_I[8]"]
set_property PACKAGE_PIN AD7      [get_ports "UL_RX1_I[7]"]
set_property PACKAGE_PIN AD6      [get_ports "UL_RX1_I[6]"]
set_property PACKAGE_PIN AG10     [get_ports "UL_RX1_I[5]"]
set_property PACKAGE_PIN AG9      [get_ports "UL_RX1_I[4]"]
set_property PACKAGE_PIN AB11     [get_ports "UL_RX1_I[3]"]
set_property PACKAGE_PIN AB10     [get_ports "UL_RX1_I[2]"]
set_property PACKAGE_PIN AF11     [get_ports "UL_RX1_I[1]"]
set_property PACKAGE_PIN AG11     [get_ports "UL_RX1_I[0]"]
# UL_RX1_Q[11:0]
set_property PACKAGE_PIN AD2      [get_ports "UL_RX1_Q[11]"]
set_property PACKAGE_PIN AD1      [get_ports "UL_RX1_Q[10]"]
set_property PACKAGE_PIN AF2      [get_ports "UL_RX1_Q[9]"]
set_property PACKAGE_PIN AF1      [get_ports "UL_RX1_Q[8]"]
set_property PACKAGE_PIN AD4      [get_ports "UL_RX1_Q[7]"]
set_property PACKAGE_PIN AE4      [get_ports "UL_RX1_Q[6]"]
set_property PACKAGE_PIN AE8      [get_ports "UL_RX1_Q[5]"]
set_property PACKAGE_PIN AF8      [get_ports "UL_RX1_Q[4]"]
set_property PACKAGE_PIN AD10     [get_ports "UL_RX1_Q[3]"]
set_property PACKAGE_PIN AE9      [get_ports "UL_RX1_Q[2]"]
set_property PACKAGE_PIN AA11     [get_ports "UL_RX1_Q[1]"]
set_property PACKAGE_PIN AA10     [get_ports "UL_RX1_Q[0]"]

set_property IOSTANDARD  LVCMOS33 [get_ports "DBG_LED*"]
set_property IOSTANDARD  LVCMOS33 [get_ports "DBG_SW*"]

set_property PACKAGE_PIN AG14     [get_ports "DBG_LED[0]"]
set_property PACKAGE_PIN AF13     [get_ports "DBG_LED[1]"]
set_property PACKAGE_PIN AE13     [get_ports "DBG_LED[2]"]
set_property PACKAGE_PIN AJ14     [get_ports "DBG_LED[3]"]
set_property PACKAGE_PIN AJ15     [get_ports "DBG_LED[4]"]
set_property PACKAGE_PIN AH13     [get_ports "DBG_LED[5]"]
set_property PACKAGE_PIN AH14     [get_ports "DBG_LED[6]"]
set_property PACKAGE_PIN AL12     [get_ports "DBG_LED[7]"]

set_property PACKAGE_PIN AN14     [get_ports "DBG_SW[0]"]
set_property PACKAGE_PIN AP14     [get_ports "DBG_SW[1]"]
set_property PACKAGE_PIN AM14     [get_ports "DBG_SW[2]"]
set_property PACKAGE_PIN AN13     [get_ports "DBG_SW[3]"]
set_property PACKAGE_PIN AN12     [get_ports "DBG_SW[4]"]
set_property PACKAGE_PIN AP12     [get_ports "DBG_SW[5]"]
set_property PACKAGE_PIN AL13     [get_ports "DBG_SW[6]"]
set_property PACKAGE_PIN AK13     [get_ports "DBG_SW[7]"]