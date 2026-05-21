vlib work
vmap work work

vlib simprims_ver
vlib unisims_ver
vlib unimacro_ver

vlog -work unisims_ver /opt/Xilinx/14.7/ISE_DS/ISE/verilog/src/unisims/*.v
vlog -work simprims_ver /opt/Xilinx/14.7/ISE_DS/ISE/verilog/src/simprims/*.v
vlog -work unimacro_ver /opt/Xilinx/14.7/ISE_DS/ISE/verilog/src/unimacro/*.v

vlog DPD_timesim.v
vlog glbl.v

vcom -93 functions.vhd
vcom -93 tb_main.vhd
