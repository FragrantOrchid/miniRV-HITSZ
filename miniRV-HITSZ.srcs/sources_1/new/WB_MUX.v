`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 16:41:06
// Design Name: 
// Module Name: WB_MUX
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


module WB_MUX(
    input  wire [31:0] uimm,
    input  wire [31:0] aluC,
    input  wire [31:0] naddr,
    input  wire [31:0] rdout,
    input  wire [1:0]  WBSel,
    output reg  [31:0] wbD
    );
    always @(*)begin
        case(WBSel)
            `WB_ALUC:wbD = aluC;
            `WB_DRAM:wbD = rdout;
            `WB_NADDR:wbD = naddr;
            `WB_UIMM:wbD = uimm;
            default:wbD = `ZERO32;
        endcase            
    end
endmodule

