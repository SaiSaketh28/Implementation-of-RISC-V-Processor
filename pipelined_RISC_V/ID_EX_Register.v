`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2024 12:27:45
// Design Name: 
// Module Name: ID_EX_Register
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


module ID_EX_Register(clk,reset,pc_in,data_a,data_b,imm,funct7_5,funct3,pc_out,data_a_out,data_b_out,
imm_out,funct7_5_out,funct3_out,write_address_in,write_address_out,branch,branch_out,Memwrite,Memwrite_out,
MemRead,MemRead_out,MemtoReg,MemtoReg_out,alusrc,alusrc_out,regwrite_en,regwrite_en_out,aluop,aluop_out);

input clk,reset,funct7_5,branch,Memwrite,MemRead,MemtoReg,alusrc,regwrite_en;
input [31:0] pc_in,data_a,data_b,imm;
input [2:0] funct3;
input [1:0] aluop;
input [4:0] write_address_in;
output reg [31:0] pc_out,data_a_out,data_b_out,imm_out;
output reg funct7_5_out,branch_out,Memwrite_out,MemRead_out,MemtoReg_out,alusrc_out,regwrite_en_out;
output reg [1:0] aluop_out;
output reg [2:0] funct3_out;
output reg [4:0] write_address_out;

always @(posedge clk, reset)
    if(reset)
    begin
    branch_out = 1'b0;
    funct7_5_out = 1'b0;
    MemRead_out = 1'b0;
    Memwrite_out = 1'b0;
    MemtoReg_out = 1'b0;
    alusrc_out = 1'b0;
    regwrite_en_out = 1'b0;
    pc_out = 32'b0;
    data_a_out = 32'b0;
    data_b_out = 32'b0;
    imm_out = 32'b0;
    funct3_out = 3'b000;
    aluop_out = 2'b00;
    write_address_out = 5'b00000;
    end
    else
    begin
    branch_out = branch;
    funct7_5_out = funct7_5;
    MemRead_out = MemRead;
    Memwrite_out = Memwrite;
    MemtoReg_out = MemtoReg;
    alusrc_out = alusrc;
    regwrite_en_out = regwrite_en;
    pc_out = pc_in;
    data_a_out = data_a;
    data_b_out = data_b;
    imm_out = imm;
    funct3_out = funct3;
    aluop_out = aluop;
    write_address_out = write_address_in;
    end
  

endmodule
