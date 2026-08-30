transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xpm
vlib riviera/xbip_utils_v3_0_16
vlib riviera/axi_utils_v2_0_12
vlib riviera/xbip_pipe_v3_0_12
vlib riviera/xbip_dsp48_wrapper_v3_0_7
vlib riviera/mult_gen_v12_0_25
vlib riviera/floating_point_v7_0_27
vlib riviera/div_gen_v5_1_26
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xbip_utils_v3_0_16 riviera/xbip_utils_v3_0_16
vmap axi_utils_v2_0_12 riviera/axi_utils_v2_0_12
vmap xbip_pipe_v3_0_12 riviera/xbip_pipe_v3_0_12
vmap xbip_dsp48_wrapper_v3_0_7 riviera/xbip_dsp48_wrapper_v3_0_7
vmap mult_gen_v12_0_25 riviera/mult_gen_v12_0_25
vmap floating_point_v7_0_27 riviera/floating_point_v7_0_27
vmap div_gen_v5_1_26 riviera/div_gen_v5_1_26
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -incr "+incdir+../../../../../../../../../AMDDesignTools/2026.1/Vivado/data/rsb/busdef" -l xpm -l xbip_utils_v3_0_16 -l axi_utils_v2_0_12 -l xbip_pipe_v3_0_12 -l xbip_dsp48_wrapper_v3_0_7 -l mult_gen_v12_0_25 -l floating_point_v7_0_27 -l div_gen_v5_1_26 -l xil_defaultlib \
"D:/AMDDesignTools/2026.1/Vivado/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93  -incr \
"D:/AMDDesignTools/2026.1/Vivado/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xbip_utils_v3_0_16 -93  -incr \
"../../../ipstatic/hdl/xbip_utils_v3_0_rfs.vhd" \

vcom -work axi_utils_v2_0_12 -93  -incr \
"../../../ipstatic/hdl/axi_utils_v2_0_vh_rfs.vhd" \

vcom -work xbip_pipe_v3_0_12 -93  -incr \
"../../../ipstatic/hdl/xbip_pipe_v3_0_rfs.vhd" \

vcom -work xbip_dsp48_wrapper_v3_0_7 -93  -incr \
"../../../ipstatic/hdl/xbip_dsp48_wrapper_v3_0_vh_rfs.vhd" \

vcom -work mult_gen_v12_0_25 -93  -incr \
"../../../ipstatic/hdl/mult_gen_v12_0_rfs.vhd" \

vcom -work floating_point_v7_0_27 -93  -incr \
"../../../ipstatic/hdl/floating_point_v7_0_vh_rfs.vhd" \

vcom -work div_gen_v5_1_26 -93  -incr \
"../../../ipstatic/hdl/div_gen_v5_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../../src/ip/div_gen_0/sim/div_gen_0.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

