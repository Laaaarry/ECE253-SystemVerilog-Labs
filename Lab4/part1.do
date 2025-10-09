# =====================================================
#  part1.do — ModelSim simulation script
#  Tests 4-bit rotate/shift register (part1.sv)
# =====================================================

# Clean up and compile
vlib work
vlog part1.sv

# Start simulation
vsim work.part1

# Add signals to waveform
add wave -position end sim:/part1/*

# =====================================================
# Clock generation (10 ns period)
# =====================================================
force -repeat 10 clock 0 0, 1 5

# =====================================================
# Initialize and reset
# =====================================================
force reset 1
force ParallelLoadn 1
force RotateRight 0
force ASRight 0
force Data_in 4'b0000
run 20

# Release reset
force reset 0
run 10

# =====================================================
# TEST 1: Parallel load
# =====================================================
# Load Data_in = 1000
force ParallelLoadn 0
force Data_in 4'b1000
run 10

# Enable hold (ParallelLoadn=0, no rotation yet)
force ParallelLoadn 0
run 20

# =====================================================
# TEST 2: Rotate Right (wrap-around)
# =====================================================
force ParallelLoadn 1
force RotateRight 1
force ASRight 0
run 80


# =====================================================
# TEST 3: Arithmetic Shift Right (MSB copies)
# =====================================================
force RotateRight 1
force ASRight 1
run 80

# =====================================================
# TEST 1: Parallel load
# =====================================================
# Load Data_in = 1000
force ParallelLoadn 0
force Data_in 4'b1000
run 10

# Enable hold (ParallelLoadn=0, no rotation yet)
force ParallelLoadn 0
run 20


# =====================================================
# TEST 4: Rotate Left
# =====================================================
force ParallelLoadn 1
force RotateRight 0
force ASRight 0
run 80

# =====================================================
# End simulation
# =====================================================
run 20
