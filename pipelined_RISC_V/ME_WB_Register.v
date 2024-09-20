`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.07.2024 00:47:00
// Design Name: 
// Module Name: ME_WB_Register
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


module MEM_WB_Register(clk,reset,MemtoReg,Regwrite_en,read_data,aluresult_in,write_address_in,
           MemtoReg_out,Regwrite_en_out,read_data_out,aluresult_out,write_address_out);
input clk,reset,MemtoReg,Regwrite_en;
input [31:0] read_data,aluresult_in;
input [4:0] write_address_in;
output reg MemtoReg_out,Regwrite_en_out;
output reg [31:0] read_data_out,aluresult_out;
output reg [4:0] write_address_out;

always @(posedge clk,reset)
    if(reset)
    begin
    MemtoReg_out <= 1'b0;
    Regwrite_en_out <= 1'b0;
    read_data_out <= 32'b0;
    aluresult_out <= 32'b0;
    write_address_out <= 5'b00000;
    end
    else
    begin
    MemtoReg_out <= MemtoReg;
    Regwrite_en_out <= Regwrite_en;
    read_data_out <= read_data;
    aluresult_out <= aluresult_in;
    write_address_out <= write_address_in;
    end
endmodule
