proc add_srcs {src_dir fileset} {
  set obj [get_filesets $fileset]

  # set the lists of source files
  set files [glob -dir $src_dir *]

  # add sources to the fileset
  add_files -fileset $obj $files

}

set xil_proj_name CPS_Parallel_ZCU9
set part xczu9eg-ffvc900-1-e
set origin_dir .
set src_dir srcs
set const_dir constraints

# create project
create_project -force $xil_proj_name vivado_proj -part $part
set_property target_language VHDL [current_project]

# add VHDL source files
# srcs/cm_controller.vhd
# srcs/Edge_Detector.vhd
# srcs/UART_Rx.vhd
# srcs/UART_Tx.vhd
# srcs/binary_counter.vhd
# srcs/fifo_axi.vhd
# srcs/uart_buffered.vhd
# srcs/my_package.vhd
# srcs/init_ps.vhd
# srcs/threshold_detector.vhd
# srcs/ora.vhd
# srcs/sample_controller.vhd
# srcs/system_controller.vhd
# srcs/CUT_Buff.vhd
# srcs/transmit_controller.vhd
# srcs/char_system.vhd
# srcs/instruction_controller.vhd
# srcs/top.vhd

set VHDL_fileset sources_1
add_srcs $src_dir $VHDL_fileset

# set VHDL 2008
set VHDL2008_files [list {my_package.vhd} {char_system.vhd} {CUT_Buff.vhd} {CUTs.vhd}]
foreach fileName $VHDL2008_files {
  set_property file_type {VHDL 2008} [get_files -of_objects [get_filesets $VHDL_fileset] "$src_dir/$fileName"]
}

# add constraint files
set const_fileset constrs_1
add_srcs $const_dir $const_fileset

# create block design
create_bd_design "design_1"
update_compile_order -fileset $VHDL_fileset

# add top module
create_bd_cell -type module -reference top top_0

# set top module properties
set_property -dict {CONFIG.g_O2 16} [get_bd_cells top_0]
set_property -dict {CONFIG.g_cntr_width 10} [get_bd_cells top_0]
set_property -dict {CONFIG.g_res_factor 15} [get_bd_cells top_0]
set_property -dict {CONFIG.g_segments 1} [get_bd_cells top_0]
set_property -dict {CONFIG.g_n_parallel 50} [get_bd_cells top_0]
set_property -dict {CONFIG.g_n_partial 0} [get_bd_cells top_0]
set_property -dict {CONFIG.g_offset 5000} [get_bd_cells top_0]
set_property -dict {CONFIG.g_rx_fifo_depth 512} [get_bd_cells top_0]
set_property -dict {CONFIG.g_tx_fifo_depth 2048} [get_bd_cells top_0]
set_property -dict {CONFIG.g_parity {"0"}} [get_bd_cells top_0]
set_property -dict {CONFIG.g_n_bits 8} [get_bd_cells top_0]
set_property -dict {CONFIG.g_baud_rate 230400} [get_bd_cells top_0]
set_property -dict {CONFIG.g_frequency 100000000} [get_bd_cells top_0]
set_property -dict {CONFIG.POLARITY {ACTIVE_HIGH}} [get_bd_pins /top_0/o_cm_1_reset]
set_property -dict {CONFIG.POLARITY {ACTIVE_HIGH}} [get_bd_pins /top_0/o_cm_2_reset]
set_property -dict {CONFIG.POLARITY {ACTIVE_HIGH}} [get_bd_pins /top_0/o_cm_3_reset]

# create MMCM_0
set MMCM_0 [create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0]
set_property -dict [list \
CONFIG.PRIM_IN_FREQ.VALUE_SRC PROPAGATED \
CONFIG.USE_DYN_PHASE_SHIFT {true} \
CONFIG.PRIM_SOURCE {Single_ended_clock_capable_pin} \
CONFIG.CLK_OUT1_PORT {clk_launch_in} \
CONFIG.OVERRIDE_MMCM {true} \
CONFIG.MMCM_CLKFBOUT_MULT_F {15.000} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {15.000} \
CONFIG.CLK_OUT1_USE_FINE_PS_GUI {true} \
CONFIG.CLKOUT1_MATCHED_ROUTING {true} \
CONFIG.MMCM_CLKOUT0_USE_FINE_PS {true} \
CONFIG.CLKOUT2_USED {true}  \
CONFIG.CLK_OUT2_PORT {clk_sample_in} \
CONFIG.CLKOUT2_MATCHED_ROUTING {true} \
CONFIG.NUM_OUT_CLKS {2} \
CONFIG.MMCM_CLKOUT1_DIVIDE {15} \
CONFIG.CLKOUT2_JITTER {74.094} \
CONFIG.CLKOUT2_PHASE_ERROR {87.180}
] $MMCM_0

# create MMCM_1
set MMCM_1 [create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_1]
set_property -dict [list \
CONFIG.USE_PHASE_ALIGNMENT {true} \
CONFIG.USE_DYN_PHASE_SHIFT {true} \
CONFIG.CLK_OUT1_USE_FINE_PS_GUI {true} \
CONFIG.CLK_OUT1_PORT {clk_launch} \
CONFIG.OVERRIDE_MMCM {true} \
CONFIG.MMCM_CLKFBOUT_MULT_F {16.000} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {16.000} \
CONFIG.SECONDARY_SOURCE {Single_ended_clock_capable_pin} \
CONFIG.CLKOUT1_DRIVES {Buffer} \
CONFIG.CLKOUT2_DRIVES {Buffer} \
CONFIG.CLKOUT3_DRIVES {Buffer} \
CONFIG.CLKOUT4_DRIVES {Buffer} \
CONFIG.CLKOUT5_DRIVES {Buffer} \
CONFIG.CLKOUT6_DRIVES {Buffer} \
CONFIG.CLKOUT7_DRIVES {Buffer} \
CONFIG.MMCM_CLKOUT0_USE_FINE_PS {true}
] $MMCM_1

