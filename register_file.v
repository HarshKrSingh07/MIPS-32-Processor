module register_file (
    input wire clk,
    input wire reg_write_enable,
    input wire [4:0] reg_write_addr,
    input wire [31:0] reg_write_data,
    input wire [4:0] read_reg1,
    input wire [4:0] read_reg2,
    output reg [31:0] read_data1,
    output reg [31:0] read_data2
);
    reg [31:0] registers [0:31];
    
    always @(posedge clk) begin
        if (reg_write_enable)
            registers[reg_write_addr] <= reg_write_data;
    end
    
    always @(*) begin
        read_data1 = registers[read_reg1];
        read_data2 = registers[read_reg2];
    end
endmodule
