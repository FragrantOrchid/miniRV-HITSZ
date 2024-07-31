`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 16:17:27
// Design Name: 
// Module Name: Controler
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


module Controler(
    input  wire   rst,
    input  wire  [6:0]  opcode,
    input  wire  [2:0]  funct3,
    input  wire  [6:0]  funct7,
    
    output reg          RFWen,
    output reg          DRAMWen,
    output reg          PCSel,
    output reg   [2:0]  BCOMPEn,
    output reg   [3:0]  IMMSel,
    output reg   [3:0]  ALUSel,
    output reg          ASel,
    output reg          BSel,
    output reg   [1:0]  WBSel    
    );
    
    always @(*)
    if(rst)
    begin
                RFWen = 0;
                DRAMWen = 0;
                PCSel = 0;
                BCOMPEn = 3'b000;
                IMMSel = 4'b0000;
                ALUSel = 4'b0000;
                ASel = 0;
                BSel = 0;
                WBSel = 2'b00;
    end
    
    else
    begin
        case(opcode)
        
        7'b0110011:
            begin
                RFWen = 1;
                DRAMWen = 0;
                PCSel = 0;
                BCOMPEn = 3'b000;
                IMMSel = 4'b0000;
                ASel = 0;
                BSel = 0;
                WBSel = `WB_ALUC;
                
                case(funct3)
                3'b000:ALUSel = (funct7 == 7'b0000000)?`OP_ADD:`OP_SUB;
                3'b111:ALUSel = `OP_AND;
                3'b110:ALUSel = `OP_OR;
                3'b100:ALUSel = `OP_XOR;
                3'b001:ALUSel = `OP_SHIFT_LL;
                3'b101:ALUSel = (funct7 == 7'b0000000)?`OP_SHIFT_RL:`OP_SHIFT_RA;
                default:ALUSel = 4'b0000;
                endcase
                
            end

        7'b0010011:
            begin
                RFWen = 1;
                DRAMWen = 0;
                PCSel = 0;
                BCOMPEn = 3'b000;
                ASel = 0;
                BSel = 1;
                WBSel = `WB_ALUC;
                
                case(funct3)
                3'b000:
                    begin
                        IMMSel = `IMMI;
                        ALUSel = `OP_ADD;
                    end
                3'b111:
                    begin
                        IMMSel = `IMMI;
                        ALUSel = `OP_AND;
                    end
                3'b110:
                    begin
                        IMMSel = `IMMI;
                        ALUSel = `OP_OR;
                    end
                3'b100:
                    begin
                        IMMSel = `IMMI;
                        ALUSel = `OP_XOR;
                    end
                3'b001:
                    begin
                        IMMSel = `IMMIs;
                        ALUSel = `OP_SHIFT_LL;
                    end
                3'b101:
                    begin
                        if(funct7 == 7'b0000000)
                        begin
                            IMMSel = `IMMIs;
                            ALUSel = `OP_SHIFT_RL;
                        end
                        else
                        begin
                            IMMSel = `IMMIs;
                            ALUSel = `OP_SHIFT_RA;
                        end
                    end
                default:
                    begin
                        IMMSel = 4'b0000;
                        ALUSel = 4'b0000;
                    end
                
                endcase
                
            end
            
        7'b0000011:
            begin
                RFWen = 1;
                DRAMWen = 0;
                PCSel = 0;
                BCOMPEn = 3'b000;
                IMMSel = `IMMI;
                ALUSel = `OP_ADD;
                ASel = 0;
                BSel = 1;
                WBSel = `WB_DRAM;
            end
            
        7'b1100111:
            begin
                RFWen = 1;
                DRAMWen = 0;
                PCSel = 1;
                BCOMPEn = 3'b000;
                IMMSel = `IMMI;
                ALUSel = `OP_ADD;
                ASel = 0;
                BSel = 1;
                WBSel = `WB_NADDR;
            end
            
        7'b0100011:
            begin
                RFWen = 0;
                DRAMWen = 1;
                PCSel = 0;
                BCOMPEn = 3'b000;
                IMMSel = `IMMS;
                ALUSel = `OP_ADD;
                ASel = 0;
                BSel = 1;
                WBSel = 2'b00;
            end
            
        7'b1100011:
            begin
                RFWen = 0;
                DRAMWen = 0;
                PCSel = 1;
                IMMSel = `IMMB;
                ALUSel = `OP_ADD;
                ASel = 1;
                BSel = 1;
                WBSel = 2'b00;
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
            
        7'b0110111:
            begin
                RFWen = 1;
                DRAMWen = 0;
                PCSel = 0;
                BCOMPEn = 3'b000;
                IMMSel = `IMMU;
                ALUSel = 4'b0000;
                ASel = 0;
                BSel = 0;
                WBSel = `WB_UIMM;
            end
            
        7'b1101111:
            begin
                RFWen = 1;
                DRAMWen = 0;
                PCSel = 1;
                BCOMPEn = 3'b000;
                IMMSel = `IMMJ;
                ALUSel = `OP_ADD;
                ASel = 1;
                BSel = 1;
                WBSel = `WB_NADDR;
            end
            
        default:
            begin
                RFWen = 0;
                DRAMWen = 0;
                PCSel = 0;
                BCOMPEn = 3'b000;
                IMMSel = 4'b0000;
                ALUSel = 4'b0000;
                ASel = 0;
                BSel = 0;
                WBSel = 2'b00;
            end
            
        endcase
        
    end
endmodule

