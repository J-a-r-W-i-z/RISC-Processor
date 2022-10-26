`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:13:31 08/31/2022 
// Design Name: 
// Module Name:    LCU 
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
module LCU(
	 input c_in,
    input [3:0] P,
    input [3:0] G,
    output [4:1] c_temp,
    output P_out,
    output G_out
    );

	assign c_temp[1] = G[0] | (P[0] & c_in);
	assign c_temp[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & c_in);
	assign c_temp[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & c_in);
	assign c_temp[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & c_in);
	
	assign P_out = P[3] & P[2] & P[1] & P[0];
	assign G_out = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
endmodule
