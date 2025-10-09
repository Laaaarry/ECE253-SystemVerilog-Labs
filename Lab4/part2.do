# ===========================================================
#  part2.do — Simulation script for RateDivider + DisplayCounter
# ===========================================================

# Clean and compile
vlib work
vlog part2.sv

# Load top-level module, override CLOCK_FREQUENCY for short simulation
vsim work.part2 -gCLOCK_FREQUENCY=16

# ===========================================================
# Add signals to waveform viewer
# ===========================================================
add wave -position end sim:/part2/*
add wave sim:/part2/u0/*     ;# RateDivider internals
add wave sim:/part2/u1/*     ;# DisplayCounter internals

# ===========================================================
# Create a 100 MHz clock (10 ns period)
# ===========================================================
force -repeat 10 ClockIn 0 0, 1 5

# ===========================================================
# Apply reset
# ===========================================================
force Reset 1
force Speed 2'b00
run 20
force Reset 0
run 20

# ===========================================================
# TEST 1 — Speed = 00 (Full rate)
# -----------------------------------------------------------
# Expected: Enable = 1 every clock cycle (always high)
# CounterValue increments every 10 ns
# Example:
#   t=0ns:   CounterValue = 0000
#   t=10ns:  CounterValue = 0001
#   t=20ns:  CounterValue = 0010
#   ...
# ===========================================================
force Speed 2'b00
run 200

# ===========================================================
# TEST 2 — Speed = 01 (1 Hz equivalent)
# -----------------------------------------------------------
# CLOCK_FREQUENCY=16 → Enable pulse every 16 clock cycles
#   → 16 * 10 ns = 160 ns between Enable pulses
#
# Expected:
#   t=0ns:   CounterValue = 0000
#   t=160ns: CounterValue = 0001
#   t=320ns: CounterValue = 0010
#   t=480ns: CounterValue = 0011
#   ...
# ===========================================================
force Speed 2'b01
run 800

# ===========================================================
# TEST 3 — Speed = 10 (0.5 Hz equivalent)
# -----------------------------------------------------------
# Enable pulse every 32 clock cycles
#   → 32 * 10 ns = 320 ns between pulses
#
# Expected:
#   t=0ns:   CounterValue = 0000
#   t=320ns: CounterValue = 0001
#   t=640ns: CounterValue = 0010
#   t=960ns: CounterValue = 0011
#   ...
# ===========================================================
force Speed 2'b10
run 1600

# ===========================================================
# TEST 4 — Speed = 11 (0.25 Hz equivalent)
# -----------------------------------------------------------
# Enable pulse every 64 clock cycles
#   → 64 * 10 ns = 640 ns between pulses
#
# Expected:
#   t=0ns:   CounterValue = 0000
#   t=640ns: CounterValue = 0001
#   t=1280ns: CounterValue = 0010
#   t=1920ns: CounterValue = 0011
#   ...
# ===========================================================
force Speed 2'b11
run 3200

# ===========================================================
# End of simulation
# ===========================================================
run 20