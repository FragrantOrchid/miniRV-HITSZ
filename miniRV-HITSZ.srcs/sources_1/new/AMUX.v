`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 16:20:03
// Design Name: 
// Module Name: AMUX
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


module AMUX(
    input  wire [31:0] data1,
    input  wire [31:0] pc,
    input  wire        ASel,
    output reg  [31:0] opA
    );
    
    always @(*)
    begin
        opA = ASel ? pc : data1;
    end
    
endmodule
