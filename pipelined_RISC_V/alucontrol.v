`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2024 15:49:41
// Design Name: 
// Module Name: alucontrol
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


module alucontrol(aluop,funct3,funct7_5,alu_control);
input [1:0] aluop;
input [2:0] funct3;
input funct7_5;
output reg [3:0] alu_control;
wire funct;
assign funct = {funct7_5,funct3};
// based on aluop
localparam [1:0]
            lw_sw_operation = 2'b00,
            beq_operation = 2'b01,
            R_operation = 2'b10;

// based on funct
localparam [3:0] 
            add = 4'b0000,
            sub = 4'b1000,
            AND = 4'b0111,
            OR = 4'b0110;
            
always @(*)
    case(aluop)
        lw_sw_operation : 
            alu_control = 4'b0010;
         beq_operation :
            alu_control = 4'b0110;
          R_operation :
            begin
                case(funct)
                    add:
                        alu_control = 4'b0010;
                    sub: 
                        alu_control = 4'b0110;
                    AND:
                        alu_control = 4'b0000;
                    OR:
                        alu_control = 4'b0001;
                     default:
                        alu_control = 4'b0010;
                endcase
            end  
     endcase


endmodule
