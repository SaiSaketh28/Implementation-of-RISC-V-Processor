`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2024 17:53:28
// Design Name: 
// Module Name: program_counter
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


module program_counter(clk,reset,pc_in,pc_out);
input [31:0] pc_in;
input clk,reset;
output reg [31:0] pc_out;
always @ (posedge clk, posedge reset)
    if(reset)
    begin
        pc_out = 32'b0;
    end
    else
        begin
            pc_out = pc_in;
        end
endmodule
