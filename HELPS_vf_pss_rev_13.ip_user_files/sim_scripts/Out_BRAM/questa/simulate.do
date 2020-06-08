onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib Out_BRAM_opt

do {wave.do}

view wave
view structure
view signals

do {Out_BRAM.udo}

run -all

quit -force
