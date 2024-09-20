`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2024 11:08:41
// Design Name: 
// Module Name: alu
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


module alu(a,b,alucontrol,zeroflag,aluresult);
input [31:0] a,b;
input [3:0] alucontrol;
output zeroflag;
output reg [31:0] aluresult;

// declaring the control line with respective function
localparam [3:0] 
          AND = 4'b0000,
          OR  = 4'b0001,
          ADD = 4'b0010,
          SUB = 4'b0110;
always @(*)
begin
    case(alucontrol)
        AND: aluresult = a & b;
        OR : aluresult = a | b;
        ADD: aluresult = a + b;
        SUB: aluresult = a - b;
        default : aluresult = 32'bx;
     endcase
end
assign zeroflag = (aluresult == 32'b0)? 1'b1 : 1'b0;

endmodule
