`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/25 15:38:56
// Design Name: 
// Module Name: WSEL
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
    `define WSEL_PC4 2'b00 
    `define WSEL_SEXT 2'b01
    `define WSEL_ALU 2'b10
    `define WSEL_DRAM 2'b11
*/
module WSEL(
    input wire [1:0]op, 
    input wire [31:0] pc4,
    input wire [31:0] sext,
    input wire [31:0] alu,
    input wire [31:0] dram,
    output reg [31:0] data
    );
    always @(*)begin
        case(op)
            `WSEL_PC4:data = pc4;
            `WSEL_SEXT:data = sext;
            `WSEL_ALU:data = alu;
            `WSEL_DRAM:data = dram;
            default:data = `ZERO_32;
        endcase
    end
endmodule
