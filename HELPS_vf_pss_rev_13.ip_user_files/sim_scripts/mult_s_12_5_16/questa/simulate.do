onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib mult_s_12_5_16_opt

do {wave.do}

view wave
view structure
view signals

do {mult_s_12_5_16.udo}

run -all

quit -force
