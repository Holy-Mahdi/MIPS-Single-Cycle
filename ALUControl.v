
module ALU_Control_Unit (
    input [1:0] ALUOp,        
    input [5:0] Funct,      
    output reg [3:0] ALU_Cont
);

    always @(*) begin
        case (ALUOp)
            
            2'b00: ALU_Cont = 4'b0010;
            
           
            2'b01: ALU_Cont = 4'b0110;
            
           
            2'b10: begin
                case (Funct)
                    6'h20: ALU_Cont = 4'b0010; 
                    6'h22: ALU_Cont = 4'b0110; 
                    6'h24: ALU_Cont = 4'b0000; 
                    6'h25: ALU_Cont = 4'b0001; 
                    6'h2A: ALU_Cont = 4'b0111;
                    default: ALU_Cont = 4'b0000;
                endcase
            end
            
           
            default: ALU_Cont = 4'b0010;
        endcase
    end

endmodule