# create MMCM_2
set MMCM_2 [create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_2]
set_property -dict [list \
CONFIG.USE_PHASE_ALIGNMENT {true} \
CONFIG.CLK_OUT1_PORT {clk_sample} \
CONFIG.OVERRIDE_MMCM {true} \
CONFIG.MMCM_CLKFBOUT_MULT_F {16.000} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {16.000} \
CONFIG.SECONDARY_SOURCE {Single_ended_clock_capable_pin} \
CONFIG.CLKOUT1_DRIVES {Buffer} \
CONFIG.CLKOUT2_DRIVES {Buffer} \
CONFIG.CLKOUT3_DRIVES {Buffer} \
CONFIG.CLKOUT4_DRIVES {Buffer} \
CONFIG.CLKOUT5_DRIVES {Buffer} \
CONFIG.CLKOUT6_DRIVES {Buffer} \
CONFIG.CLKOUT7_DRIVES {Buffer}
] $MMCM_2

# create zynq
create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.3 zynq_ultra_ps_e_0
set_property -dict [list CONFIG.PSU__PSS_REF_CLK__FREQMHZ {33.333333}] [get_bd_cells zynq_ultra_ps_e_0]

# create rx dir constant
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0
set_property -dict [list CONFIG.CONST_VAL {0}] [get_bd_cells xlconstant_0]

# create tx dir constant
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1

# Create ports
create_bd_port -dir I i_rx
create_bd_port -dir O o_tx
create_bd_port -dir O o_led
create_bd_port -dir O o_rx_dir
create_bd_port -dir O o_tx_dir

# Create port connections
connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/maxihpm0_lpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0]
connect_bd_net [get_bd_pins clk_wiz_0/clk_launch_in] [get_bd_pins clk_wiz_1/clk_in1] [get_bd_pins top_0/i_clk_launch_in]
connect_bd_net [get_bd_pins clk_wiz_0/clk_sample_in] [get_bd_pins clk_wiz_2/clk_in1] [get_bd_pins top_0/i_clk_sample_in]
connect_bd_net [get_bd_pins clk_wiz_0/locked] [get_bd_pins top_0/i_cm_1_locked]
connect_bd_net [get_bd_pins clk_wiz_0/psdone] [get_bd_pins top_0/i_cm_1_psdone]
connect_bd_net [get_bd_pins clk_wiz_1/clk_launch] [get_bd_pins top_0/i_clk_launch]
connect_bd_net [get_bd_pins clk_wiz_1/locked] [get_bd_pins top_0/i_cm_2_locked]
connect_bd_net [get_bd_pins clk_wiz_1/psdone] [get_bd_pins top_0/i_cm_2_psdone]
connect_bd_net [get_bd_pins clk_wiz_2/clk_sample] [get_bd_pins top_0/i_clk_sample]
connect_bd_net [get_bd_pins clk_wiz_2/locked] [get_bd_pins top_0/i_cm_3_locked]
connect_bd_net [get_bd_pins clk_wiz_0/clk_in1] [get_bd_pins clk_wiz_0/psclk] [get_bd_pins clk_wiz_1/psclk] [get_bd_pins top_0/i_clk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0]
connect_bd_net [get_bd_ports i_Rx] [get_bd_pins top_0/i_rx]
connect_bd_net [get_bd_pins clk_wiz_0/psen] [get_bd_pins top_0/o_cm_1_psen]
connect_bd_net [get_bd_pins clk_wiz_1/psen] [get_bd_pins top_0/o_cm_2_psen]
connect_bd_net [get_bd_pins clk_wiz_0/psincdec] [get_bd_pins top_0/o_cm_1_psincdec]
connect_bd_net [get_bd_pins clk_wiz_1/psincdec] [get_bd_pins top_0/o_cm_2_psincdec]
connect_bd_net [get_bd_pins clk_wiz_0/reset] [get_bd_pins top_0/o_cm_1_reset]
connect_bd_net [get_bd_pins clk_wiz_1/reset] [get_bd_pins top_0/o_cm_2_reset]
connect_bd_net [get_bd_pins clk_wiz_2/reset] [get_bd_pins top_0/o_cm_3_reset]
connect_bd_net [get_bd_ports o_Tx] [get_bd_pins top_0/o_tx]
connect_bd_net [get_bd_ports o_led] [get_bd_pins top_0/o_led]
connect_bd_net [get_bd_ports o_rx_dir] [get_bd_pins xlconstant_0/dout]
connect_bd_net [get_bd_ports o_tx_dir] [get_bd_pins xlconstant_1/dout]

# update block design
update_module_reference design_1_top_0_0

# validate design
validate_bd_design

# create wrapper
make_wrapper -files [get_files "$origin_dir/vivado_proj/$xil_proj_name.srcs/sources_1/bd/design_1/design_1.bd"] -top
add_files -norecurse "$origin_dir/vivado_proj/$xil_proj_name.gen/sources_1/bd/design_1/hdl/design_1_wrapper.vhd"
update_compile_order -fileset sources_1
set_property top design_1_wrapper [current_fileset]
