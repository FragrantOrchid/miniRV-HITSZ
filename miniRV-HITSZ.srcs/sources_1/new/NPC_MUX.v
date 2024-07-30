`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 15:26:21
// Design Name: 
// Module Name: NPC_MUX
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


module NPC_MUX(
    input  wire [31:0] naddr,
    input  wire [31:0] baddr,
    input  wire [31:0] pc,
    input  wire [31:0] EXE_MEM_pc,
    input  wire        beq,
    input  wire        blt,
    input  wire  [2:0] funct3,
    input  wire  [6:0] opcode,
    output reg         stop_PC,
    output reg  [31:0] npc
    );
    reg        PCSel;
    reg [2:0]  BCOMPEn;
    
    always@(*)
    begin
        case(opcode)
            7'b1101111:
                begin
                    PCSel = 1;
                    BCOMPEn = 3'b000;
                end
            7'b1100111:
                begin
                    PCSel = 1;
                    BCOMPEn = 3'b000;
                end
            7'b1100011:
                begin
                    PCSel = 1;
                    case(funct3)
                        3'b000:
                            BCOMPEn = `BCOMP_EQ;
                        3'b001:
                            BCOMPEn = `BCOMP_NE;
                        3'b100:
                            BCOMPEn = `BCOMP_LT;
                        3'b101:
                            BCOMPEn = `BCOMP_GE;
                        default:
                            BCOMPEn = 3'b000;
                    endcase
                end    
            default:
                begin
                    PCSel = 0;
                    BCOMPEn = 3'b000;
                end    
        endcase
    end
    
    always@(*)
    begin
        if(PCSel == 0)
        begin
            npc = naddr;
            stop_PC = 1'b0;
        end
        
        else if(pc == EXE_MEM_pc)
        begin
            if(BCOMPEn == 3'b000)
            begin
                npc = baddr;
            end
            else if(BCOMPEn == `BCOMP_EQ)  
            begin
                if(beq)
                    npc = baddr;
                else
                    npc = naddr;            
            end
            else if(BCOMPEn == `BCOMP_NE)                    
            begin
                if(beq)
                    npc = naddr;
                else
                    npc = baddr;
            end
            else if(BCOMPEn == `BCOMP_LT)  
            begin
                if(blt)
                    npc = baddr;
                else
                    npc = naddr;            
            end
            else if(BCOMPEn == `BCOMP_GE)                    
            begin
                if(blt)
                    npc = naddr;
                else
                    npc = baddr;
            end
            else
            begin
                npc = naddr;
            end 
            stop_PC = 1'b0;
        end
        
        else
        begin
            npc = npc;
            stop_PC = 1'b1; 
        end
    end
    
endmodule
