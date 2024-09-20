`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2024 11:22:47
// Design Name: 
// Module Name: alu_tb
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


module alu_tb();
reg [31:0] a,b;
reg [3:0] alucontrol;
wire [31:0] aluresult;
wire zeroflag;
alu dummi(a,b,alucontrol,zeroflag,aluresult);
initial 
begin
    alucontrol = 4'b 0000;
    a =32'b00000000000000000000000000001011;
    b= 32'b00000000000000000000000000001100;
    #50 alucontrol = 4'b0010;
end
endmodule
