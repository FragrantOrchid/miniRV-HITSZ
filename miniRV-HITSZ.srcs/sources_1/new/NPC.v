`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/25 17:19:57
// Design Name: 
// Module Name: NPC
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
/*
`define NPC_OP_NEXT 2'b00   //Ë³ÐòÖ´ÐÐ
    `define NPC_OP_OFFSET 2'b01 //Ìø×ª
    `define NPC_OP_JALR 2'b10   //jalr
*/

module NPC(
    input wire [31:0] PC,
    input wire [31:0] offset,
    input wire br,
    input wire [1:0] op,
    input wire [31:0] pc_offset,
    output reg [31:0] npc,
    output wire [31:0] pc4
    );
    assign pc4 = PC+4;
    always @(*)begin
        case(op)
            `NPC_OP_NEXT:npc <= PC+4;
            `NPC_OP_OFFSET:npc <= br?PC+offset:PC+4;
            `NPC_OP_JALR:npc <= pc_offset;
            default:npc<= `ZERO_32;
        endcase
    end
    
endmodule
