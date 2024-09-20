`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.07.2024 12:24:05
// Design Name: 
// Module Name: imm_gen
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


module imm_gen(instr,imm_sel,imm);
input [31:0] instr;
input [1:0] imm_sel;
output [31:0] imm;

reg [11:0] immediate;
wire [31:0] sign_extended_imm;
 assign  sign_extended_imm = $signed(immediate);

localparam [1:0]
            lw_operation = 2'b00,
            sw_operation = 2'b01,
            beq_operation = 2'b10;
            
            
always @(*)
    case (imm_sel)
        lw_operation : 
            immediate <= instr[31:20];
        sw_operation :
            immediate <= {instr[31:25],instr[11:7]};
        beq_operation :
            immediate <= {instr[31],instr[7],instr[30:25],instr[11:8]};
         default:
            immediate <= 12'bx;
    endcase
    
 assign  imm  = sign_extended_imm;
endmodule
