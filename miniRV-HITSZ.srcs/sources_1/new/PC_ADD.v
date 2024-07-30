`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 15:10:11
// Design Name: 
// Module Name: PC_ADD
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


module PC_ADD(
    input  wire [31:0] pc,
    output reg  [31:0] naddr
    );
    
    always @(*)
    begin
        naddr = pc + 32'h0000_0004;
    end
endmodule
