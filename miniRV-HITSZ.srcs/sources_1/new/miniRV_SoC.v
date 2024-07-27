`timescale 1ns / 1ps

`include "defines.vh"

module miniRV_SoC (
    input  wire         fpga_rst,   // High active
    input  wire         fpga_clk,

    input  wire [23:0]  sw,
    input  wire [ 4:0]  button,
    output wire [ 7:0]  dig_en,
    output wire         DN_A,
    output wire         DN_B,
    output wire         DN_C,
    output wire         DN_D,
    output wire         DN_E,
    output wire         DN_F,
    output wire         DN_G,
    output wire         DN_DP,
    output wire [23:0]  led

`ifdef RUN_TRACE
    ,// Debug Interface
    output wire         debug_wb_have_inst, // 当前时钟周期是否有指令写回 (对单周期CPU，可在复位后恒置1)
    output wire [31:0]  debug_wb_pc,        // 当前写回的指令的PC (若wb_have_inst=0，此项可为任意值)
    output              debug_wb_ena,       // 指令写回时，寄存器堆的写使能 (若wb_have_inst=0，此项可为任意值)
    output wire [ 4:0]  debug_wb_reg,       // 指令写回时，写入的寄存器号 (若wb_ena或wb_have_inst=0，此项可为任意值)
    output wire [31:0]  debug_wb_value      // 指令写回时，写入寄存器的值 (若wb_ena或wb_have_inst=0，此项可为任意值)
`endif
);

    wire        pll_lock;
    wire        pll_clk;
    wire        cpu_clk;

    // Interface between CPU and IROM
`ifdef RUN_TRACE
    wire [15:0] inst_addr;
`else
    wire [13:0] inst_addr;
`endif
    wire [31:0] inst;

    // Interface between CPU and Bridge
    wire [31:0] Bus_rdata;
    wire [31:0] Bus_addr;
    wire        Bus_we;
    wire [31:0] Bus_wdata;
    
    // Interface between bridge and DRAM
    // wire         rst_bridge2dram;
    wire         clk_bridge2dram;
    wire [31:0]  addr_bridge2dram;
    wire [31:0]  rdata_dram2bridge;
    wire         we_bridge2dram;
    wire [31:0]  wdata_bridge2dram;
    
    // Interface between bridge and peripherals
    // TODO: 在此定义总线桥与外设I/O接口电路模块的连接信号
    //总线桥与led间连接信号
    wire rst_bridge2led;
    wire clk_bridge2led;
    wire [31:0] addr_bridge2led;
    wire we_bridge2led;
    wire [31:0] wdata_bridge2led;
    //总线桥与按键间连接信号
    wire rst_bridge2button;
    wire clk_bridge2button;
    wire [31:0] addr_bridge2button;
    wire [31:0] rdata_bridge2button;
    //总线桥与拨码开关间连接信号
    wire clk_bridge2switches;
    wire rst_bridge2switches;
    wire [31:0] addr_bridges2switches;
    wire [31:0] rdata_bridges2switches;
    //总线桥与八段数码管间连接信号
    wire clk_bridge2digital;
    wire rst_bridge2digital;
    wire [31:0] addr_bridge2digital;
    wire [31:0] wdata_bridge2digital;
    wire we_bridge2digital;
    

    
`ifdef RUN_TRACE
    // Trace调试时，直接使用外部输入时钟
    assign cpu_clk = fpga_clk;
