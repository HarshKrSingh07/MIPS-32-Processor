module data_memory (
    input wire [31:0] address,
    input wire [31:0] write_data,
    input wire mem_read,
    input wire mem_write,
    output reg [31:0] read_data
);
    reg [31:0] memory [0:255]; // 256 words of 32-bit memory
    
    always @(posedge mem_write) begin
        memory[address[31:2]] <= write_data; // Write operation
    end
    
    always @(*) begin
        if (mem_read)
            read_data = memory[address[31:2]]; // Read operation
    end
endmodule
