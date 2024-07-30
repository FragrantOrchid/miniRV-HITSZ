`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 15:50:24
// Design Name: 
// Module Name: RF
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


module RF(
    input  wire        clk,
    input  wire [4:0]  rR1,
    input  wire [4:0]  rR2,
    input  wire [4:0]  wR,
    input  wire [31:0] wD,
    input  wire        RFWen,
    output reg  [31:0] rD1,
    output reg  [31:0] rD2
    );
    
    integer i = 0;    
    reg  [31:0] RFr[31:0];
    
    initial
    begin
        for(i = 0; i < 32; i = i + 1)
        begin
            RFr[i] = 32'b0;
        end
    end 
    
    always @(*)
    begin
        if(rR1 == 5'b0)
            rD1 = 32'b0;
        else
            rD1 = RFr[rR1];
    end

    always @(*)
    begin
        if(rR2 == 5'b0)
            rD2 = 32'b0;
        else
            rD2 = RFr[rR2];
    end
    
    always @(posedge clk)
    begin
        if(RFWen)
        begin
            if(wR == 5'b0)
            RFr[wR] <= 32'b0;
            else
            RFr[wR] <= wD;
        end
    end
        
endmodule
