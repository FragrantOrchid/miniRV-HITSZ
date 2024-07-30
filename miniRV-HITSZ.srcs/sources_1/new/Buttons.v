`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 11:03:25
// Design Name: 
// Module Name: Buttons
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


module Buttons(
    input wire clk,
    input wire rst,
    input wire [31:0] addr,
    input wire [4:0] button,
    output reg [31:0]rdata
    );
    always @(posedge clk or posedge rst)begin
        rdata = rst?32'h00000000:{27'h0000000,button};
    end
endmodule
