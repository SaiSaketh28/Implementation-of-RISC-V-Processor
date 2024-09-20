`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2024 16:01:01
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


module cpu(clk,reset,r1,r2,r3,r4,r4,r5,r10,pc_in,pc_out,imm,data_memory_read,instruction,final_result,data_a,data_b,alucontrol,b,aluresult,pc_src,zeroflag,branch,MemtoReg,MemRead,MemWrite,Regwrite,alusrc,aluop,immsel,rs1,rs2,rdd,data_a_out,Regwrite_MEM_WB,write_address_MEM_WB);
input clk,reset;
output [31:0] r1,r2,r3,r4,r5,r10;
output [31:0] pc_in,pc_out,imm,data_memory_read,data_a_out;
output pc_src;
output [31:0] instruction,final_result,data_a,data_b;
output [3:0] alucontrol;
output [31:0] b,aluresult;
output zeroflag,Regwrite_MEM_WB;
output [4:0] write_address_MEM_WB;

// control signs declaration
output branch,MemtoReg,MemRead,MemWrite,Regwrite,alusrc;
output [1:0] aluop,immsel;
output [4:0] rs1,rs2,rdd;
wire [31:0] shifted_imm;
assign shifted_imm = imm << 1;

// IF stage
wire [31:0] instruction_fetched,pc_IF_ID_out;
wire funct7_5,funct7_5_out;
wire [2:0] funct3,funct3_out;
assign funct3 = instruction[14:12];
assign funct7_5 = instruction[30];
wire [31:0] pc_EX_MEM_in,pc_EX_MEM_out;
wire [31:0] pc_ID_EX;

assign pc_EX_MEM_in = shifted_imm + pc_ID_EX;

assign pc_in = (pc_src) ? (pc_EX_MEM_out  ) : (pc_out + 4);
program_counter pc(.clk(clk),
                   .reset(reset),
                   .pc_in(pc_in),
                   .pc_out(pc_out));
instruction_memory rom(.reset(reset),
                        .pc(pc_out),
                        .instr(instruction_fetched));
                        
IF_ID_Register IF_ID (.clk(clk),.reset(reset),.pc_in(pc_out),
                      .instruction_fetched(instruction_fetched),
                      .instruction(instruction),
                      .pc_IF_ID(pc_IF_ID_out));
                        
// instruction decode stage
wire Regwrite_MEM_WB;

register_file registers(.clk(clk),
                        .reset(reset),
                        .read_address_port_a(instruction[19:15]),
                        .read_address_port_b(instruction[24:20]),
                        .write_address(instruction[11:7]),
                        .write_data(final_result),
                        .write_enable(Regwrite_MEM_WB),
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
wire [31:0] data_a_out,data_b_out,imm_out;
wire branch_ID_EX,Memwrite_ID_EX,MemRead_ID_EX,MemtoReg_ID_EX,alusrc_ID_EX,Regwrite_ID_EX;
wire [1:0] immsel_ID_EX;
wire [1:0]  aluop_ID_EX;
wire [4:0] write_address_ID_EX;
         
ID_EX_Register ID_EX(.clk(clk),.reset(reset),
                     .pc_in(pc_IF_ID_out),
                     .data_a(data_a),
                     .data_b(data_b),
                     .imm(imm),
                     .funct7_5(funct7_5),
                     .funct3(funct3),
                     .pc_out(pc_ID_EX),
                     .data_a_out(data_a_out),
                     .data_b_out(data_b_out),
                     .imm_out(imm_out),
                     .funct7_5_out(funct7_5_out),
                     .funct3_out(funct3_out),
                     .write_address_in(instruction[11:7]),
                     .write_address_out(write_address_ID_EX),
                     .branch(branch),
                     .branch_out(branch_ID_EX),
                     .Memwrite(MemWrite),
                     .Memwrite_out(Memwrite_ID_EX),
                     .MemRead(MemRead),
                     .MemRead_out(MemRead_ID_EX),
                     .MemtoReg(MemtoReg),
                     .MemtoReg_out(MemtoReg_ID_EX),
                     .alusrc(alusrc),
                     .alusrc_out(alusrc_ID_EX),
                     .regwrite_en(Regwrite),
                     .regwrite_en_out(Regwrite_ID_EX),
                     .aluop(aluop),
                     .aluop_out(aluop_ID_EX));    

// EXECUTE STAGE
wire [31:0] aluresult_EX_MEM,data_b_EX_MEM;
wire [4:0] write_address_EX_MEM_out;
wire zeroflag_out;
wire branch_EX_MEM,Memwrite_EX_MEM,MemRead_EX_MEM,Regwrite_EX_MEM,MemtoReg_EX_MEM;
EX_MEM_Register EX_MEM(.clk(clk),.reset(reset),
                        .pc_in(pc_EX_MEM_in),
                        .zero(zeroflag),
                        .aluresult_in(aluresult),
                        .data_b_in(data_b_out),
                        .write_address_in(write_address_ID_EX),
                        .pc_out(pc_EX_MEM_out),
                        .zero_out(zeroflag_out),
                        .aluresult_out(aluresult_EX_MEM),
                        .data_b_out(data_b_EX_MEM),
                        .write_address_out(write_address_EX_MEM_out),
                        .branch(branch_ID_EX),
                        .Memwrite(Memwrite_ID_EX),
                        .MemRead(MemRead_ID_EX),
                        .regwrite_en(Regwrite_ID_EX),
                        .MemtoReg(MemtoReg_ID_EX),
                        .branch_out(branch_EX_MEM),
                        .Memwrite_out(Memwrite_EX_MEM),
                        .MemRead_out(MemRead_EX_MEM),
                        .regwrite_en_out(Regwrite_EX_MEM),
                        .MemtoReg_out(MemtoReg_EX_MEM));
                        
                        
alucontrol ALU_CONTROL_UNIT(.aluop(aluop_ID_EX),
                            .funct3(funct3_out),
                            .funct7_5(funct7_5_out),
                            .alu_control(alucontrol));
                            
assign b = (alusrc_ID_EX)? imm_out : data_b_out;
                            
alu ALU(.a(data_a_out),
        .b(b),
        .alucontrol(alucontrol),
        .zeroflag(zeroflag),
        .aluresult(aluresult));
        
// Memory accesss
wire MemtoReg_MEM_WB;
wire [4:0] write_address_MEM_WB;
wire [31:0] data_memory_read_out,aluresult_MEM_WB;

assign pc_src = branch_EX_MEM & zeroflag_out;


MEM_WB_Register MEM_WB(.clk(clk),.reset(reset),
                        .MemtoReg(MemtoReg_EX_MEM),
                        .Regwrite_en(Regwrite_EX_MEM),
                        .read_data(data_memory_read),
                        .aluresult_in(aluresult_EX_MEM),
                        .write_address_in(write_address_EX_MEM_out),
                         .MemtoReg_out(MemtoReg_MEM_WB),
                         .Regwrite_en_out(Regwrite_MEM_WB),
                         .read_data_out(data_memory_read_out),
                         .aluresult_out(aluresult_MEM_WB),
                         .write_address_out(write_address_MEM_WB));
                         
data_memory ram(.clk(clk),
                .reset(reset),
                .Mem_read(MemRead_EX_MEM),
                .Mem_write(Memwrite_EX_MEM),
                .addr(aluresult_EX_MEM),
                .write_data(data_b_out),
                .Read_data(data_memory_read));

// write back stage
assign final_result = (MemtoReg_MEM_WB) ? data_memory_read_out : aluresult_MEM_WB;
 

endmodule
