`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/27 10:41:15
// Design Name: 
// Module Name: Led_Devices
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


module Led_Devices(
    input wire clk,
    input wire rst,
    input wire we,
    input wire [31:0] addr,
    input wire [31:0] data,
    output reg [23:0] led
    );
    always @ (posedge clk or posedge rst)begin
        if(rst)begin
            led = 24'h000_000;
        end else if(we)begin
            led = data[23:0];
        end
    end
endmodule
