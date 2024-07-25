`timescale 1ns / 1ps

`include "defines.vh"

module myCPU (
    input  wire         cpu_rst,
    input  wire         cpu_clk,

    // Interface to IROM
`ifdef RUN_TRACE
    output wire [15:0]  inst_addr,
`else
    output wire [13:0]  inst_addr,
`endif
    input  wire [31:0]  inst,
    
    // Interface to Bridge
    output wire [31:0]  Bus_addr,
    input  wire [31:0]  Bus_rdata,
    output wire         Bus_we,
    output wire [31:0]  Bus_wdata

`ifdef RUN_TRACE
    ,// Debug Interface
    output wire         debug_wb_have_inst,
    output wire [31:0]  debug_wb_pc,
    output              debug_wb_ena,
    output wire [ 4:0]  debug_wb_reg,
    output wire [31:0]  debug_wb_value
`endif
);

    // TODO: 完成你自己的单周期CPU设计
    //
    wire [31:0] NPC_npc;
    wire [31:0] NPC_pc4;
    wire [31:0] PC_pc;
    wire [31:0] IROM_inst;
    wire [31:0] SEXT_ext;
    wire [31:0] DRAM_rdo;
    wire [31:0] ALU_C;
    wire ALU_f;
    wire [31:0] WSEL_data;
    wire [31:0] ALU_B_C;
    wire [31:0] RF_rD1;
    wire [31:0] RF_rD2;
    wire [2:0] CTRL_sext_op;
    wire [1:0] CTRL_npc_op;
    wire CTRL_ram_we;
    wire [3:0] CTRL_alu_op;
    wire CTRL_alub_sel;
    wire CTRL_rf_we;
    wire [1:0] CTRL_rf_wsel;
    NPC myNPC (
        .PC(PC_pc),
        .offset(SEXT_ext),
        .br(ALU_f),
        .op(CTRL_npc_op),
        .npc(NPC_npc),
        .pc4(NPC_pc4)
    );
    
    

`ifdef RUN_TRACE
    // Debug Interface
    assign debug_wb_have_inst = /* TODO */;
    assign debug_wb_pc        = /* TODO */;
    assign debug_wb_ena       = /* TODO */;
    assign debug_wb_reg       = /* TODO */;
    assign debug_wb_value     = /* TODO */;
`endif

endmodule
