module control_unit(
    input [5:0] opcode,
    output reg [2:0] branch,
    output reg mem_read,
    output reg mem_write,
    output reg [1:0] write_control,
    output reg [2:0] alu_op,
    output reg [1:0]alu_source,
    output reg [1:0] write_reg
    );

/*
        
        OPCODE | ALUop | ALUsource  | WriteReg | MemWrite | MemRead | WriteConrol | Branch | Instructions
        __________________________________________________________________________________________________________
        000000 | 001   | 10         | 10       | 0        | 0       | 00       | 000    | add, comp, diff, AND, XOR
        000001 | 010   | 10         | 10       | 0        | 0       | 00       | 000    | shll, shrl, shra
        000011 | 011   | 10         | 10       | 0        | 0       | 00       | 000    | shllv, shrlv, shrav
        000010 | 000   | 10         | 00       | 0        | 0       | 00       | 001    | br
        000110 | 100   | 00         | 10       | 0        | 0       | 00       | 000    | addi, compi
        000111 | 101   | 10         | 01       | 0        | 0       | 00       | 010    | bltz, bz, bnz
        000101 | 110   | 01         | 11       | 0        | 1       | 01       | 000    | lw
        000100 | 111   | 01         | 00       | 1        | 1       | 00       | 000    | sw
        001100 | 000   | 10         | 01       | 0        | 0       | 00       | 011    | b
        001101 | 000   | 10         | 00       | 1        | 0       | 10       | 100    | bl
        001111 | 000   | 10         | 00       | 1        | 0       | 00       | 101    | bcy
        001011 | 000   | 10         | 00       | 1        | 0       | 00       | 110    | bncy
        
*/

always @(*) begin
        case(opcode)
            6'b000000:
                begin
                    branch <= 3'b000;
                    mem_read <= 1'b0;
                    mem_write <= 1'b0;
                    write_control <= 2'b00;
                    alu_op <= 3'b001;
                    alu_source <= 2'b10;
                    write_reg <= 2'b10;
                end
            6'b000001:
                begin
                    branch <= 3'b000;
                    mem_read <= 1'b0;
                    mem_write <= 1'b0;
                    write_control <= 2'b00;
                    alu_op <= 3'b010;
                    alu_source <= 2'b10;
                    write_reg <= 2'b10;
                end
            6'b000011:
                begin
                    branch <= 3'b000;
                    mem_read <= 1'b0;
                    mem_write <= 1'b0;
                    write_control <= 2'b00;
                    alu_op <= 3'b011;
                    alu_source <= 2'b10;
                    write_reg <= 2'b10;
                end
            6'b000010:
                begin
                    branch <= 3'b001;
                    mem_read <= 1'b0;
                    mem_write <= 1'b0;
                    write_control <= 2'b00;
                    alu_op <= 3'b000;
                    alu_source <= 2'b10;
                    write_reg <= 2'b00;
                end
            6'b000110:
                begin
                    branch <= 3'b000;
                    mem_read <= 1'b0;
                    mem_write <= 1'b0;
                    write_control <= 2'b00;
                    alu_op <= 3'b100;
                    alu_source <= 2'b00;
                    write_reg <= 2'b10;
                end
            6'b000111:
                begin
                    branch <= 3'b010;
                    mem_read <= 1'b0;
                    mem_write <= 1'b0;
                    write_control <= 2'b00;
                    alu_op <= 3'b101;
                    alu_source <= 2'b10;
                    write_reg <= 2'b01;
                end
            6'b000101:
                begin
                    branch <= 3'b000;
                    mem_read <= 1'b1;
                    mem_write <= 1'b0;
                    write_control <= 2'b01;
                    alu_op <= 3'b110;
                    alu_source <= 2'b01;
                    write_reg <= 2'b11;
                end
            6'b000100:
                begin
                    branch <= 3'b000;
                    mem_read <= 1'b1;
                    mem_write <= 1'b1;
                    write_control <= 2'b00;
                    alu_op <= 3'b111;
                    alu_source <= 2'b01;
                    write_reg <= 2'b00;
                end
            6'b001100:
                begin
                    branch <= 3'b011;
                    mem_read <= 1'b0;
                    mem_write <= 1'b0;
                    write_control <= 2'b10;
                    alu_op <= 3'b000;
                    alu_source <= 2'b10;
                    write_reg <= 2'b01;
                end
            6'b001101:
                begin
                    branch <= 3'b100;
                    mem_read <= 1'b0;
                    mem_write <= 1'b1;
                    write_control <= 2'b00;
                    alu_op <= 3'b000;
                    alu_source <= 2'b10;
                    write_reg <= 2'b00;
                end
            6'b001111:
                begin
                    branch <= 3'b101;
                    mem_read <= 1'b0;
                    mem_write <= 1'b1;
                    write_control <= 2'b00;
                    alu_op <= 3'b000;
                    alu_source <= 2'b10;
                    write_reg <= 2'b00;
                end
            6'b001011:
                begin
                    branch <= 3'b110;
                    mem_read <= 1'b0;
                    mem_write <= 1'b1;
                    write_control <= 2'b00;
                    alu_op <= 3'b000;
                    alu_source <= 2'b10;
                    write_reg <= 2'b00;
                end
            default:
                begin
                    branch <= 3'b000;
                    mem_read <= 1'b0;
                    mem_write <= 1'b0;
                    write_control <= 2'b00;
                    alu_op <= 3'b000;
                    alu_source <= 2'b00;
                    write_reg <= 2'b00;
                end
        endcase
    end

endmodule