# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in <filename>.sv to working dir
# could also have multiple verilog files
vlog part3.sv

#load simulation using mux as the top level simulation module
vsim mux

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# test cases

### T1
# switches
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0

# inputs
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
force {SW[9]} 0
run 10ns

### T2
# switches
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0

# inputs
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
force {SW[9]} 0
run 10ns

### T3
# switches
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0

# inputs
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
force {SW[9]} 0
run 10ns

### T4
# switches
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0

# inputs
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
force {SW[9]} 0
run 10ns