`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2024 17:57:59
// Design Name: 
// Module Name: program_counter_tb
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


module program_counter_tb();
wire [31:0] pc_out;
reg [31:0] pc_in;
reg clk,reset;
program_counter dummy(clk,reset,pc_in,pc_out);
initial
begin
clk = 1'b0;
reset = 1'b1;
end
always #5 clk = ~clk;
initial
begin
    #25 reset = 1'b0;
    #50 pc_in = 32'b00000000000000000000000000001100;

end
endmodule
