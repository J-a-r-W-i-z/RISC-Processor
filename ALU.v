module alu(
    input signed [31:0] input1,
    input [31:0] input2,
    input [4:0] shamt,
    input [4:0] control,
    output reg [31:0] out,
    output reg [2:0] flags      // flags[0]: zero (to handle bz/bnz)
                                // flags[1]: carry (to handle bcy/bncy)
                                // flags[2]: sign of input1 (to handle bltz) 
    );

    wire [31:0] sum, diff, complement, bit_and, bit_xor, sll, srl, sra;
    wire sumcarry;
    wire [31:0] shamt_muxout;

    adder a1 (.in1(input1), .in2(input2), .out(sum), .carry(sumcarry));

    diff d1 (.in1(input1), .in2(input2), .out(diff));

    assign complement = ~input1 + 1'b1;
    assign bit_and = input1 & input2;
    assign bit_xor = input1 ^ input2;

    assign shamt_muxout = control[4] ? {27'b0, shamt}: input2;

    assign sll = input1 << shamt_muxout;
    assign srl = input1 >> shamt_muxout;
    assign sra = input1 >>> shamt_muxout;

    always @(*) begin
		flags[0] = (input1 == 32'b0) ? 1'b1 : 1'b0;
		flags[2] = input1[31];
        case(control[4:0])
            5'd0: 
                begin
                    // Branch Instructions
                end
            5'd1:
                begin
                    // Add
                    out = sum;
                    flags[1] = sumcarry;
                end
            5'd2:
                begin
                    // Complement
                    out = complement;
                    flags[1] = 1'b0;
                end
            5'd3:
                begin
                    // AND
                    out = bit_and;
                    flags[1] = 1'b0;
                end
            5'd4:
                begin
                    // XOR
                    out = bit_xor;
                    flags[1] = 1'b0;
                end
            5'd5:
                begin
                    // Diff
                    out = diff;
                    flags[1] = 1'b0;
                end

            5'd16: 
                begin
                    // Shift left logical
                    out = sll;
                    flags[1] = 1'b0;

                end
            5'd17:
                begin
                    // Shift right logical
                    out = srl;
                    flags[1] = 1'b0;
                end
            5'd18:
                begin
                    // Shift right arithemetic
                    out = sra;
                    flags[1] = 1'b0;
                end

            5'd6:
                begin
                    // Shift left logical variable
                    out = sll;
                    flags[1] = 1'b0;
                end
            5'd7:
                begin
                    // Shift right logical variable
                    out = srl;
                    flags[1] = 1'b0;
                end
            5'd8:
                begin
                    // Shift right arithemetic variable
                    out = sra;
                    flags[1] = 1'b0;
                end
            5'd9: 
                begin
                    // Addi
                    out = sum;
                    flags[1] = sumcarry;
                end
            5'd10:
                begin
                    // Compi
                    out = complement;
                    flags[1] = 1'b0;
                end
            5'd11:
                begin
                    // Bltz
                end
            5'd12:
                begin
                    // bz
                end
            5'd13:
                begin
                    // bnz
                end
            5'd14:
                begin
                    // lw
                end
            5'd15:
                begin
                    // sw 
                end
            
            default:
                begin
                    out = 32'b0;
                    flags[2] = 1'b0;
                end
        endcase
    end
endmodule