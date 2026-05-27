
module PC_Adder (
    input  [31:0] pc_in,
    output [31:0] pc_plus_4
);
    assign pc_plus_4 = pc_in + 32'd4;
endmodule


module Branch_Adder (
    input  [31:0] pc_plus_4,
    input  [31:0] branch_offset,
    output [31:0] branch_target
);
    assign branch_target = pc_plus_4 + branch_offset;
endmodule
