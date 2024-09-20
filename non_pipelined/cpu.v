`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.07.2024 16:10:38
// Design Name: 
// Module Name: cpu
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
//cpu(clk,reset,data_shown,pcshown,instructionshown,data_a,data_b,rs1,rs2,rdd,r1,r2,r3,r4,r5,r10,alucontrolout,operand_b,mux0,mux1,imm_selection,alu_selection,out);

module cpu(clk,reset,r1,r2,r3,r4,r4,r5,r10,pc_in,pc_out,imm,data_memory_read,instruction,final_result,data_a,data_b,alucontrol,b,aluresult,pc_src,zeroflag,branch,MemtoReg,MemRead,MemWrite,Regwrite,alusrc,aluop,immsel,rs1,rs2,rdd);
input clk,reset;
output [31:0] r1,r2,r3,r4,r5,r10;
output [31:0] pc_in,pc_out,imm,data_memory_read;
output pc_src;
output [31:0] instruction,final_result,data_a,data_b;
output [3:0] alucontrol;
output [31:0] b,aluresult;
output zeroflag;

// control signs declaration
output branch,MemtoReg,MemRead,MemWrite,Regwrite,alusrc;
output [1:0] aluop,immsel;
output [4:0] rs1,rs2,rdd;
wire [31:0] shifted_imm;
assign shifted_imm = imm << 1;

// IF stage
assign pc_in = (pc_src)  ? (pc_out + shifted_imm ) : (pc_out + 4);
program_counter pc(.clk(clk),
                   .reset(reset),
                   .pc_in(pc_in),
                   .pc_out(pc_out));
instruction_memory rom(.reset(reset),
                        .pc(pc_out),
                        .instr(instruction));
                        
// instruction decode stage
register_file registers(.clk(clk),
                        .reset(reset),
                        .read_address_port_a(instruction[19:15]),
                        .read_address_port_b(instruction[24:20]),
                        .write_address(instruction[11:7]),
                        .write_data(final_result),
                        .write_enable(Regwrite),
                        .read_data_port_a(data_a),
                        .read_data_port_b(data_b),
                        .r1(r1),
                        .r2(r2),
                        .r3(r3),
                        .r4(r4),
                        .r5(r5),
                        .r10(r10));
assign rs1 = instruction[19:15];
assign rs2 = instruction[24:20];
assign rdd = instruction[11:7];

control_unit  main_control_unit(.opcode(instruction[6:0]),
                               .immsel(immsel),
                               .aluop(aluop),
                               .regwrite_en(Regwrite),
                               .alusrc(alusrc),
                               .MemtoReg(MemtoReg),
                               .MemRead(MemRead),
                               .MemWrite(MemWrite),
                               .Branch(branch));    

imm_gen IMM_GEN(.instr(instruction),
                .imm_sel(immsel),
                .imm(imm));          

// EXECUTE STAGE
alucontrol ALU_CONTROL_UNIT(.aluop(aluop),
                            .funct3(instruction[14:12]),
                            .funct7_5(instruction[30]),
                            .alu_control(alucontrol));
                            
assign b = (alusrc)? imm : data_b;
                            
alu ALU(.a(data_a),
        .b(b),
        .alucontrol(alucontrol),
        .zeroflag(zeroflag),
        .aluresult(aluresult));
        
// Memory accesss
assign pc_src = branch & zeroflag;
data_memory ram(.clk(clk),
                .reset(reset),
                .Mem_read(MemRead),
                .Mem_write(MemWrite),
                .addr(aluresult),
                .write_data(data_b),
                .Read_data(data_memory_read));

// write back stage
assign final_result = (MemtoReg) ? data_memory_read : aluresult;
 

endmodule
