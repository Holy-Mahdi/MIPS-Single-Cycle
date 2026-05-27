
module MIPS_Single_Cycle (
    input clk,
    input reset
);

    
    wire [31:0] pc_current, pc_next, pc_plus4;
    wire [31:0] instruction;
    wire [31:0] read_data1, read_data2, write_data_reg;
    wire [31:0] sign_ext_imm, shifted_imm, branch_target, jump_target;
    wire [31:0] alu_operand2, alu_result;
    wire [31:0] mem_read_data;
    wire [3:0]  alu_control_signal;
    wire [4:0]  write_reg_addr;
    
   
    wire reg_dst, jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write;
    wire [1:0] alu_op;
    wire alu_zero;

    
    ProgramCounter pc_unit (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_next),
        .pc_out(pc_current)
    );

    PC_Adder pc_adder_unit (
        .pc_in(pc_current),
        .pc_plus_4(pc_plus4)
    );

    
    Instruction_Memory inst_mem (
        .read_address(pc_current),
        .instruction(instruction)
    );

    
    Main_Control control_unit (
        .Opcode(instruction[31:26]),
        .RegDst(reg_dst),
        .Jump(jump),
        .Branch(branch),
        .MemRead(mem_read),
        .MemtoReg(mem_to_reg),
        .ALUOp(alu_op),
        .MemWrite(mem_write),
        .ALUSrc(alu_src),
        .RegWrite(reg_write)
    );

    assign write_reg_addr = (reg_dst) ? instruction[15:11] : instruction[20:16];

    Register_File reg_file (
        .clk(clk),
        .RegWrite(reg_write),
        .read_reg1(instruction[25:21]),
        .read_reg2(instruction[20:16]),
        .write_reg(write_reg_addr),
        .write_data(write_data_reg),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    
    sign_extend_16to32 sign_ext (
        .in(instruction[15:0]),
        .out(sign_ext_imm)
    );

    
    ALU_Control_Unit alu_ctrl (
        .ALUOp(alu_op),
        .Funct(instruction[5:0]),
        .ALU_Cont(alu_control_signal)
    );

   
    assign alu_operand2 = (alu_src) ? sign_ext_imm : read_data2;

    ALU alu_unit (
        .A(read_data1),
        .B(alu_operand2),
        .ALU_Control(alu_control_signal),
        .ALU_Result(alu_result),
        .bcond(alu_zero)
    );

    
    Data_Memory data_mem (
        .clk(clk),
        .address(alu_result),
        .write_data(read_data2),
        .MemRead(mem_read),
        .MemWrite(mem_write),
        .read_data(mem_read_data)
    );

   
    assign write_data_reg = (mem_to_reg) ? mem_read_data : alu_result;

   
    Shift_Left_2_Branch branch_shifter (
        .data_in(sign_ext_imm),
        .data_out(shifted_imm)
    );

    Branch_Adder br_adder (
        .pc_plus_4(pc_plus4),
        .branch_offset(shifted_imm),
        .branch_target(branch_target)
    );

   
    wire [31:0] pc_after_branch;
    assign pc_after_branch = (branch & alu_zero) ? branch_target : pc_plus4;

    
    assign jump_target = {pc_plus4[31:28], instruction[25:0], 2'b00};

    
    assign pc_next = (jump) ? jump_target : pc_after_branch;

endmodule
