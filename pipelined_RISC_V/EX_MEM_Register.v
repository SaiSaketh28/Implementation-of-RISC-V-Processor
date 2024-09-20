`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2024 20:49:48
// Design Name: 
// Module Name: EX_MEM_Register
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


module EX_MEM_Register(clk,reset,pc_in,zero,aluresult_in,data_b_in,write_address_in,pc_out,zero_out,
aluresult_out,data_b_out,write_address_out,branch,Memwrite,
MemRead,regwrite_en,MemtoReg,branch_out,Memwrite_out,MemRead_out,
regwrite_en_out,MemtoReg_out);

input clk,reset,zero,branch,Memwrite,MemRead,regwrite_en,MemtoReg;
input [31:0] pc_in,aluresult_in,data_b_in;
input [4:0] write_address_in;
output reg zero_out,branch_out,Memwrite_out,MemRead_out,regwrite_en_out,MemtoReg_out;
output reg [31:0] pc_out,aluresult_out,data_b_out;
output reg [4:0] write_address_out;


always @(posedge clk, reset)
    if(reset)
    begin
        zero_out <= 1'b0;
        branch_out <= 1'b0;
        Memwrite_out <= 1'b0;
        MemRead_out <= 1'b0;
        regwrite_en_out <= 1'b0;
        MemtoReg_out <= 1'b0;
        pc_out <= 32'b0;
        aluresult_out <= 32'bx;
        data_b_out <= 32'b0;
        write_address_out <= 5'b11111;
     end
    else
    begin
    zero_out <= zero;
    branch_out <= branch;
    Memwrite_out <= Memwrite;
    MemRead_out <= MemRead;
    regwrite_en_out <= regwrite_en;
    MemtoReg_out <= MemtoReg;
    pc_out <= pc_in;
    aluresult_out <= aluresult_in;
    data_b_out <= data_b_in;
    write_address_out <= write_address_in;
    
    end
endmodule
