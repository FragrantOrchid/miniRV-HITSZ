`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 16:17:58
// Design Name: 
// Module Name: ID_EXE
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ID_EXE(
    input  wire         cpu_rst,    //High active
    input  wire         cpu_clk,
    input  wire         stop_ID_EXE, //High active
    
    input  wire         Ctrl_RFWen,
    input  wire         Ctrl_DRAMWen,
    input  wire         Ctrl_PCSel,
    input  wire  [2:0]  Ctrl_BCOMPEn,
    input  wire  [3:0]  Ctrl_ALUSel,
    input  wire         Ctrl_ASel,
    input  wire         Ctrl_BSel,
    input  wire  [1:0]  Ctrl_WBSel,
    input  wire  [31:0] RF_rD1,
    input  wire  [31:0] RF_rD2,
    input  wire  [31:0] IMM_GEN_imm,
    input  wire  [31:0] IF_ID_pc,
    input  wire  [31:0] IF_ID_naddr,
    input  wire  [4:0]  inst_wR,
    
    output reg          ID_EXE_RFWen,
    output reg          ID_EXE_DRAMWen,
    output reg          ID_EXE_PCSel,
    output reg   [2:0]  ID_EXE_BCOMPEn,
    output reg   [3:0]  ID_EXE_ALUSel,
    output reg          ID_EXE_ASel,
    output reg          ID_EXE_BSel,
    output reg   [1:0]  ID_EXE_WBSel,
    output reg   [31:0] ID_EXE_RF_rD1,
    output reg   [31:0] ID_EXE_RF_rD2,
    output reg   [31:0] ID_EXE_imm,
    output reg   [31:0] ID_EXE_pc,
    output reg   [31:0] ID_EXE_naddr,
    output reg   [4:0]  ID_EXE_wR
    );
    
    always @(posedge cpu_clk or posedge cpu_rst)
    begin
        if(cpu_rst)
        begin
            ID_EXE_RFWen    <= 1'b0;
            ID_EXE_DRAMWen <=  1'b0;
            ID_EXE_PCSel   <=  1'b0;
            ID_EXE_BCOMPEn <=  3'b000;
            ID_EXE_ALUSel  <=  4'b0000;
            ID_EXE_ASel    <=  1'b0;
            ID_EXE_BSel    <=  1'b0;
            ID_EXE_WBSel   <=  2'b00;
            ID_EXE_RF_rD1  <=  32'b0;
            ID_EXE_RF_rD2  <=  32'b0;
            ID_EXE_imm     <=  32'b0;
            ID_EXE_pc      <=  32'b0;
            ID_EXE_naddr   <=  32'b0;
            ID_EXE_wR      <=  5'b0;
        end
        else if(stop_ID_EXE)
        begin
            ID_EXE_RFWen    <= ID_EXE_RFWen;
            ID_EXE_DRAMWen <=  ID_EXE_DRAMWen;
            ID_EXE_PCSel   <=  ID_EXE_PCSel;
            ID_EXE_BCOMPEn <=  ID_EXE_BCOMPEn;
            ID_EXE_ALUSel  <=  ID_EXE_ALUSel;
            ID_EXE_ASel    <=  ID_EXE_ASel;
            ID_EXE_BSel    <=  ID_EXE_BSel;
            ID_EXE_WBSel   <=  ID_EXE_WBSel;
            ID_EXE_RF_rD1  <=  ID_EXE_RF_rD1;
            ID_EXE_RF_rD2  <=  ID_EXE_RF_rD2;
            ID_EXE_imm     <=  ID_EXE_imm;
            ID_EXE_pc      <=  ID_EXE_pc;
            ID_EXE_naddr   <=  ID_EXE_naddr;
            ID_EXE_wR      <=  ID_EXE_wR;
        end
        else
        begin
            ID_EXE_RFWen   <=  Ctrl_RFWen;
            ID_EXE_DRAMWen <=  Ctrl_DRAMWen;
            ID_EXE_PCSel   <=  Ctrl_PCSel;
            ID_EXE_BCOMPEn <=  Ctrl_BCOMPEn;
            ID_EXE_ALUSel  <=  Ctrl_ALUSel;
            ID_EXE_ASel    <=  Ctrl_ASel;
            ID_EXE_BSel    <=  Ctrl_BSel;
            ID_EXE_WBSel   <=  Ctrl_WBSel;
            ID_EXE_RF_rD1  <=  RF_rD1;
            ID_EXE_RF_rD2  <=  RF_rD2;
            ID_EXE_imm     <=  IMM_GEN_imm;
            ID_EXE_pc      <=  IF_ID_pc;
            ID_EXE_naddr   <=  IF_ID_naddr;
            ID_EXE_wR      <=  inst_wR;
        end
    end    
endmodule

