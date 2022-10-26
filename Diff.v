module diff(input [31:0] in1, input [31:0] in2, output [31:0] out);
    wire [31:0] val, val2;
    assign val = in1^in2;
    assign val2 = val&(val-1);
    assign out = val^val2;
endmodule
