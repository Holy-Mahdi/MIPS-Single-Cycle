module Shift_Left_2_Jump (
    input  [25:0] data_in,
    output [27:0] data_out
);
    assign data_out = {data_in, 2'b00};
endmodule


module Shift_Left_2_Branch (
    input  [31:0] data_in,
    output [31:0] data_out
);
    assign data_out = data_in << 2;
  
endmodule
