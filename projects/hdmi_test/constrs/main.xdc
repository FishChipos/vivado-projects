# No need to use create_clock as the clocking wizard will do that for us, we just set the pin.
set_property -dict { PACKAGE_PIN K17 IOSTANDARD LVCMOS33 } [get_ports { sys_clk }];

set_property -dict { PACKAGE_PIN H17 IOSTANDARD TMDS_33 } [get_ports { tmds[clk_n] }];
set_property -dict { PACKAGE_PIN H16 IOSTANDARD TMDS_33 } [get_ports { tmds[clk_p] }];
set_property -dict { PACKAGE_PIN D20 IOSTANDARD TMDS_33 } [get_ports { tmds[data_n][0] }];
set_property -dict { PACKAGE_PIN D19 IOSTANDARD TMDS_33 } [get_ports { tmds[data_p][0] }];
set_property -dict { PACKAGE_PIN B20 IOSTANDARD TMDS_33 } [get_ports { tmds[data_n][1] }];
set_property -dict { PACKAGE_PIN C20 IOSTANDARD TMDS_33 } [get_ports { tmds[data_p][1] }];
set_property -dict { PACKAGE_PIN A20 IOSTANDARD TMDS_33 } [get_ports { tmds[data_n][2] }];
set_property -dict { PACKAGE_PIN B19 IOSTANDARD TMDS_33 } [get_ports { tmds[data_p][2] }];

set_property -dict { PACKAGE_PIN K18 IOSTANDARD LVCMOS33 } [get_ports { rst }];
set_property -dict { PACKAGE_PIN Y16 IOSTANDARD LVCMOS33 } [get_ports { buttons[cycle_pattern] }];
