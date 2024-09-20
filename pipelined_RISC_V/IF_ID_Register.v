`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2024 12:14:45
// Design Name: 
// Module Name: IF_ID_Register
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


module IF_ID_Register(clk,reset,pc_in,instruction_fetched,instruction,pc_IF_ID);
input clk,reset;
input [31:0] instruction_fetched,pc_in;
output reg [31:0] instruction,pc_IF_ID;

always @(posedge clk,reset)
    if(reset)
    begin
        pc_IF_ID = 32'b0;
        instruction = 32'b0;
    end
    else
    begin
          instruction = instruction_fetched;
          pc_IF_ID = pc_in;
    end

endmodule
