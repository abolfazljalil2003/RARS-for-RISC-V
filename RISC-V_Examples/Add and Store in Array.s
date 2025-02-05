
#A[30] = h + A[30] + 1;





lw   x9, 120(x10)    # Load A[30] into register x9 (A is at address pointed by x10)
add  x9, x21, x9     # Add h (in register x21) to A[30] (in register x9)
addi x9, x9, 1       # Add 1 to the result stored in x9
sw   x9, 120(x10)    # Store the result back into A[30]
