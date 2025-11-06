# compile
vlib work
vlog part1.sv

# Start simulation
vsim work.part1

# Add signals to waveform
add wave -position end sim:/part1/*

# 10 ns clock
force -repeat 10 Clock 0 0, 1 5

force Reset 1
force w 0
run 25 ns

force Reset 0
run 20ns

force w 1
run 10 ns

force w 0
run 20 ns

# should output 1 - 1111 pattern
force w 1
run 40ns

# reset
force w 0
run 20 ns

# should output 1 - 1101, and then 1 again - 1111
force w 1
run 20 ns
force w 0
run 10 ns
force w 1
run 40ns

force w 0
run 20ns