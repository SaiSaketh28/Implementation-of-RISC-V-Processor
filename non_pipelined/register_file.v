`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2024 12:17:12
// Design Name: 
// Module Name: register_file
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


    module register_file(clk,reset,read_address_port_a,read_address_port_b,write_address,write_data,write_enable,read_data_port_a,read_data_port_b,r1,r2,r3,r4,r5,r10);
    input clk,reset;
    
    output wire [31:0] r1,r2,r3,r4,r5,r10;
    // Port A declartion
    input [4:0] read_address_port_a;
    output [31:0] read_data_port_a;
    
    
    // Port B declartion
    input [4:0] read_address_port_b;
    output  [31:0] read_data_port_b;
    
    // write declartion
    input [31:0] write_data;
    input [4:0] write_address;
    input write_enable;
    
    // internal reg_file declartion
    reg [31:0] reg_file [31:0];
    integer i;
    
    // we can initialize the memory by using the $readmemb function also
    
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            begin
            for(i =0; i<32; i=i+1)
                reg_file[i] = {27'b0,i}; 
            end
        else
            begin
            if(write_enable)
                begin
                    reg_file[write_address] = write_data;
                end
            end
    end
    
    // reading the data from the register file
    assign r1 = reg_file[1];
    assign r2 = reg_file[2];
    assign r3 = reg_file[3];
    assign r4 = reg_file[4];
    assign r5 = reg_file[5];
    assign r10 = reg_file[10];
    //assign r2 = reg_file[2];

    assign read_data_port_a = (read_address_port_a==5'b0)? 32'b0 : reg_file[read_address_port_a];
    assign read_data_port_b = (read_address_port_b==5'b0)? 32'b0 : reg_file[read_address_port_b];

    endmodule
