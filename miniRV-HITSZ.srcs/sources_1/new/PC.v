`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 15:08:46
// Design Name: 
// Module Name: PC
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


module PC(
    input  wire        clk,
    input  wire        rst,
    input  wire        stop_PC,
    input  wire        stop_PC_NPC_MUX,
    input  wire [31:0] npc,
    output reg  [31:0] pc
    );
    always @(posedge clk or posedge rst)
    begin
        if(rst) pc <= 32'hFFFF_FFFC;
        else pc <= (stop_PC || stop_PC_NPC_MUX)?pc:npc;   
    end
endmodule
