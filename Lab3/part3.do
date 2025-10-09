vlib work
vlog part3_2.v
# vlog part3.sv
vsim part3_tb

log {/*}
add wave {/*}

# Clock
force Clock 0 0, 1 5ns -repeat 10ns

# initial reset
force Reset_b 1
run 20ns
force Reset_b 0

# Test Cases:

# Case 0
force Data 4'b0011
force Function 3'b000
run 20ns

# Case 1
force Data 4'b0010
force Function 3'b001
run 20ns

# Case 2
force Data 4'b0001
force Function 3'b010
run 20ns

# Case 0
force Data 4'b0101
force Function 3'b000
run 20ns

# Case 3
force Function 3'b011
run 20ns

