`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.07.2024 10:57:54
// Design Name: 
// Module Name: control_unit
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


module control_unit(opcode,immsel,aluop,regwrite_en,alusrc,MemtoReg,MemRead,MemWrite,Branch);
input [6:0] opcode;
output reg [1:0] immsel,aluop;
output reg regwrite_en,alusrc,MemtoReg,MemRead,MemWrite,Branch;

localparam [6:0]
            R_operation = 7'b0110011,
            lw_operation = 7'b0000011,
            sw_operation = 7'b0100011,
            beq_operation = 7'b1100011;
            
always @(*)
begin
    case(opcode)
        R_operation :
            begin
            immsel = 2'bxx;
            aluop =  2'b10;
            alusrc = 1'b0;
            MemtoReg = 1'b0;
            regwrite_en = 1'b1;
            MemRead = 1'b0;
            MemWrite = 1'b0;
            Branch = 1'b0;
            end
       lw_operation :
            begin
            immsel = 2'b00;
            aluop =  2'b00;
            alusrc = 1'b1;
            MemtoReg = 1'b1;
            regwrite_en = 1'b1;
            MemRead = 1'b1;
            MemWrite = 1'b0;
            Branch = 1'b0;
            end
       sw_operation:
            begin
            immsel = 2'b01;
            aluop =  2'b00;
            alusrc = 1'b1;
            MemtoReg = 1'bx;
            regwrite_en = 1'b0;
            MemRead = 1'b0;
            MemWrite = 1'b1;
            Branch = 1'b0;
            end
       beq_operation:
            begin
            immsel = 2'b10;
            aluop =  2'b01;
            alusrc = 1'b0;
            MemtoReg = 1'bx;
            regwrite_en = 1'b0;
            MemRead = 1'b0;
            MemWrite = 1'b0;
            Branch = 1'b1;
            end
        default:
            begin
            immsel = 2'bxx;
            aluop =  2'b10;
            alusrc = 1'b0;
            MemtoReg = 1'b0;
            regwrite_en = 1'b1;
            MemRead = 1'b0;
            MemWrite = 1'b0;
            Branch = 1'b0;
            end
    endcase
end
endmodule
