`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:18:46 08/31/2022 
// Design Name: 
// Module Name:    CLA_16_bit_LCU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CLA_16_bit_LCU(
	 input [15:0] in1,
    input [15:0] in2,
    input c_in,
    output [15:0] s_out,
    output c_out,
    output p,
    output g
    );

	wire [4:1] c_temp; 
	wire [3:0] P, G; 
	
	CLA_4_bit_augment m1(.in1(in1[3:0]), .in2(in2[3:0]), .c_in(c_in), .s_out(s_out[3:0]), .p(P[0]), .g(G[0]));
	CLA_4_bit_augment m2(.in1(in1[7:4]), .in2(in2[7:4]), .c_in(c_temp[1]), .s_out(s_out[7:4]), .p(P[1]), .g(G[1]));
	CLA_4_bit_augment m3(.in1(in1[11:8]), .in2(in2[11:8]), .c_in(c_temp[2]), .s_out(s_out[11:8]), .p(P[2]), .g(G[2]));
	CLA_4_bit_augment m4(.in1(in1[15:12]), .in2(in2[15:12]), .c_in(c_temp[3]), .s_out(s_out[15:12]), .p(P[3]), .g(G[3]));
	
	LCU m5(.c_in(c_in), .P(P), .G(G), .c_temp(c_temp), .P_out(p), .G_out(g));
	
	assign c_out = c_temp[4];

endmodule
