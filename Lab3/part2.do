vlib work
vlog part2.sv
vsim part2_tb

log {/*}
add wave {/*}

# Case 0: Addition
force A 4'b0001
force B 4'b0010
force Function 2'b00
run 10ns

force A 4'b1111
force B 4'b0001
force Function 2'b00
run 10ns

# Case 1: OR reduction (any bit set → ALUout=1)
force A 4'b0000
force B 4'b0000
force Function 2'b01
run 10ns

force A 4'b0101
force B 4'b0000
force Function 2'b01
run 10ns

# Case 2: AND reduction (all bits set → ALUout=1)
force A 4'b1111
force B 4'b1111
force Function 2'b10
run 10ns

force A 4'b1110
force B 4'b1111
force Function 2'b10
run 10ns

# Case 3: Concatenation {A,B}
force A 4'b1010
force B 4'b0101
force Function 2'b11
run 10ns
