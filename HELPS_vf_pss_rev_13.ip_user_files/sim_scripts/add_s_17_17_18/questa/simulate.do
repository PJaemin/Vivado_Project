onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib add_s_17_17_18_opt

do {wave.do}

view wave
view structure
view signals

do {add_s_17_17_18.udo}

run -all

quit -force
