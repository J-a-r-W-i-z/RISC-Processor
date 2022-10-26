module adder(
    input [31:0] in1,
    input [31:0] in2,
    output [31:0] out,
    output carry
);

    wire [31:0] sum;
    wire sum_c_out, p1, g1, p2, g2, sumcarry;

    CLA_16_bit_LCU m1 (.in1(in1[15:0]), .in2(in2[15:0]), .c_in(1'b0), .s_out(sum[15:0]), .c_out(sum_c_out), .p(p1), .g(g1));
	CLA_16_bit_LCU m2 (.in1(in1[31:16]), .in2(in2[31:16]), .c_in(sum_c_out), .s_out(sum[31:16]), .c_out(sumcarry), .p(p2), .g(g2));

    assign out = sum;
    assign carry = sumcarry;

endmodule