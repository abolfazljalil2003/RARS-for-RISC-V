#while (save[i] == k)
#    i += 1;


Loop: 
    slli x10, x22, 2         # x10 = i * 4 (for accessing save[i], since each element is 4 bytes)
    add x10, x10, x25        # x10 = x10 + base_address (to get the address of save[i])
    lw x9, 0(x10)            # Load save[i] into x9
    bne x9, x24, Exit        # If save[i] != k, exit the loop
    addi x22, x22, 1         # Increment i (i = i + 1)
    beq x0, x0, Loop         # Go back to the beginning of the loop
Exit:
