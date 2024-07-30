`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 16:40:30
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
    input  wire         cpu_rst,    //High active
    input  wire         cpu_clk,
    //input  wire         stop_MEM_WB, //High active   
    
    input  wire         EXE_MEM_RFWen,
    //input  wire         ID_EXE_DRAMWen,
    input  wire         EXE_MEM_PCSel,
    //input  wire  [2:0]  Ctrl_BCOMPEn,
    //input  wire  [3:0]  IMMSel,
    //input  wire  [3:0]  Ctrl_ALUSel,
    //input  wire         Ctrl_ASel,
    //input  wire         Ctrl_BSel,
    input  wire  [1:0]  EXE_MEM_WBSel,
    //input  wire  [31:0] RF_rD1,
    //input  wire  [31:0] ID_EXE_rD2,
    input  wire  [31:0] EXE_MEM_imm,
    input  wire  [31:0] EXE_MEM_pc,
    input  wire  [31:0] EXE_MEM_naddr,
    input  wire         EXE_MEM_beq,
    input  wire         EXE_MEM_blt,
    input  wire  [31:0] EXE_MEM_aluC,
    input  wire  [31:0] DRAM_rdout,
    input  wire  [4:0]  EXE_MEM_wR,
    
    output reg          MEM_WB_RFWen,
    //output reg          EXE_MEM_DRAMWen,
    output reg          MEM_WB_PCSel,
    //output reg   [2:0]  ID_EXE_BCOMPEn,
    //output reg   [3:0]  ID_EXE_IMMSel,
    //output reg   [3:0]  ID_EXE_ALUSel,
    //output reg          ID_EXE_ASel,
    //output reg          ID_EXE_BSel,
    output reg   [1:0]  MEM_WB_WBSel,
    //output reg   [31:0] ID_EXE_RF_rD1,
    //output reg   [31:0] MEM_WB_RF_rD2,
    output reg   [31:0] MEM_WB_imm,
    output reg   [31:0] MEM_WB_pc,
    output reg   [31:0] MEM_WB_naddr,
    output reg          MEM_WB_beq,
    output reg          MEM_WB_blt,
    output reg   [31:0] MEM_WB_aluC,
    output reg   [31:0] MEM_WB_rdout,
    output reg   [4:0]  MEM_WB_wR
    );
    
    always @(posedge cpu_clk or posedge cpu_rst)
    begin
        if(cpu_rst)
        begin
            MEM_WB_RFWen    <=  1'b0;
            MEM_WB_PCSel    <=  1'b0;
            MEM_WB_WBSel    <=  2'b00;
            MEM_WB_imm      <=  32'b0;
            MEM_WB_pc       <=  32'b0;
            MEM_WB_naddr    <=  32'b0;
            MEM_WB_beq      <=  1'b0;
            MEM_WB_blt      <=  1'b0;
            MEM_WB_aluC     <=  32'b0;
            MEM_WB_rdout    <=  32'b0;
            MEM_WB_wR       <=  5'b0;
        end
        else
        begin
            MEM_WB_RFWen    <=  EXE_MEM_RFWen;
            MEM_WB_PCSel    <=  EXE_MEM_PCSel;
            MEM_WB_WBSel    <=  EXE_MEM_WBSel;
            MEM_WB_imm      <=  EXE_MEM_imm;
            MEM_WB_pc       <=  EXE_MEM_pc;
            MEM_WB_naddr    <=  EXE_MEM_naddr;
            MEM_WB_beq      <=  EXE_MEM_beq;
            MEM_WB_blt      <=  EXE_MEM_blt;
            MEM_WB_aluC     <=  EXE_MEM_aluC;
            MEM_WB_rdout    <=  DRAM_rdout;
            MEM_WB_wR       <=  EXE_MEM_wR;
        end
    end    
    
endmodule

