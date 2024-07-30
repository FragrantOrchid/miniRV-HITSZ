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
        `IMMI:
            begin
                if(immIn[31] == 1'b0)
                    imm = {20'b0,immIn[31:20]};
                else
                    imm = {20'hFFFF_F,immIn[31:20]};
            end
        `IMMIs:
            begin
                imm = {27'b0,immIn[24:20]};
            end
        `IMMS:
            begin
                if(immIn[31] == 1'b0)
                    imm = {20'b0,immIn[31:25],immIn[11:7]};
                else
                    imm = {20'hFFFF_F,immIn[31:25],immIn[11:7]};
            end
        `IMMB:
            begin
                if(immIn[31] == 1'b0)
                    begin
                    imm = {20'b0,immIn[31],immIn[7],immIn[30:25],immIn[11:8]};
                    imm = imm * 2;
                    end
                else
                    begin
                    imm = {20'hFFFF_F,immIn[31],immIn[7],immIn[30:25],immIn[11:8]};
                    imm = imm * 2;
                    end
            end
        `IMMU:
            begin
                imm = {immIn[31:12],12'b0};
            end
        `IMMJ:
            begin
                if(immIn[31] == 1'b0)
                    begin
                    imm = {12'b0,immIn[31],immIn[19:12],immIn[20],immIn[30:21]};
                    imm = imm * 2;
                    end
                else
                    begin
                    imm = {12'hFFF,immIn[31],immIn[19:12],immIn[20],immIn[30:21]};
                    imm = imm * 2;
                    end
            end                        
        default:
            imm = 32'b0;
        endcase
    end
endmodule
