`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/26 20:04:53
// Design Name: 
// Module Name: ALU_A
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


module ALU_A(
    input wire [31:0] pc,
    input wire [31:0] rD1,
    input wire op,
    output wire [31:0] data
    );
    assign data = op?rD1:pc;
endmodule
