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

#  SD 0 / data[3] / mio[45]
set_property iostandard "LVCMOS33" [get_ports "mio[45]"]
set_property PACKAGE_PIN "B15" [get_ports "mio[45]"]
set_property slew "slow" [get_ports "mio[45]"]
set_property drive "8" [get_ports "mio[45]"]
set_property pullup "TRUE" [get_ports "mio[45]"]
set_property PIO_DIRECTION "BIDIR" [get_ports "mio[45]"]
#  SD 0 / data[2] / mio[44]
set_property iostandard "LVCMOS33" [get_ports "mio[44]"]
set_property PACKAGE_PIN "F13" [get_ports "mio[44]"]
set_property slew "slow" [get_ports "mio[44]"]
set_property drive "8" [get_ports "mio[44]"]
set_property pullup "TRUE" [get_ports "mio[44]"]
set_property PIO_DIRECTION "BIDIR" [get_ports "mio[44]"]
#  SD 0 / data[1] / mio[43]
set_property iostandard "LVCMOS33" [get_ports "mio[43]"]
set_property PACKAGE_PIN "A9" [get_ports "mio[43]"]
set_property slew "slow" [get_ports "mio[43]"]
set_property drive "8" [get_ports "mio[43]"]
set_property pullup "TRUE" [get_ports "mio[43]"]
set_property PIO_DIRECTION "BIDIR" [get_ports "mio[43]"]
#  SD 0 / data[0] / mio[42]
set_property iostandard "LVCMOS33" [get_ports "mio[42]"]
set_property PACKAGE_PIN "E12" [get_ports "mio[42]"]
set_property slew "slow" [get_ports "mio[42]"]
set_property drive "8" [get_ports "mio[42]"]
set_property pullup "TRUE" [get_ports "mio[42]"]
set_property PIO_DIRECTION "BIDIR" [get_ports "mio[42]"]
#  SD 0 / cmd / mio[41]
set_property iostandard "LVCMOS33" [get_ports "mio[41]"]
set_property PACKAGE_PIN "C17" [get_ports "mio[41]"]
set_property slew "slow" [get_ports "mio[41]"]
set_property drive "8" [get_ports "mio[41]"]
set_property pullup "TRUE" [get_ports "mio[41]"]
set_property PIO_DIRECTION "BIDIR" [get_ports "mio[41]"]
#  SD 0 / clk / mio[40]
set_property iostandard "LVCMOS33" [get_ports "mio[40]"]
set_property PACKAGE_PIN "D14" [get_ports "mio[40]"]
set_property slew "slow" [get_ports "mio[40]"]
set_property drive "8" [get_ports "mio[40]"]
set_property pullup "TRUE" [get_ports "mio[40]"]
set_property PIO_DIRECTION "BIDIR" [get_ports "mio[40]"]
set_property iostandard "LVCMOS33" [get_ports "ps_porb"]
set_property PACKAGE_PIN "C7" [get_ports "ps_porb"]
set_property slew "fast" [get_ports "ps_porb"]
set_property iostandard "LVCMOS33" [get_ports "ps_srstb"]
set_property PACKAGE_PIN "B10" [get_ports "ps_srstb"]
set_property slew "fast" [get_ports "ps_srstb"]
set_property iostandard "LVCMOS33" [get_ports "ps_clk"]
set_property PACKAGE_PIN "E7" [get_ports "ps_clk"]
set_property slew "fast" [get_ports "ps_clk"]

