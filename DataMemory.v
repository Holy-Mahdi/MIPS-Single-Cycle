
    module Data_Memory (
        input clk,
        input [31:0] address,      
        input [31:0] write_data,  
        input MemRead,             
        input MemWrite,            
        output [31:0] read_data   
    );
    
        reg [31:0] data_mem [0:1023];

    
        always @(posedge clk) begin
            if (MemWrite) begin
            
                data_mem[address[31:2]] <= write_data;
            end
        end

    
        assign read_data = (MemRead) ? data_mem[address[31:2]] : 32'b0;


    endmodule
