module Main_Control (
    input [5:0] Opcode,    
    output reg RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
    output reg [1:0] ALUOp 
);

    always @(*) begin
        
        {RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite} = 10'b0;

        case (Opcode)
            6'b000000: begin 
                RegDst   = 1;
                ALUOp    = 2'b10;
                RegWrite = 1;
            end

            6'b001000: begin 
                ALUSrc   = 1;
                ALUOp    = 2'b00;
                RegWrite = 1;
                RegDst   = 0;
            end

            6'b100011: begin
                ALUSrc   = 1;
                MemtoReg = 1;
                MemRead  = 1;
                RegWrite = 1;
            end

            6'b101011: begin 
                ALUSrc   = 1;
                MemWrite = 1;
            end

            6'b000100: begin 
                Branch   = 1;
                ALUOp    = 2'b01;
            end

            6'b000010: begin
                Jump     = 1;
            end
        endcase
    end
endmodule

