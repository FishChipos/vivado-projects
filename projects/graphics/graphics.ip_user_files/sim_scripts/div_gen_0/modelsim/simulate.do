onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc"  -L xil_defaultlib -L xpm -L xbip_utils_v3_0_16 -L axi_utils_v2_0_12 -L xbip_pipe_v3_0_12 -L xbip_dsp48_wrapper_v3_0_7 -L mult_gen_v12_0_25 -L floating_point_v7_0_27 -L div_gen_v5_1_26 -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.div_gen_0 xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {div_gen_0.udo}

run 1000ns

quit -force
