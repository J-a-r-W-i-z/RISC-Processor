module alu_select_control(
    input [1:0] alu_select,
    input [31:0] read_data_2,
    input [31:0] imm,
    input [31:0] offset,
    output reg [31:0] alu_input_2
    );
	
	always @(*) begin
		case(alu_select)
			2'b00:
				begin
					alu_input_2 <= imm;
				end
			2'b01:
				begin
					alu_input_2 <= offset;
				end
            2'b10:
                begin
                    alu_input_2 <= read_data_2;
                end
			default:
				begin
					alu_input_2 <= read_data_2;
				end
		endcase
	end

endmodule