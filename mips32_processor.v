module mips32_processor (
    input wire clk,
    input wire reset
);
    // Wires for interconnecting modules
    wire [31:0] pc, pc_next, instruction, alu_result, read_data;
    wire [31:0] reg_write_data;
    wire [4:0] reg_write_addr;
    wire reg_write_enable, mem_read, mem_write, alu_src, reg_dst, branch, jump;
    
    // Instantiate the Program Counter
    pc_register pc_reg (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc(pc)
    );
    
    // Instantiate the Instruction Memory
    instruction_memory inst_mem (
        .address(pc),
        .instruction(instruction)
    );
    
    // Instantiate the Control Unit
    control_unit ctrl (
        .opcode(instruction[31:26]),
        .reg_dst(reg_dst),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write_enable),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .jump(jump)
    );
    
    // Instantiate the Register File
    register_file reg_file (
        .clk(clk),
        .reg_write_enable(reg_write_enable),
        .reg_write_addr(reg_write_addr),
        .reg_write_data(reg_write_data),
        .read_reg1(instruction[25:21]),
        .read_reg2(instruction[20:16]),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );
    
    // Instantiate the ALU
    alu alu_unit (
        .input1(read_data1),
        .input2(alu_src ? instruction[15:0] : read_data2),
        .alu_control(alu_control),
        .alu_result(alu_result)
    );
    
    // Instantiate the Data Memory
    data_memory data_mem (
        .address(alu_result),
        .write_data(read_data2),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .read_data(read_data)
    );
    
    // ALU and Write Data Mux
    assign reg_write_data = mem_to_reg ? read_data : alu_result;
    assign reg_write_addr = reg_dst ? instruction[15:11] : instruction[20:16];
    
    // Calculate next PC
    assign pc_next = jump ? {pc[31:28], instruction[25:0], 2'b00} :
                         branch & (alu_result == 0) ? (pc + 4 + (instruction[15:0] << 2)) :
                         pc + 4;
endmodule
