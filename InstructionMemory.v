
module Instruction_Memory (
    input  [31:0] read_address,
    output [31:0] instruction
);
   reg [31:0] mem [0:1023];

    initial begin
        $readmemh("program.mem", mem);
    end

    assign instruction = mem[read_address[31:2]];

endmodule
