module mini_risc(
    input clk,
    input rst,
    output [31:0] process_out
);
    // pc
    wire [31:0] pc_in, pc_out;

    // inst memory
    wire [31:0] inst;
    
    // control unit
    wire memread, memwrite;
    wire [1:0] write_control, alu_source, write_reg;
    wire [2:0] branch_control, alu_op;

    // reg file
    wire [31:0] reg_read1, reg_read2, write_data;

    // sign extend
    wire [31:0] imm_val, offset_val;

    // alu select mux
    wire [31:0] alu_input2;

    // alu control
    wire [4:0] alu_control_signal;

    // alu
    wire [31:0] alu_out;
    wire [2:0] alu_flags;

    // branch control
    wire [31:0] branch_out;

    program_counter mod_pc(.pc_in(pc_in), .clk(clk), .rst(rst), .pc_out(pc_out));

    // instantiate inst memory

    register_file mod_reg_file(
        .rs(inst[25:21]),
        .rt(inst[20:16]),
        .writeReg(write_reg),
        .writeData(write_data),
        .clk(clk),
        .rst(rst),
        .read_data1(reg_read1),
        .read_data2(reg_read2),
    );

    control_unit mod_control_unit(
        .opcode(inst[31:26]),
        .branch(branch_control),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .write_control(write_control),
        .alu_op(alu_op),
        .alu_source(alu_source),
        .write_reg(write_reg)
    );

    sign_extend_16_to_32 mod_sign_extend1(.in(inst[20:5]), .out(imm_val));
    sign_extend_16_to_32 mod_sign_extend2(.in(inst[15:0]), .out(offset_val));

    alu_select_control mod_alu_select_mux(
        .alu_select(alu_source),
        .read_data_2(reg_read2),
        .imm(imm_val),
        .offset(offset_val),
        .alu_input_2(alu_input2)
    );

    alu_control mod_alu_control(
        .ALUop(alu_op),
        .function_code(inst[4:0]),
        .ALU_control_signal(alu_control_signal)
    );

    alu mod_alu(
        .input1(reg_read1),
        .input2(alu_input2),
        .shamt(inst[15:11]),
        .control(alu_control_signal),
        .out(alu_out),
        .flags(alu_flags)
    );
        

    branch_control mod_branch_control(
        .pc_in(pc_out),
        .abs_add({6'b000000, inst[25:0]}),
        .rel_add(imm_val),
        .read_data1(reg_read1),
        .funct(inst[4:0]),
        .control(branch_control),
        .flags(alu_flags),
        .pc_out(pc_in),
        .return_add(branch_out)
    );

    // instantiate data memory


endmodule