
module Register_File (
    input clk,
    input RegWrite,
    input [4:0] read_reg1,  
    input [4:0] read_reg2,  
    input [4:0] write_reg, 
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);
  
    reg [31:0] registers [0:31];

   
    assign read_data1 = (read_reg1 == 5'b0) ? 32'b0 : registers[read_reg1];
    assign read_data2 = (read_reg2 == 5'b0) ? 32'b0 : registers[read_reg2];

    
    always @(posedge clk) begin
        if (RegWrite) begin
            if (write_reg != 5'b0) begin
                registers[write_reg] <= write_data;
            end
        end
    end

endmodule
