
#int fact(int n) {
#    if (n < 1) return 1;
#    else return n * fact(n-1);
#}


fact:
    addi sp, sp, -8    # Create stack space
    sw ra, 4(sp)       # Save return address (ra) on stack
    sw a0, 0(sp)       # Save argument (n) on stack
    slti t0, a0, 1     # Check if n < 1
    beq t0, zero, L1   # If n >= 1, go to L1 (recursive call)
    addi s0, zero, 1   # Return 1 in s0 (base case)
    addi sp, sp, 8     # Restore stack pointer
    jalr zero, 0(ra)   # Return from the function
L1:
    addi a0, a0, -1    # Decrease n (n = n - 1)
    jal ra, fact       # Recursive call to fact(n-1)
bk_f:
    lw a0, 0(sp)       # Restore n from stack
    lw ra, 4(sp)       # Restore return address (ra) from stack
    addi sp, sp, 8     # Restore stack pointer
    mul s0, a0, s0     # Multiply n * fact(n-1) and store in s0
    jalr zero, 0(ra)   # Return from the function
