`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 15:50:56
// Design Name: 
// Module Name: IMM_GEN
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


module IMM_GEN(
    input  wire [31:7] immIn,
    input  wire [3:0]  IMMSel,
    output reg  [31:0] imm
    );
    
    always @(*)
    begin
        case(IMMSel)
            `IMMI:imm = {{20{immIn[31]}},immIn[31:20]};
            `IMMIs:imm = {27'b0,immIn[24:20]};
            `IMMS:imm = {{20{immIn[31]}},immIn[31:25],immIn[11:7]};
            `IMMB:imm = {{19{immIn[31]}},immIn[31],immIn[7],immIn[30:25],immIn[11:8],1'b0};
            `IMMU:imm = {immIn[31:12],12'h000};
            `IMMJ:imm = {{11{immIn[31]}},immIn[31],immIn[19:12],immIn[20],immIn[30:21],1'b0};                    
            default:imm = `ZERO32;
        endcase
    end
endmodule
