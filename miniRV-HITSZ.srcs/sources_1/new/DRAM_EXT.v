`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/26 16:46:24
// Design Name: 
// Module Name: DRAM_EXT
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


module DRAM_EXT(
    input wire [31:0] rdi,
    input wire [2:0] op,
    input wire [1:0] tail,
    output reg [31:0] rdo
    );
    wire [31:0] in;
    assign in = rdi >> {tail,3'b000};
    always @(*)begin
        case(op)
            3'b000: rdo = {{24{in[7]}},in[7:0]};
            3'b100: rdo = {24'h000000,in[7:0]};
            3'b001: rdo = {{16{in[15]}},in[15:0]};
            3'b101: rdo = {16'h0000,in[15:0]};
            3'b010: rdo = in;
            default: rdo = `ZERO_32;
        endcase
    end
endmodule
