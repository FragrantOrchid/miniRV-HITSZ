`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 11:10:10
// Design Name: 
// Module Name: Digital_trans
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

//???¨°??dp,g,f,e,d,c,b,a
module Digital_trans(
    input wire [3:0] data,
    output reg [7:0] led
    );
    always @(*)begin
        case(data)
            4'h0:led = 8'hC0;
            4'h1:led = 8'hF9;
            4'h2:led = 8'hA4;
            4'h3:led = 8'hB0;
            4'h4:led = 8'h99;
            4'h5:led = 8'h92;
            4'h6:led = 8'h82;
            4'h7:led = 8'hF8;
            4'h8:led = 8'h80;
            4'h9:led = 8'h90;
            4'hA:led = 8'h88;
            4'hB:led = 8'h83;
            4'hC:led = 8'hC6;
            4'hD:led = 8'hA1;
            4'hE:led = 8'h86;
            4'hF:led = 8'h8E;
            default:led = 8'hBF;
        endcase
    end
endmodule
