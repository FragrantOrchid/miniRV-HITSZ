`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 15:26:21
// Design Name: 
// Module Name: NPC_MUX
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


module NPC_MUX(
    input  wire [31:0] naddr,
    input  wire [31:0] baddr,
    input  wire [31:0] pc,
    input  wire [31:0] EXE_MEM_pc,
    input  wire        beq,
    input  wire        blt,
    input  wire  [2:0] funct3,
    input  wire  [6:0] opcode,
    output reg         stop_PC,
    output reg  [31:0] npc
    );
    reg        PCSel;
    reg [2:0]  BCOMPEn;
    
    always@(*)
    begin
        casez({opcode,funct3})
            {7'b1101111,3'bzzz}:{PCSel,BCOMPEn} = {1'b1,3'b000};
            {7'b1100111,3'bzzz}:{PCSel,BCOMPEn} = {1'b1,3'b000};
            {7'b1100011,3'b000}:{PCSel,BCOMPEn} = {1'b1,`BCOMP_EQ};
            {7'b1100011,3'b001}:{PCSel,BCOMPEn} = {1'b1,`BCOMP_NE};
            {7'b1100011,3'b100}:{PCSel,BCOMPEn} = {1'b1,`BCOMP_LT};
            {7'b1100011,3'b101}:{PCSel,BCOMPEn} = {1'b1,`BCOMP_GE};
            {7'b1100011,3'bzzz}:{PCSel,BCOMPEn} = {1'b1,3'b000};
            default:{PCSel,BCOMPEn} = {1'b0,3'b000};
        endcase
    end
    //1,32,3
    always@(*) begin
        casez({PCSel,(pc==EXE_MEM_pc),BCOMPEn,beq,blt})
            {1'b0,1'bz,3'bzzz,1'bz,1'bz}:{npc,stop_PC}={naddr,1'b0};
            {1'b1,1'b1,3'b000,1'bz,1'bz}:{npc,stop_PC}={baddr,1'b0};
            {1'b1,1'b1,`BCOMP_EQ,1'b1,1'bz}:{npc,stop_PC}={baddr,1'b0};
            {1'b1,1'b1,`BCOMP_EQ,1'b0,1'bz}:{npc,stop_PC}={naddr,1'b0};
            {1'b1,1'b1,`BCOMP_NE,1'b1,1'bz}:{npc,stop_PC}={naddr,1'b0};
            {1'b1,1'b1,`BCOMP_NE,1'b0,1'bz}:{npc,stop_PC}={baddr,1'b0};
            {1'b1,1'b1,`BCOMP_LT,1'bz,1'b1}:{npc,stop_PC}={baddr,1'b0};
            {1'b1,1'b1,`BCOMP_LT,1'bz,1'b0}:{npc,stop_PC}={naddr,1'b0};
            {1'b1,1'b1,`BCOMP_GE,1'bz,1'b1}:{npc,stop_PC}={naddr,1'b0};
            {1'b1,1'b1,`BCOMP_GE,1'bz,1'b0}:{npc,stop_PC}={baddr,1'b0};
            {1'b1,1'b1,3'bzzz,1'bz,1'b0}:{npc,stop_PC}={naddr,1'b0};
            default:{npc,stop_PC}={npc,1'b1};
        endcase
    end
endmodule
