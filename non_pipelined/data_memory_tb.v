`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2024 17:29:47
// Design Name: 
// Module Name: data_memory_tb
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


module data_memory_tb();
reg clk,reset,Mem_read,Mem_write;
reg [31:0] addr,write_data;
wire [31:0] Read_data;
data_memory dummi2(clk,reset,Mem_read,Mem_write,addr,write_data,Read_data);
initial
begin
clk = 1'b0;
reset = 1'b1;
Mem_read = 1'b0;
Mem_write = 1'b0;
end

always #5 clk = ~clk;

initial
begin
    reset = 1'b0;
    #5 write_data = 32'b00000000000000000000000000001100;
         Mem_write=1'b1;
         addr = 32'b2;
    #30 Mem_read = 1'b1;
        
    
end
endmodule
