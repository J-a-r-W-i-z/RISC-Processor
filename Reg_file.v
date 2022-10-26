module register_file(
    input [4:0] rs,
    input [4:0] rt,
    input [1:0] writeReg,
    input [31:0] writeData,
    input clk,
    input rst,
    output [31:0] read_data1,
    output [31:0] read_data2,
    );

    reg [31:0] registers[31:0];
    integer i;

    always @(posedge clk) begin
        if(rst) begin
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'd0;

        end 
        else begin
            case(writeReg)
                2'b10:
                    begin
                        registers[rs] <= writeData;
                    end 
                2'b11:
                    begin
                        registers[rt] <= writeData;
                    end
                2'b01:
                    begin
                        registers[5'b11111] <= writeData;
                    end
                2'b00
                default:
                    begin
                        // do nothing
                    end 
            endcase
        end
    end

    assign read_data1 = registers[rs];
    assign read_data2 = registers[rt];
endmodule