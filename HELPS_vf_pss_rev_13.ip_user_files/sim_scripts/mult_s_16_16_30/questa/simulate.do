onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib mult_s_16_16_30_opt

do {wave.do}

view wave
view structure
view signals

do {mult_s_16_16_30.udo}

run -all

quit -force
