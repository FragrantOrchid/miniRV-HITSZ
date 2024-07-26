`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/25 12:38:07
// Design Name: 
// Module Name: ALU_B
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


module ALU_B(
    input wire [31:0] A,
    input wire [31:0] B,
    input wire op,
    output wire [31:0] C
    );
    assign C = (op == 1'b0)? A:B; 
endmodule
