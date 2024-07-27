`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/26 20:45:13
// Design Name: 
// Module Name: DRAM_IN
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


module DRAM_IN(
    input wire [31:0] in,
    input wire [31:0] old,
    input wire [1:0] tail,
    input wire [2:0] op,
    output reg [31:0] data
    );
    //000 001 010 b h w
    always @(*)begin
        casez({op,tail})
            5'b000_00:data = {old[31:8],in[7:0]};
            5'b000_01:data = {old[31:16],in[7:0],old[7:0]};
            5'b000_10:data = {old[31:24],in[7:0],old[15:0]};
            5'b000_11:data = {in[7:0],old[23:0]};
            5'b001_00:data = {old[31:16],in[15:0]};
            5'b001_01:data = {old[31:24],in[15:0],old[7:0]};
            5'b001_10:data = {in[15:0],old[15:0]};
            5'b010_00:data = in[31:0];
            default:data = `ZERO_32;
        endcase
    end
endmodule
