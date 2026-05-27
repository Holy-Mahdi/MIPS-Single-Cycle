
module ALU (
    input [31:0] A,           
    input [31:0] B,          
    input [3:0] ALU_Control, 
    output reg [31:0] ALU_Result,
    output bcond 
);

   
    assign bcond = (ALU_Result == 32'b0) ? 1'b1 : 1'b0;

    always @(*) begin
        case (ALU_Control)
            4'b0000: ALU_Result = A & B;     
            4'b0001: ALU_Result = A | B;  
            4'b0010: ALU_Result = A + B;     
            4'b0110: ALU_Result = A - B;     
            4'b0111: ALU_Result = (A < B) ? 32'd1 : 32'd0;
            4'b1100: ALU_Result = ~(A | B); 
            default: ALU_Result = 32'b0;
        endcase
    end

endmodule
