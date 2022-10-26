module write_control_mux(
    input [31:0] branch_out,
    input [31:0] mem_out,
    input [31:0] alu_out,
    input [1:0] write_control,
    output [31:0] write_data
);
    always @(*) begin
		case(write_control)
			2'b00:
                // alu operations
				begin
					write_data <= alu_out;
				end
			2'b01:
                // lw
				begin
					write_data <= mem_out;
				end
            2'b10:
                // bl
                begin
                    write_data <= branch_out;
                end
			default:
				begin
					write_data <= alu_out;
				end
		endcase
	end

endmodule