onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+syspll -L xilinx_vip -L xil_defaultlib -L xpm -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.syspll xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {syspll.udo}

run -all

endsim

quit -force
