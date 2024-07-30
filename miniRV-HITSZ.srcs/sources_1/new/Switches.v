`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/27 11:21:25
// Design Name: 
// Module Name: Switches
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


module Switches(
    input wire clk,
    input wire rst,
    input wire [31:0] addr,
    input wire [23:0] switches,
    output reg [31:0] data
    );
    always @(posedge clk or posedge rst)begin
        data = rst?32'h00000000:{8'h00,switches};
    end
endmodule