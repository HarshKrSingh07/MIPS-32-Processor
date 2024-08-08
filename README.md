# MIPS-32-Processor

This project implements a MIPS32 processor in Verilog. The design includes various modules such as the Program Counter, Instruction Memory, Register File, ALU, Data Memory, and Control Unit, all orchestrated by a top-level processor module.

Modules
mips32_processor.v: Top-level module that instantiates and connects all other modules.
pc_register.v: Program Counter (PC) module.
instruction_memory.v: Module for instruction memory, initialized from instructions.hex.
register_file.v: Register File module.
alu.v: Arithmetic Logic Unit (ALU) module.
data_memory.v: Data Memory module.
control_unit.v: Control Unit module that generates control signals.
tb_mips32_processor.v: Testbench for simulating the MIPS32 processor.
