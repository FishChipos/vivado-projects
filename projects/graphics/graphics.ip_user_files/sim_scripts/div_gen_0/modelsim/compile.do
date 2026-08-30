vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xbip_utils_v3_0_16
vlib modelsim_lib/msim/axi_utils_v2_0_12
vlib modelsim_lib/msim/xbip_pipe_v3_0_12
vlib modelsim_lib/msim/xbip_dsp48_wrapper_v3_0_7
vlib modelsim_lib/msim/mult_gen_v12_0_25
vlib modelsim_lib/msim/floating_point_v7_0_27
vlib modelsim_lib/msim/div_gen_v5_1_26
vlib modelsim_lib/msim/xil_defaultlib

vmap xpm modelsim_lib/msim/xpm
vmap xbip_utils_v3_0_16 modelsim_lib/msim/xbip_utils_v3_0_16
vmap axi_utils_v2_0_12 modelsim_lib/msim/axi_utils_v2_0_12
vmap xbip_pipe_v3_0_12 modelsim_lib/msim/xbip_pipe_v3_0_12
vmap xbip_dsp48_wrapper_v3_0_7 modelsim_lib/msim/xbip_dsp48_wrapper_v3_0_7
vmap mult_gen_v12_0_25 modelsim_lib/msim/mult_gen_v12_0_25
vmap floating_point_v7_0_27 modelsim_lib/msim/floating_point_v7_0_27
vmap div_gen_v5_1_26 modelsim_lib/msim/div_gen_v5_1_26
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xpm  -incr -mfcu  -sv "+incdir+../../../../../../../../../AMDDesignTools/2026.1/Vivado/data/rsb/busdef" \
"D:/AMDDesignTools/2026.1/Vivado/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm  -93  \
"D:/AMDDesignTools/2026.1/Vivado/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xbip_utils_v3_0_16  -93  \
"../../../ipstatic/hdl/xbip_utils_v3_0_rfs.vhd" \

vcom -work axi_utils_v2_0_12  -93  \
"../../../ipstatic/hdl/axi_utils_v2_0_vh_rfs.vhd" \

vcom -work xbip_pipe_v3_0_12  -93  \
"../../../ipstatic/hdl/xbip_pipe_v3_0_rfs.vhd" \

vcom -work xbip_dsp48_wrapper_v3_0_7  -93  \
"../../../ipstatic/hdl/xbip_dsp48_wrapper_v3_0_vh_rfs.vhd" \

vcom -work mult_gen_v12_0_25  -93  \
"../../../ipstatic/hdl/mult_gen_v12_0_rfs.vhd" \

vcom -work floating_point_v7_0_27  -93  \
"../../../ipstatic/hdl/floating_point_v7_0_vh_rfs.vhd" \

vcom -work div_gen_v5_1_26  -93  \
"../../../ipstatic/hdl/div_gen_v5_1_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93  \
"../../../../src/ip/div_gen_0/sim/div_gen_0.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

