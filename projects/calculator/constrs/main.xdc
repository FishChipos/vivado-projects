create_clock -add -name clk_pin -period 8.00 -waveform {0 4} [get_ports clk]

set_property -dict { \
    IOSTANDARD LVCMOS33 \
    PACKAGE_PIN K17 \
} [get_ports clk]

set_property -dict { \
    IOSTANDARD LVCMOS33 \
    PACKAGE_PIN K18 \
} [get_ports rst]

set_property -dict { \
    IOSTANDARD LVCMOS33 \
    PACKAGE_PIN Y16 \
} [get_ports {buttons[back]}]

set_property -dict { \
    IOSTANDARD LVCMOS33 \
    PACKAGE_PIN K19 \
} [get_ports {buttons[fwd]}]

set_property -dict { \
    IOSTANDARD LVCMOS33 \
    PACKAGE_PIN P16 \
} [get_ports {buttons[cycle_mode]}]

set_property -dict { \
    IOSTANDARD LVCMOS33 \
    PACKAGE_PIN G15 \
} [get_ports {switches[0]}]

set_property -dict { \
    IOSTANDARD LVCMOS33 \
    PACKAGE_PIN P15 \
} [get_ports {switches[1]}]

set_property -dict { \
    IOSTANDARD LVCMOS33 \
    PACKAGE_PIN W13 \
} [get_ports {switches[2]}]

set_property -dict { \
    IOSTANDARD LVCMOS33 \
    PACKAGE_PIN T16 \
} [get_ports {switches[3]}]

set_property -dict { \
    IOSTANDARD LVCMOS33 \
    PACKAGE_PIN M14 \
    DRIVE 12 \
    SLEW SLOW \
} [get_ports {leds[0]}]

set_property -dict { \
    IOSTANDARD LVCMOS33 \
    PACKAGE_PIN M15 \
    DRIVE 12 \
    SLEW SLOW \
} [get_ports {leds[1]}]

set_property -dict { \
    IOSTANDARD LVCMOS33 \
    PACKAGE_PIN G14 \
    DRIVE 12 \
    SLEW SLOW \
} [get_ports {leds[2]}]

set_property -dict { \
    IOSTANDARD LVCMOS33 \
    PACKAGE_PIN D18 \
    DRIVE 12 \
    SLEW SLOW \
} [get_ports {leds[3]}]

set_property -dict { \
    IOSTANDARD LVCMOS33 \
    PACKAGE_PIN V16 \
    DRIVE 12 \
    SLEW SLOW \
} [get_ports {rgb_led_pins[r]}]

set_property -dict { \
    IOSTANDARD LVCMOS33 \
    PACKAGE_PIN F17 \
    DRIVE 12 \
    SLEW SLOW \
} [get_ports {rgb_led_pins[g]}]

set_property -dict { \
    IOSTANDARD LVCMOS33 \
    PACKAGE_PIN M17 \
    DRIVE 12 \
    SLEW SLOW \
} [get_ports {rgb_led_pins[b]}]
