`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/25 16:32:01
// Design Name: 
// Module Name: SEXT
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
`define SEXT_OP_I_S 3'b000 //I型有符号
    `define SEXT_OP_I_U 3'b001 //I型无符号
    `define SEXT_OP_S 3'b010 //S型
    `define SEXT_OP_B 3'b011 //B型
    `define SEXT_OP_U 3'b101 //U型
    `define SEXT_OP_J 3'b110 //J型
*/

module SEXT(
    input wire [2:0] op,
    input wire [31:7] din,
    output reg [31:0] ext
    );
    always @(*)begin
        case(op)
            `SEXT_OP_I:ext = {{20{din[31]}},din[31:20]};
            `SEXT_OP_S:ext = {{20{din[31]}},din[31:25],din[11:7]};
            `SEXT_OP_B:ext = {{20{din[31]}},din[31],din[7],din[30:25],din[11:8]};
            `SEXT_OP_U:ext = {din[31:12],12'h000};
            `SEXT_OP_J:ext = {{20{din[31]}},din[31],din[19:12],din[20],din[30:21]};
            default:ext = `ZERO_32;
        endcase
        
    end
    
endmodule
