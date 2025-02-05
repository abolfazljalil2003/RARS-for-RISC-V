

#int leaf_ex(int g, int h, int i, int j) {
#    int f = (g + h) - (i + j);
#    return f;
#}


leaf_ex:
    addi sp, sp, -8      # Create space on stack to save registers
    sw t1, 4(sp)         # Save t1 to stack (save i + j result)
    sw t0, 0(sp)         # Save t0 to stack (save g + h result)
    
    add t0, a0, a1       # t0 = g + h (add arguments g and h)
    add t1, a2, a3       # t1 = i + j (add arguments i and j)
    
    sub s0, t0, t1       # s0 = t0 - t1 (f = (g + h) - (i + j))

    lw t0, 0(sp)         # Restore t0 (g + h result)
    lw t1, 4(sp)         # Restore t1 (i + j result)
    
    addi sp, sp, 8       # Restore stack pointer (cleanup stack space)
    jalr zero, 0(ra)     # Return to caller
