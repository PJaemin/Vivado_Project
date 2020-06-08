onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib Seq_BRAM_opt

do {wave.do}

view wave
view structure
view signals

do {Seq_BRAM.udo}

run -all

quit -force
