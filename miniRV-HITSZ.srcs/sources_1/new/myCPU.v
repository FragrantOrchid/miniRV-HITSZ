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
        .pc4(NPC_pc4),
        .pc_offset(ALU_C)
    );
    PC myPC(
        .clk(cpu_clk),
        .rst(cpu_rst),
        .din(NPC_npc),
        .pc(PC_pc)
    );
    assign inst_addr = PC_pc[15:2];
    SEXT mySEXT(
        .op(CTRL_sext_op),
        .din(inst[31:7]),
        .ext(SEXT_ext)  
    );
    wire [31:0] DRAM_EXT_rdo;
    WSEL myWSEL(
        .op(CTRL_rf_wsel),
        .pc4(NPC_pc4),
        .sext(SEXT_ext),
        .alu(ALU_C),
        .dram(DRAM_EXT_rdo),
        .data(WSEL_data)
    );
    DRAM_EXT myDRAM_EXT(
        .rdi(Bus_rdata),
        .rdo(DRAM_EXT_rdo),
        .tail(ALU_C[1:0]),
        .op(inst[14:12])
    );
    Controller myController(
        .opcode(inst[6:0]),
        .funct3(inst[14:12]),
        .funct7(inst[31:25]),
        .sext_op(CTRL_sext_op),
        .npc_op(CTRL_npc_op),
        .ram_we(CTRL_ram_we),
        .alu_op(CTRL_alu_op),
        .alub_sel(CTRL_alub_sel),
        .rf_we(CTRL_rf_we),
        .rf_wsel(CTRL_rf_wsel)
    );
    RF myRF(
        .clk(cpu_clk),
        .rR1(inst[19:15]),
        .rR2(inst[24:20]),
        .wR(inst[11:7]),
        .we(CTRL_rf_we),
        .wD(WSEL_data),
        .rD1(RF_rD1),
        .rD2(RF_rD2)
    );
    
    ALU_B myALU_B(
        .A(RF_rD2),
        .B(SEXT_ext),
        .op(CTRL_alub_sel),
        .C(ALU_B_C)
    );
    wire [31:0] ALU_A_data;
    ALU_A myALU_A(
        .pc(PC_pc),
        .rD1(RF_rD1),
        .op(inst[6:0] != 7'b0010111),
        .data(ALU_A_data)
    );
    ALU myALU(
        .op(CTRL_alu_op),
        .A(ALU_A_data),
        .B(ALU_B_C),
        .C(ALU_C),
        .f(ALU_f)
    );
    wire [31:0] DRAM_IN_data;
    DRAM_IN myDRAM_IN(
        .in(RF_rD2),
        .old(Bus_rdata),
        .tail(ALU_C[1:0]),
        .op(inst[14:12]),
        .data(DRAM_IN_data)
    );
    assign Bus_addr = ALU_C;
    assign Bus_we = CTRL_ram_we;
    assign Bus_wdata = DRAM_IN_data;
    
    

`ifdef RUN_TRACE
    // Debug Interface
    assign debug_wb_have_inst = 1'b1;
    assign debug_wb_pc        = PC_pc;
    assign debug_wb_ena       = CTRL_rf_we;
    assign debug_wb_reg       = inst[11:7];
    assign debug_wb_value     = WSEL_data;
`endif

endmodule
