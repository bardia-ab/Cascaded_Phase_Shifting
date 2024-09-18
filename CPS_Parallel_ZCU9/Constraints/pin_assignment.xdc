####### LEDs
set_property -dict {PACKAGE_PIN AB10 IOSTANDARD LVCMOS18 DRIVE 4 SLEW SLOW} [get_ports {o_led[0]}]
set_property -dict {PACKAGE_PIN AB11 IOSTANDARD LVCMOS18 DRIVE 4 SLEW SLOW} [get_ports {o_led[1]}]
set_property -dict {PACKAGE_PIN AA8 IOSTANDARD LVCMOS18 DRIVE 4 SLEW SLOW} [get_ports {o_led[2]}]
set_property -dict {PACKAGE_PIN AC9 IOSTANDARD LVCMOS18 DRIVE 4 SLEW SLOW} [get_ports {o_led[3]}]

######## UART Tx
# set_property -dict {PACKAGE_PIN AJ12 IOSTANDARD LVCMOS18 DRIVE 4 SLEW SLOW} [get_ports o_tx]
set_property -dict {PACKAGE_PIN AE1 IOSTANDARD LVCMOS18} [get_ports o_tx]
set_property -dict {PACKAGE_PIN Y10 IOSTANDARD LVCMOS18} [get_ports o_tx_dir]

######## UART Rx
# set_property -dict {PACKAGE_PIN AJ10 IOSTANDARD LVCMOS18} [get_ports i_rx]
set_property -dict {PACKAGE_PIN AE7 IOSTANDARD LVCMOS18} [get_ports i_rx]
set_property -dict {PACKAGE_PIN Y7 IOSTANDARD LVCMOS18} [get_ports o_rx_dir]
