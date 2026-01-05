.global _start
.text

# code _start
_start:
    li s0, 0xFF200000       # address of LED
    li s1, 0xFF200050       # address of Keys
    addi s4, zero, 0        # s4 will be the register for writing to the LEDs
    j UPDATE                # initialization of LEDs
    
    # use s2 as input from 

POLL:
    lw s2, 0(s1)            # get data register value from keys
    beqz s2, POLL           # if no input, keep polling

WAIT:                       # want to wait for key release
    lw s3, 0(s1)
    bnez s3, WAIT           # s3 no longer needed after WAIT

K0:
    li s3, 1 # 0b0001
    and s5, s2, s3         # mask other inputs
    bne s5, s3, K1          # if not key0, go to key1
    addi s4, zero, 1        # set LED to 1
    j UPDATE

K1:
    li s3, 2 # 0b0010
    and s5, s2, s3         # mask other inputs
    bne s5, s3, K2          # if not key1, go to key2
    li t0, 15
    bge s4, t0, K1_sub      # check if exceeded max value
    addi s4, s4, 1          # increment LED
    j UPDATE

K1_sub:
    li s4, 15               # ensure s4 stays at 15
    j UPDATE

K2:
    li s3, 4 # 0b0100
    and s5, s2, s3 # mask other inputs
    bne s5, s3, K3          # if not key2, got to key3
    li t0, 1
    ble s4, t0, K2_sub      # check if smaller than minimum value
    addi s4, s4, -1
    j UPDATE

K2_sub:
    li s4, 1                # ensure s4 stays at 1 (including the 0 case after pressing K3)
    j UPDATE

K3:
    # only possibility remaining is key3 was pressed
    li s4, 0                # reset s4 to 0
    j UPDATE

UPDATE:
    sw s4, 0(s0)            # update LEDs
    j POLL