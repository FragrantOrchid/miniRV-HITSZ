`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 16:39:05
// Design Name: 
// Module Name: BCOMP
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


module BCOMP(
    input  wire [31:0] data1,
    input  wire [31:0] data2,
    input  wire [2:0]  BCOMPEn,
    output reg         beq,
    output reg         blt
    );
    
    always @(*) begin
        if(BCOMPEn == 3'b000){beq,blt} = {1'b1,1'b1};
        else if(data1 == data2) {beq,blt} = {1'b1,1'b0};
        else if ($signed(data1) < $signed(data2)) {beq,blt} = {1'b0,1'b1};
        else {beq,blt} = {1'b0,1'b0};
    end
    
endmodule

