.global _start
.text
.equ COUNTER_DELAY, 10000000

# code _start
_start:
    li s0, 0xFF200000       # address of LED
    li s1, 0xFF200050       # address of Keys
    addi s3, zero, 0        # s3 will be the increment register
    addi s4, zero, 0        # s4 will be the register for writing to the LEDs

POLL:
    lw s2, 12(s1)           # get edgecapture information - since any key works, don't need the data register
    bnez s2, UPDATE_INCR    # if any input, go to UPDATE_INCR
                            # otherwise keep counting
DO_COUNTER:
    add s4, s4, s3         # add prior value (s4) with increment (0 or 1)
    li t0, 256
    bne s4, t0, UPDATE_LED  # if not over 255 (if = 256), update directly
    addi s4, zero, 0        # else, reset to 0

UPDATE_LED:
    sw s4, 0(s0)
DO_DELAY:
    li s10, COUNTER_DELAY   # idk if it's la or li
SUB_LOOP:
    addi s10, s10, -1
    bnez s10, SUB_LOOP
    j POLL                  # go back to poll

UPDATE_INCR:
    sw s2, 12(s1)           # resetting edgecapture by storing s2 (the original input)
    xori s3, s3, 1          # xor s3 (which is either 0 or 1) to get the inverse
    j DO_COUNTER            # after updating keep counting