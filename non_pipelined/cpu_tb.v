`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.07.2024 19:15:38
// Design Name: 
// Module Name: cpu_tb
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


module cpu_tb();
reg clk,reset;
wire [31:0] r1,r2,r3,r4,r5,r10;
wire [31:0] pc_in,pc_out,imm,data_memory_read;
wire pc_src;
wire [31:0] instruction,final_result,data_a,data_b;
wire [3:0] alucontrol;
wire [31:0] b,aluresult;
wire zeroflag;
wire [4:0] rs1,rs2,rdd;

// control signs declaration
wire branch,MemtoReg,MemRead,MemWrite,Regwrite,alusrc;
wire [1:0] aluop,immsel;

cpu cpu_model(clk,reset,r1,r2,r3,r4,r4,r5,r10,pc_in,pc_out,imm,data_memory_read,instruction,final_result,data_a,data_b,alucontrol,b,aluresult,pc_src,zeroflag,branch,MemtoReg,MemRead,MemWrite,Regwrite,alusrc,aluop,immsel,rs1,rs2,rdd);
initial
begin
reset = 1'b1;
clk = 1'b0;
#1 reset =1'b0;

end
always  #5 clk = ~clk;
//initial
//begin
//#6 reset = 1'b0;
//end


//initial 
//begin
//        $monitor("Time: %0d,instr: %d, PC: %d, RegA: %d, RegB: %d, ALUResult: %d,r1: %d,r2: %d,r3: %d,r4: %d,r5: %d,r10: %d",
//                 $time,cpu_model.instruction, cpu_model.pc_out, cpu_model.read_data_port_a, 
//                 cpu_model.read_data_port_b, cpu_model.aluresult, cpu_model.r1,cpu_model.r2,cpu_model.r3,cpu_model.r4,cpu_model.r5,cpu_model.r10);
//end
initial
#100 $finish;
endmodule
