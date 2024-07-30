`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/28 11:09:48
// Design Name: 
// Module Name: Digital
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


module Digital(
    input wire clk,
    input wire clk_cpu,
    input wire rst,
    input wire [31:0] addr,
    input wire we,
    input wire [31:0] wdata,
    output reg [7:0]en,
    output reg [7:0]dn
    );
    reg [31:0] data;
    always @(posedge clk_cpu or posedge rst)begin
        if(rst)begin
            data = 32'h0000_0000;
        end else if(we)begin
            data = wdata;
        end
    end
    wire [63:0]led;
    reg [11:0] counter;
    reg [2:0] flag;
    always @(posedge clk or posedge rst)begin
        counter <= rst?12'h000:counter+1;
    end
    always @(posedge clk or posedge rst)begin
        if(rst)begin
            flag <= 3'b000;
        end else if(&counter)begin
            flag <= flag + 1;
        end
    end
    genvar i;
    generate
        for(i=0;i < 8;i=i+1)begin:trans
            Digital_trans myTrans(
                .data(data[i*4+3:i*4]),
                .led(led[i*8+7:i*8])
            );
        end
    endgenerate
    always @(*)begin
        case(flag)
            3'b000:{en,dn} = {8'hFE,led[7:0]};
            3'b001:{en,dn} = {8'hFD,led[15:8]};
            3'b010:{en,dn} = {8'hFB,led[23:16]};
            3'b011:{en,dn} = {8'hF7,led[31:24]};
            3'b100:{en,dn} = {8'hEF,led[39:32]};
            3'b101:{en,dn} = {8'hDF,led[47:40]};
            3'b110:{en,dn} = {8'hBF,led[55:48]};
            3'b111:{en,dn} = {8'h7F,led[63:56]};
            default:{en,dn} = 16'hFFFF;
        endcase
    end
endmodule
