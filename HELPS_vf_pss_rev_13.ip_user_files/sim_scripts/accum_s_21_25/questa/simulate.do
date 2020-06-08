onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib accum_s_21_25_opt

do {wave.do}

view wave
view structure
view signals

do {accum_s_21_25.udo}

run -all

quit -force
