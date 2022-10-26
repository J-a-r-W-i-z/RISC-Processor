module branch_control(
    input [31:0] pc_in,
    input [31:0] abs_add,
    input [31:0] rel_add,
    input [31:0] read_data1,
    input [4:0] funct,
    input [2:0] control,
    input [2:0] flags,
    output reg [31:0] pc_out,
    output reg [31:0] return_add
);
    reg [2:0] flags_stored;

    always @(posedge clk) begin
        if(rst)
            flags_stored <= 3'b000;
        else
            flags_stored <= flags;
    end

    always @(*) begin
        case(control)
    
            3'b001:
                // br
                begin
                    pc_out = read_data1;
                end
            3'b010:
                begin
                    case(funct[2:0])
                        3'b001:
                            // bltz
                            begin
                                if(flags_stored[2])
                                    pc_out = pc_in + rel_add;
                                else
                                    pc_out = pc_in + 1;
                            end
                        3'b010:
                            // bz
                            begin
                                if(flags_stored[0])
                                    pc_out = pc_in + rel_add;
                                else
                                    pc_out = pc_in + 1;
                            end
                        3'b100:
                            // bnz
                            begin
                                if(!flags_stored[2])
                                    pc_out = pc_in + rel_add;
                                else
                                    pc_out = pc_in + 1;
                            end
                    
                end
            3'b011:
                // b
                begin
                    pc_out = abs_add;
                end
            3'b100:
                // bl
                begin
                    pc_out = abs_add;
                    return_add = read_data1;
                end
            3'b101:
                // bcy
                begin
                    if(flags_stored[1])
                        pc_out = abs_add;
                    else
                        pc_out = pc_in + 1;       
                end
            3'b110:
                // bncy
                begin
                    if(!flags_stored[1])
                        pc_out = abs_add;
                    else
                        pc_out = pc_in + 1;
                end
            default:
                // for control = 3'b000 and other don't cares
                begin
                    pc_out = pc_in + 1;
                end
    end
    
endmodule