`timescale 1ns / 1ps
`include "param.v" 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/17 16:52:04
// Design Name: 
// Module Name: Controller
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


module Controller(
    input wire [6:0] opcode,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    output reg [2:0] sext_op,
    output reg [1:0] npc_op,
    output wire ram_we,
    output reg [3:0] alu_op,
    output reg alub_sel,
    output reg rf_we,
    output reg [1:0] rf_wsel
    );
    always @(*)begin
        casez({funct7,funct3,opcode})
            {7'b0z00000,3'bzzz,7'b0110011}:alu_op = {funct7[5],funct3};
            {7'b0z00000,3'b001,7'b0010011}:alu_op = {funct7[5],funct3};
            {7'b0z00000,3'b101,7'b0010011}:alu_op = {funct7[5],funct3};
            {7'bzzzzzzz,3'bzzz,7'b0010011}:alu_op = {1'b0,funct3};
            {7'bzzzzzzz,3'bzzz,7'b0000011}:alu_op = {1'b0,3'b000};
            {7'bzzzzzzz,3'b000,7'b1100111}:alu_op = {1'b0,3'b000};
            {7'bzzzzzzz,3'bzzz,7'b0100011}:alu_op = {1'b0,3'b000};
            {7'bzzzzzzz,3'bzzz,7'b1100011}:alu_op = {1'b0,funct3};
            {7'bzzzzzzz,3'bzzz,7'b0110111}:alu_op = {1'b0,3'b000};
            default:alu_op = {1'b0,3'b000};        
        endcase  
    end
    always @(*)begin
        case(opcode)
            7'b0010011:sext_op = `SEXT_OP_I;
            7'b0000011:sext_op = `SEXT_OP_I;
            7'b1100111:sext_op = `SEXT_OP_I;
            7'b0100011:sext_op = `SEXT_OP_S;
            7'b1100011:sext_op = `SEXT_OP_B;
            7'b0110111:sext_op = `SEXT_OP_U;
            7'b0010111:sext_op = `SEXT_OP_U;
            7'b1101111:sext_op = `SEXT_OP_J;
            default:sext_op = `SEXT_OP_I;
        endcase
    end
    always @(*)begin
        case(opcode)
            7'b1100111:npc_op = `NPC_OP_JALR;      //10
            7'b1100011:npc_op = `NPC_OP_OFFSET;    //01
            7'b1101111:npc_op = `NPC_OP_JAL;       //11
            default:npc_op = `NPC_OP_NEXT;                  //00
        endcase
    end
    
    assign ram_we = (opcode == 7'b0100011);
    
    always @(*)begin
        case(opcode)
            7'b0110011:alub_sel = 1'b0;
            7'b1100011:alub_sel = 1'b0;
            //7'b0100011:alub_sel = 1'b0;
            default:alub_sel = 1'b1; 
        endcase
    end
    
    always @(*)begin
        case(opcode)
            7'b0110011:rf_we = 1'b1;
            7'b0010011:rf_we = 1'b1;
            7'b0000011:rf_we = 1'b1;
            7'b1100111:rf_we = 1'b1;
            7'b0100011:rf_we = 1'b0;
            7'b1100011:rf_we = 1'b0;
            7'b0110111:rf_we = 1'b1;
            7'b0010111:rf_we = 1'b1;
            7'b1101111:rf_we = 1'b1;
            default:rf_we = 1'b0;
        endcase
    end
    always @(*)begin
        casez(opcode)
            7'b110z111:rf_wsel = `WSEL_PC4;
            7'b0110111:rf_wsel = `WSEL_SEXT;
            7'b0z10011:rf_wsel = `WSEL_ALU;
            7'b0000011:rf_wsel = `WSEL_DRAM;
            default:rf_wsel = `WSEL_ALU;
        endcase
    end
endmodule
