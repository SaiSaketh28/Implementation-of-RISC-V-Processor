`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2024 17:15:49
// Design Name: 
// Module Name: data_memory
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


module data_memory(clk,reset,Mem_read,Mem_write,addr,write_data,Read_data);
input clk,reset,Mem_read,Mem_write;
input [31:0] addr,write_data;
output  [31:0] Read_data;
integer i;

// declaring the internal memory
reg [7:0] ram [(2^31)-1 : 0] ;
wire [31:0] ram_output;
always @(posedge clk , reset)
begin
    if(reset)
    begin
        for(i=0; i<(2^31); i=i+1)
            ram[i] = 0;
    end
    else
        begin
        if(Mem_write)
            begin
                ram[addr] = write_data[7:0];
                ram[addr+1] = write_data[15:8];
                ram[addr+2] = write_data[23:16];
                ram[addr+3] = write_data[31:24];
            end
        end
end

assign ram_output = {ram[addr+3],ram[addr+2],ram[addr+1],ram[addr]};
assign  Read_data = (Mem_read)? ram_output : 32'bx;

endmodule
