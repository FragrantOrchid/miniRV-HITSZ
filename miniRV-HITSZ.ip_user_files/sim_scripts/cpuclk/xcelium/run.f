-makelib xcelium_lib/xil_defaultlib -sv \
  "D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../../../../../Lab2-CPUSoC/proj_miniRV/proj_miniRV/proj_single_cycle/proj_single_cycle.srcs/sources/cpuclk/cpuclk_clk_wiz.v" \
  "../../../../../../../../Lab2-CPUSoC/proj_miniRV/proj_miniRV/proj_single_cycle/proj_single_cycle.srcs/sources/cpuclk/cpuclk.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib
