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
    output wire [1:0] npc_op,
    output wire ram_we,
    output reg [3:0] alu_op,
    output wire alub_sel,
    output wire rf_we,
    output wire [1:0] rf_wsel
    );
    always @(*)begin
        casez({funct7,funct3,opcode})
            {7'b0000000,3'bxxx,7'b0110011}:alu_op = {funct7[5:5],funct3};
            {7'b0000000,3'b001,7'b0010011}:alu_op = {funct7[5:5],funct3};
            {7'bxxxxxxx,3'b101,7'b0010011}:alu_op = {funct7[5:5],funct3};
            {7'bxxxxxxx,3'bxxx,7'b0010011}:alu_op = {1'b0,funct3};
            {7'bxxxxxxx,3'bxxx,7'b0000011}:alu_op = {1'b0,3'b000};
            {7'bxxxxxxx,3'b000,7'b1100111}:alu_op = {1'b0,3'b000};
            {7'bxxxxxxx,3'bxxx,7'b0100011}:alu_op = {1'b0,3'b000};
            {7'bxxxxxx,3'bxxx,7'b1100011}:alu_op = {1'b0,funct3};
            {7'bxxxxxxx,3'bxxx,7'b0110111}:alu_op = {1'b0,3'b000};
            default:alu_op = {1'b0,3'b000};
        endcase  
    end
    always @(*)begin
        casez({funct7,funct3,opcode})
            {7'bxxxxxxx,3'b011,7'b0010011}:sext_op = `SEXT_OP_I_U;
            {7'bxxxxxxx,3'bxxx,7'b0010011}:sext_op = `SEXT_OP_I_S;
            {7'bxxxxxxx,3'bxxx,7'b0000011}:sext_op = `SEXT_OP_I_S;
            {7'bxxxxxxx,3'bxxx,7'b1100111}:sext_op = `SEXT_OP_I_S;
            {7'bxxxxxxx,3'bxxx,7'b0100011}:sext_op = `SEXT_OP_S;
            {7'bxxxxxxx,3'bxxx,7'b1100011}:sext_op = `SEXT_OP_B;
            {7'bxxxxxxx,3'bxxx,7'b0x10111}:sext_op = `SEXT_OP_U;
            {7'bxxxxxxx,3'bxxx,7'b1101111}:sext_op = `SEXT_OP_J;
            default:sext_op = 3'b000;
        endcase
    end
    always @(*)begin
        casez({funct7,funct3,opcode})
            {7'bxxxxxxx,3'b000,7'b1100111}:npc_op = 
        
        
        endcase
    end
      
        
    
    
endmodule
