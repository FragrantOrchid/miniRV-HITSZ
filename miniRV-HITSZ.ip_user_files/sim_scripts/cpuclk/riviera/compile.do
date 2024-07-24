vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../ipstatic" \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" \
"../../../../../../../../Lab2-CPUSoC/proj_miniRV/proj_miniRV/proj_single_cycle/proj_single_cycle.srcs/sources/cpuclk/cpuclk_clk_wiz.v" \
"../../../../../../../../Lab2-CPUSoC/proj_miniRV/proj_miniRV/proj_single_cycle/proj_single_cycle.srcs/sources/cpuclk/cpuclk.v" \

vlog -work xil_defaultlib \
"glbl.v"

