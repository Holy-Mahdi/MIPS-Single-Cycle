
`timescale 1ns / 1ps

module tb_MIPS();
    reg clk;
    reg reset;

    
    MIPS_Single_Cycle uut (
        .clk(clk),
        .reset(reset)
    );

    
    always #5 clk = ~clk;

    initial begin
    
        clk = 0;
        reset = 1;

     
        #15 reset = 0;

       
        #100;

     
        $display("Testing Finished.");
        $finish;
    end

  
    initial begin
        $dumpfile("mips_test.vcd");
        $dumpvars(0, tb_MIPS);
    end
endmodule
