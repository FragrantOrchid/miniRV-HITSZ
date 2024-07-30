`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 16:39:05
// Design Name: 
// Module Name: BCOMP
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


module BCOMP(
    input  wire [31:0] data1,
    input  wire [31:0] data2,
    input  wire [2:0]  BCOMPEn,
    output reg         beq,
    output reg         blt
    );
    
    always @(*)
    begin
        case(BCOMPEn)
        3'b000:
            begin
                beq = 1;
                blt = 1;
            end
        default:
            begin
                if(data1 == data2)
                    begin
                        beq = 1;
                        blt = 0;
                    end
                else if($signed(data1) < $signed(data2))
                    begin
                        beq = 0;
                        blt = 1;
                    end
                else
                    begin
                        beq = 0;
                        blt = 0;
                    end    
            end
        endcase
    end
    
endmodule

