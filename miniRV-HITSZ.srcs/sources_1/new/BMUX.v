`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 16:20:35
// Design Name: 
// Module Name: BMUX
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


module BMUX(
    input  wire [31:0] data2,
    input  wire [31:0] imm,
    input  wire        BSel,
    output wire  [31:0] opB
    );
    assign opB = BSel ? imm : data2;   
endmodule