`else
    // 下板时，使用PLL分频后的时钟
    assign cpu_clk = pll_clk & pll_lock;
    cpuclk Clkgen (
        // .resetn     (!fpga_rst),
        .clk_in1    (fpga_clk),
        .clk_out1   (pll_clk),
        .locked     (pll_lock)
    );
`endif
    
    myCPU Core_cpu (
        .cpu_rst            (fpga_rst),
        .cpu_clk            (cpu_clk),

        // Interface to IROM
        .inst_addr          (inst_addr),
        .inst               (inst),

        // Interface to Bridge
        .Bus_addr           (Bus_addr),
        .Bus_rdata          (Bus_rdata),
        .Bus_we             (Bus_we),
        .Bus_wdata          (Bus_wdata)

`ifdef RUN_TRACE
        ,// Debug Interface
        .debug_wb_have_inst (debug_wb_have_inst),
        .debug_wb_pc        (debug_wb_pc),
        .debug_wb_ena       (debug_wb_ena),
        .debug_wb_reg       (debug_wb_reg),
        .debug_wb_value     (debug_wb_value)
`endif
    );
    
    IROM Mem_IROM (
        .a          (inst_addr),
        .spo        (inst)
    );
    
    Bridge Bridge (       
        // Interface to CPU
        .rst_from_cpu       (fpga_rst),
        .clk_from_cpu       (cpu_clk),
        .addr_from_cpu      (Bus_addr),
        .we_from_cpu        (Bus_we),
        .wdata_from_cpu     (Bus_wdata),
        .rdata_to_cpu       (Bus_rdata),
        
        // Interface to DRAM
        // .rst_to_dram    (rst_bridge2dram),
        .clk_to_dram        (clk_bridge2dram),
        .addr_to_dram       (addr_bridge2dram),
        .rdata_from_dram    (rdata_dram2bridge),
        .we_to_dram         (we_bridge2dram),
        .wdata_to_dram      (wdata_bridge2dram),
        
        // Interface to 7-seg digital LEDs
        .rst_to_dig         (rst_bridge2digital),
        .clk_to_dig         (clk_bridge2digital),
        .addr_to_dig        (addr_bridge2digital),
        .we_to_dig          (we_bridge2digital),
        .wdata_to_dig       (wdata_bridge2digital),
        
        
        // Interface to LEDs
        .rst_to_led         (rst_bridge2led),
        .clk_to_led         (clk_bridge2led),
        .addr_to_led        (addr_bridge2led),
        .we_to_led          (we_bridge2led),
        .wdata_to_led       (wdata_bridge2led),

        // Interface to switches
        .rst_to_sw          (rst_bridge2switches),
        .clk_to_sw          (clk_bridge2switches),
        .addr_to_sw         (addr_bridges2switches),
        .rdata_from_sw      (rdata_bridges2switches),

        // Interface to buttons
        .rst_to_btn         (rst_bridge2button),
        .clk_to_btn         (clk_bridge2button),
        .addr_to_btn        (addr_bridge2button),
        .rdata_from_btn     (rdata_bridge2button)
    );

    DRAM Mem_DRAM (
        .clk        (clk_bridge2dram),
        .a          (addr_bridge2dram[15:2]),
        .spo        (rdata_dram2bridge),
        .we         (we_bridge2dram),
        .d          (wdata_bridge2dram)
    );
    
    // TODO: 在此实例化你的外设I/O接口电路模块
    //led接口
    Led_Devices myLed(
        .clk(clk_bridge2led),
        .rst(rst_bridge2led),
        .addr(addr_bridge2led),
        .we(we_bridge2led),
        .data(wdata_bridge2led),
        .led(led)
    );
    //按键接口
    Buttons myButtons(
        .clk(clk_bridge2button),
        .rst(rst_bridge2button),
        .addr(addr_bridge2button),
        .rdata(rdata_bridge2button),
        .button(button)
    );
    Switches mySwitches(
        .clk(clk_bridge2switches),
        .rst(rst_bridge2switches),
        .addr(addr_bridges2switches),
        .data(rdata_bridges2switches),
        .switches(sw)
    );

    Digital myDigital(
        .clk(clk_bridge2digital),
        .rst(rst_bridge2digital),
        .addr(addr_bridge2digital),
        .we(we_bridge2digital),
        .wdata(wdata_bridge2digital),
        .en(dig_en),
        .dn({DN_DP,DN_G,DN_F,DN_E,DN_D,DN_C,DN_B,DN_A})
    );


endmodule
