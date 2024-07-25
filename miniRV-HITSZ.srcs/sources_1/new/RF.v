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
    input wire wR,
    input wire we,
    input wire wD,
    output reg rD1,
    output reg rD2
    );
    reg [31:0] regs [31:0];
    always @(*)begin
        rD1 <= regs[rD1];
        rD2 <= regs[rD2];
    end
    always @(posedge clk)begin
        if(we && wR != 5'b00000)begin
            regs[wR] <= wD;
        end
    end
endmodule
