onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib add_u_19_19_20_opt

do {wave.do}

view wave
view structure
view signals

do {add_u_19_19_20.udo}

run -all

quit -force
