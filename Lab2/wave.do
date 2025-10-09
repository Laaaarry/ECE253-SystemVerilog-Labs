# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in <filename>.sv to working dir
# could also have multiple verilog files
vlog part2.sv

#load simulation using mux as the top level simulation module
vsim mux

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# test cases
# SW=0
force {SW[0]} 0
force {SW[1]} 0
force {SW[9]} 0
run 10ns

force {SW[0]} 1
force {SW[1]} 0
force {SW[9]} 0
run 10ns

force {SW[0]} 0
force {SW[1]} 1
force {SW[9]} 0
run 10ns

force {SW[0]} 1
force {SW[1]} 1
force {SW[9]} 0
run 10ns

#SW=1
force {SW[0]} 0
force {SW[1]} 0
force {SW[9]} 1
run 10ns

force {SW[0]} 1
force {SW[1]} 0
force {SW[9]} 1
run 10ns

force {SW[0]} 0
force {SW[1]} 1
force {SW[9]} 1
run 10ns

force {SW[0]} 1
force {SW[1]} 1
force {SW[9]} 1
run 10ns