`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/25 14:54:52
// Design Name: 
// Module Name: RF
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


module RF(
    input wire clk, 
    input wire [4:0] rR1,
    input wire [4:0] rR2,
    input wire [4:0]wR,
    input wire we,
    input wire [31:0]wD,
    output reg [31:0] rD1,
    output reg [31:0] rD2
    );
    reg [31:0] regs [31:0];
    always @(*)begin
        if(rR1 == 5'b00000)begin
            rD1 = 32'h0000_0000;
        end else if(rR2 == 5'b00000)begin
            rD2 = 32'h0000_0000;
        end else begin
            rD1 = regs[rR1];
            rD2 = regs[rR2];
        end
    end
    always @(posedge clk)begin
        if(we && wR != 5'b00000)begin
            regs[wR] <= wD;
        end
    end
endmodule
