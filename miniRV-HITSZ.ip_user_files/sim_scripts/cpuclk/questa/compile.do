vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../ipstatic" \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic" \
"../../../../../../../../Lab2-CPUSoC/proj_miniRV/proj_miniRV/proj_single_cycle/proj_single_cycle.srcs/sources/cpuclk/cpuclk_clk_wiz.v" \
"../../../../../../../../Lab2-CPUSoC/proj_miniRV/proj_miniRV/proj_single_cycle/proj_single_cycle.srcs/sources/cpuclk/cpuclk.v" \

vlog -work xil_defaultlib \
"glbl.v"

