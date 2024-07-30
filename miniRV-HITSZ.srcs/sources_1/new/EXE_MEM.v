`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 16:39:39
// Design Name: 
// Module Name: EXE_MEM
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


module EXE_MEM(
    input  wire         cpu_rst,    //High active
    input  wire         cpu_clk,
    
    input  wire         ID_EXE_RFWen,
    input  wire         ID_EXE_DRAMWen,
    input  wire         ID_EXE_PCSel,
   
    input  wire  [1:0]  ID_EXE_WBSel,
    input  wire  [31:0] ID_EXE_RF_rD2,
    input  wire  [31:0] ID_EXE_imm,
    input  wire  [31:0] ID_EXE_pc,
    input  wire  [31:0] ID_EXE_naddr,
    input  wire         BCOMP_beq,
    input  wire         BCOMP_blt,
    input  wire  [31:0] ALU_aluC,
    input  wire  [4:0]  ID_EXE_wR,
    
    
    output reg          EXE_MEM_RFWen,
    output reg          EXE_MEM_DRAMWen,
    output reg          EXE_MEM_PCSel,
    output reg   [1:0]  EXE_MEM_WBSel,
    output reg   [31:0] EXE_MEM_RF_rD2,
    output reg   [31:0] EXE_MEM_imm,
    output reg   [31:0] EXE_MEM_pc,
    output reg   [31:0] EXE_MEM_naddr,
    output reg          EXE_MEM_beq,
    output reg          EXE_MEM_blt,
    output reg   [31:0] EXE_MEM_aluC,
    output reg   [4:0]  EXE_MEM_wR
    );
    
    always @(posedge cpu_clk or posedge cpu_rst)
    begin
        if(cpu_rst)
        begin
            EXE_MEM_RFWen   <=  1'b0;
            EXE_MEM_DRAMWen <=  1'b0;
            EXE_MEM_PCSel   <=  1'b0;
            EXE_MEM_WBSel   <=  2'b00;
            EXE_MEM_RF_rD2  <=  32'b0;
            EXE_MEM_imm     <=  32'b0;
            EXE_MEM_pc      <=  32'b0;
            EXE_MEM_naddr   <=  32'b0;
            EXE_MEM_beq     <=  1'b0;
            EXE_MEM_blt     <=  1'b0;
            EXE_MEM_aluC    <=  32'b0;
            EXE_MEM_wR      <=  5'b0;
        end else begin
            EXE_MEM_RFWen   <=  ID_EXE_RFWen;
            EXE_MEM_DRAMWen <=  ID_EXE_DRAMWen;
            EXE_MEM_PCSel   <=  ID_EXE_PCSel;
            EXE_MEM_WBSel   <=  ID_EXE_WBSel;
            EXE_MEM_RF_rD2  <=  ID_EXE_RF_rD2;
            EXE_MEM_imm     <=  ID_EXE_imm;
            EXE_MEM_pc      <=  ID_EXE_pc;
            EXE_MEM_naddr   <=  ID_EXE_naddr;
            EXE_MEM_beq     <=  BCOMP_beq;
            EXE_MEM_blt     <=  BCOMP_blt;
            EXE_MEM_aluC    <=  ALU_aluC;
            EXE_MEM_wR      <=  ID_EXE_wR;
        end
    end    
    
endmodule

