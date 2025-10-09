vlib work
vlog part1.sv
vsim part1_tb

log {/*}
add wave {/*}

# test cases
force {a} 4'b0001
force {b} 4'b0001
force {c_in} 1'b0
run 10ns

# test cases
force {a} 4'b0011
force {b} 4'b0011
force {c_in} 1'b0
run 10ns