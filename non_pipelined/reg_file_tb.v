`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2024 12:38:00
// Design Name: 
// Module Name: reg_file_tb
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


module reg_file_tb();
reg [4:0] read_address_port_a,read_address_port_b,write_address;
reg [31:0] write_data;
reg clk,reset,write_enable;
wire [31:0] read_data_port_a, read_data_port_b;

register_file dummi(clk,reset,read_address_port_a,read_address_port_b,write_address,write_data,write_enable,read_data_port_a,read_data_port_b);
initial
begin
    clk =1'b0;
    reset =1'b1;
    write_enable =1'b0;
    read_address_port_a =32'b0;
    read_address_port_b = 32'b0;
end
always #5 clk = ~clk;
initial
begin
    #15 read_address_port_a = 5'b00001;
    #10 read_address_port_b = 5'b00010;
    // #13 write_enable =1'b1 ; write_address=5'b01111 ; write_data = 32'b00000000000000000000000000001100;
    #20 read_address_port_b = 5'b01111;
end

endmodule
