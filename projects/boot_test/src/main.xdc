create_clock -add -name clk_pin -period 8.00 -waveform {0 4} [get_ports clk]

set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN K17 } [get_ports clk]

set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN G15 } [get_ports toggle]

set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN M14 DRIVE 12 SLEW SLOW } [get_ports led]
