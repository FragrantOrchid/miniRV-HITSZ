`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 15:48:12
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
    input  wire         cpu_rst,
    input  wire         cpu_clk,
    input  wire         stop_IF_ID,
    
    
    input  wire [31:0]  PC_pc,
    input  wire [31:0]  PC_ADD_naddr,
    input  wire [31:0]  inst, 
    
    output reg  [31:0]  IF_ID_inst,
    output reg  [31:0]  IF_ID_naddr,
    output reg  [31:0]  IF_ID_pc
    );
    always @(posedge cpu_clk or posedge cpu_rst)
    begin
        if(cpu_rst)
            begin
                IF_ID_inst  <= 32'h0000_0000;
                IF_ID_naddr  <= 32'h0000_0000;;
                IF_ID_pc  <= 32'h0000_0000;;
            end
        else begin
            IF_ID_inst <= stop_IF_ID?IF_ID_inst:inst;
            IF_ID_naddr <= stop_IF_ID?IF_ID_naddr:PC_ADD_naddr;
            IF_ID_pc <= stop_IF_ID?IF_ID_pc:PC_pc;
        end
    end
endmodule
