set_property SRC_FILE_INFO {cfile:d:/Desktop/Stuff/vivado-projects/projects/graphics/src/ip/clk_wiz_0/clk_wiz_0.xdc rfile:../../../src/ip/clk_wiz_0/clk_wiz_0.xdc id:1 order:EARLY scoped_inst:clk_wiz_0_inst/inst} [current_design]
set_property SRC_FILE_INFO {cfile:D:/Desktop/Stuff/vivado-projects/projects/graphics/constrs/main.xdc rfile:../../../constrs/main.xdc id:2} [current_design]
current_instance clk_wiz_0_inst/inst
set_property src_info {type:SCOPED_XDC file:1 line:54 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports sys_clk]] 0.080
current_instance
set_property src_info {type:XDC file:2 line:1 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN K17 IOSTANDARD LVCMOS33 } [get_ports { sys_clk }];
set_property src_info {type:XDC file:2 line:3 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN H17 IOSTANDARD TMDS_33 } [get_ports { tmds[clk_n] }];
set_property src_info {type:XDC file:2 line:4 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN H16 IOSTANDARD TMDS_33 } [get_ports { tmds[clk_p] }];
set_property src_info {type:XDC file:2 line:5 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN D20 IOSTANDARD TMDS_33 } [get_ports { tmds[data_n][0] }];
set_property src_info {type:XDC file:2 line:6 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN D19 IOSTANDARD TMDS_33 } [get_ports { tmds[data_p][0] }];
set_property src_info {type:XDC file:2 line:7 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN B20 IOSTANDARD TMDS_33 } [get_ports { tmds[data_n][1] }];
set_property src_info {type:XDC file:2 line:8 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN C20 IOSTANDARD TMDS_33 } [get_ports { tmds[data_p][1] }];
set_property src_info {type:XDC file:2 line:9 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN A20 IOSTANDARD TMDS_33 } [get_ports { tmds[data_n][2] }];
set_property src_info {type:XDC file:2 line:10 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN B19 IOSTANDARD TMDS_33 } [get_ports { tmds[data_p][2] }];
set_property src_info {type:XDC file:2 line:12 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN K18 IOSTANDARD LVCMOS33 } [get_ports { buttons[reset] }];
