`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/24 15:13:12
// Design Name: 
// Module Name: ALU
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


module ALU(
    input wire [31:0] A,
    input wire [31:0] B,
    input wire [3:0] op,
    output reg [31:0] C,
    output reg f
    );
    always @(*)begin
        case(op)
            4'b0000: begin
                C = A + B;
                f = (A == B) ? 1'b1:1'b0;
            end
            4'b1000: begin
                C = A - B;
                f = 1'b0;
            end
            4'b0111: begin
                C = A & B;
                f = (A >= B) ? 1'b1:1'b0;
            end
            4'b0110: begin
                C = A | B;
                f = (A < B) ? 1'b1:1'b0;
            end
            4'b0100: begin
                C = A ^ B;
                f = ($signed(A) < $signed(B))?1'b1:1'b0;
            end
            4'b0001:begin
                
            end
        endcase
    end
    
endmodule
