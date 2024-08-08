module alu (
    input wire [31:0] input1,
    input wire [31:0] input2,
    input wire [3:0] alu_control,
    output reg [31:0] alu_result
);
    always @(*) begin
        case (alu_control)
            4'b0010: alu_result = input1 + input2; // ADD
            4'b0110: alu_result = input1 - input2; // SUB
            4'b0000: alu_result = input1 & input2; // AND
            4'b0001: alu_result = input1 | input2; // OR
            // Additional ALU operations here
            default: alu_result = 0;
        endcase
    end
endmodule
