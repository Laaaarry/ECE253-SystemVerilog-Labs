# ===========================================================
#  RateDivider.do — ModelSim simulation script
# ===========================================================

# Clean and compile
vlib work
vlog rd.sv

# Start simulation
vsim work.RateDivider

# Add signals to waveform
add wave -position end sim:/RateDivider/*

# ===========================================================
# Create 10 ns clock (10 MHz)
# ===========================================================
force -repeat 10 ClockIn 0 0, 1 5

# ===========================================================
# Initial conditions and reset
# ===========================================================
force Speed 2'b00
force Reset 1

run 20

# Release reset
force Reset 0
run 20

# ===========================================================
# Test 1: Speed = 00 (Full rate)
# Expect Enable always high
# ===========================================================
force Speed 2'b00
run 100

# ===========================================================
# Test 2: Speed = 01 (1 Hz)
# Expect one pulse every CLOCK_FREQUENCY cycles
# (use small CLOCK_FREQUENCY parameter for visible results)
# ===========================================================
force Speed 2'b01
run 2000

# ===========================================================
# Test 3: Speed = 10 (0.5 Hz)
# Expect one pulse every 2 * CLOCK_FREQUENCY cycles
# ===========================================================
force Speed 2'b10
run 4000

# ===========================================================
# Test 4: Speed = 11 (0.25 Hz)
# Expect one pulse every 4 * CLOCK_FREQUENCY cycles
# ===========================================================
force Speed 2'b11
run 8000

# ===========================================================
# End simulation
# ===========================================================
run 20