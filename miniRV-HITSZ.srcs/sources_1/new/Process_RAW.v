`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 15:49:58
// Design Name: 
// Module Name: Process_RAW
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


module Process_RAW(
    input   wire        conflict_ID_EXE,
    input   wire        conflict_EXE_MEM,
    input   wire        conflict_MEM_WB,
    output  wire         stop_PC,
    output  wire         stop_IF_ID,
    output  wire         stop_ID_EXE
    );
    wire stop;
    assign stop = conflict_MEM_WB || conflict_EXE_MEM || conflict_ID_EXE;
    assign stop_PC = stop;
    assign stop_IF_ID = stop;
    assign stop_ID_EXE = stop;
endmodule

