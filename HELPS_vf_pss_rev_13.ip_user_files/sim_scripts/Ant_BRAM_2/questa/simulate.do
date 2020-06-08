onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib Ant_BRAM_2_opt

do {wave.do}

view wave
view structure
view signals

do {Ant_BRAM_2.udo}

run -all

quit -force
