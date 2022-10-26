`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:05:47 08/31/2022 
// Design Name: 
// Module Name:    CLA_4_bit_augment 
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
module CLA_4_bit_augment(
	input[3:0] in1,
	input[3:0] in2,
	input c_in,
	output [3:0] s_out,
	output p,
	output g
    );
	 
	 wire [3:0] G,P, c_temp;
	 
	 assign G = in1 & in2;
	 assign P = in1 ^ in2;
	 
	 assign c_temp[0] = c_in;
	 assign c_temp[1] = G[0] | (P[0] & c_temp[0]);
	 assign c_temp[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & c_temp[0]);
	 assign c_temp[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & c_temp[0]);
	 
	 assign s_out = P ^ c_temp;
	 
	 assign p = P[3] & P[2] & P[1] & P[0];
	 assign g = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);


endmodule
