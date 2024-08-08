module instruction_memory (
    input wire [31:0] address,
    output reg [31:0] instruction
);
    reg [31:0] memory [0:255]; // 256 words of 32-bit memory
    
    initial begin
        // Initialize memory with instructions
        $readmemh("instructions.hex", memory);
    end
    
    always @(*) begin
        instruction = memory[address[31:2]]; // Word-aligned access
    end
endmodule
