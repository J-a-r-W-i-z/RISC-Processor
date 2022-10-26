module alu_control(
    input [2:0] ALUop,
    input [4:0] function_code,
    output reg [4:0] ALU_control_signal
    );

    /*
        Assign the values based on the following table:


        ALUop (from control unit) - Function Code - Control Signal

        000                       - x             - 00000

        001                       - 00001         - 00001
        001                       - 00010         - 00010
        001                       - 00100         - 00011
        001                       - 01000         - 00100
        001                       - 10000         - 00101

        010                       - 00001         - 00110
        010                       - 00010         - 00111
        010                       - 00100         - 01000

        011                       - 00001         - 01001
        011                       - 00010         - 01010
        011                       - 00100         - 01011

        100                       - 00001         - 01100
        100                       - 00010         - 01101

        101                       - 00001         - 01110
        101                       - 00010         - 01111
        101                       - 00100         - 10000

        110                       - 00001         - 10001

        111                       - 00001         - 10010
    */

    always @(*) begin
        case(ALUop)
            3'b001:
                begin
                    case(function_code)
                        5'b00001: ALU_control_signal <= 5'b00001;
                        5'b00010: ALU_control_signal <= 5'b00010;
                        5'b00100: ALU_control_signal <= 5'b00011;
                        5'b01000: ALU_control_signal <= 5'b00100;
                        5'b10000: ALU_control_signal <= 5'b00101;
                        default: ALU_control_signal <= 5'b00000;
                    endcase
                end
            3'b010:
                begin
                    case(function_code)
                        5'b00001: ALU_control_signal <= 5'b00110;
                        5'b00010: ALU_control_signal <= 5'b00111;
                        5'b00100: ALU_control_signal <= 5'b01000;
                        default: ALU_control_signal <= 5'b00000;
                    endcase
                end
            3'b011:
                begin
                    case(function_code)
                        5'b00001: ALU_control_signal <= 5'b01001;
                        5'b00010: ALU_control_signal <= 5'b01010;
                        5'b00100: ALU_control_signal <= 5'b01011;
                        default: ALU_control_signal <= 5'b00000;
                    endcase
                end
            3'b100: 
                begin
                    case(function_code)
                        5'b00001: ALU_control_signal <= 5'b01100;
                        5'b00010: ALU_control_signal <= 5'b01101;
                        default: ALU_control_signal <= 5'b00000;
                    endcase
                end
            3'b101:
                begin
                    case(function_code)
                        5'b00001: ALU_control_signal <= 5'b01110;
                        5'b00010: ALU_control_signal <= 5'b01111;
                        5'b00100: ALU_control_signal <= 5'b10000;
                        default: ALU_control_signal <= 5'b00000;
                    endcase
                end
            3'b110: ALU_control_signal <= 5'b10001;
            3'b111: ALU_control_signal <= 5'b10010;
            default: ALU_control_signal <= 5'b00000;
        endcase
    end

endmodule