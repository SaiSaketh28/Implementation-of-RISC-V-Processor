`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2024 12:01:24
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


module IF_ID(clk,reset,pc_in,instruction_fetched,instruction,pc_forwarded);
input clk,reset;
input [31:0] pc_in,instruction_fetched;
output reg [31:0] pc_forwarded;
output  reg [31:0] instruction;

always @(posedge clk,reset)
    if(reset)
    begin
        pc_forwarded = 32'b0;
        instruction =  32'b0;
    end
    else
        begin
            pc_forwarded = pc_in;
            instruction = instruction_fetched;
        end

endmodule
