    # part1.s  –  Count maximum number of consecutive 1-bits using subroutine ONES

    .global _start
    .text

# main section
_start:
    la   t0, LIST        # t0 = address of LIST
    lw   a0, 0(t0)       # a0 = input value (word whose bits to analyze)

    jal  ra, ONES        # call ONES(a0); result returned in a0

    mv s10, a0
END: j END

# subroutine
# Input : a0 = 32-bit value
# Output: a0 = maximum number of consecutive 1 bits

ONES:
    addi t0, a0, 0       # t0 = x  (working copy of input)
    addi t1, zero, 0     # t1 = count (result accumulator)

ONES_LOOP:
    beqz t0, ONES_DONE   # if x == 0, we're done

    srli t2, t0, 1       # t2 = x >> 1   (logical shift right)
    and  t0, t0, t2      # x = x & (x >> 1)
    addi t1, t1, 1       # count++

    j    ONES_LOOP

ONES_DONE:
    add  a0, t1, zero    # move result into a0 (return value)
    jr   ra              # return to caller

# ----------------- data section -----------------
    .global LIST
    .data
LIST:
    .word 0x103fe00f     # test value
