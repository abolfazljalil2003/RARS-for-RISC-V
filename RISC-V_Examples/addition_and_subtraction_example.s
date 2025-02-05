
#f = (g + h) - (i + j);


    # Load g, h, i, j into registers
    lw x10, 0(x11)   # Load g into x10 (x11 contains the address of g)
    lw x12, 4(x11)   # Load h into x12 (x11 contains the address of h)
    lw x13, 8(x11)   # Load i into x13 (x11 contains the address of i)
    lw x14, 12(x11)  # Load j into x14 (x11 contains the address of j)

    # (g + h)
    add x15, x10, x12  # Add g and h, result in x15

    # (i + j)
    add x16, x13, x14  # Add i and j, result in x16

    # f = (g + h) - (i + j)
    sub x17, x15, x16  # Subtract (i + j) from (g + h), result in x17

    # Store the result in f
    sw x17, 0(x11)   # Store the result (f) back to the address of f
