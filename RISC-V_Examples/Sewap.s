# Function: swap
# This function swaps the values in memory addresses stored at $4 and $5.
# The function assumes that the values to be swapped are located in two consecutive memory locations.


#  swap(int v[], int k)
# {
#      int temp;
#      temp = v[k];
#      v[k] = v[k+1];
#     v[k+1] = temp;
#}

swap:
    # sll $2, $5, 2
    # Shift the value in register $5 left by 2 bits (equivalent to multiplying by 4)
    # This is used to convert the address in $5 (which is in word units) to byte address.
    sll $2, $5, 2
    
    # add $2, $4, $2
    # Add the value of $4 to $2 to get the memory address of the first value.
    # The address where the first value is stored is now in $2.
    add $2, $4, $2
    
    # lw $15, 0($2)
    # Load the word from memory at address in $2 (which holds the address of the first value)
    # into register $15.
    lw $15, 0($2)
    
    # lw $16, 4($2)
    # Load the word from memory at address in $2 + 4 (which holds the address of the second value)
    # into register $16.
    lw $16, 4($2)
    
    # sw $16, 0($2)
    # Store the value in $16 (the second value) at the address in $2 (the first value's address).
    sw $16, 0($2)
    
    # sw $15, 4($2)
    # Store the value in $15 (the first value) at the address in $2 + 4 (the second value's address).
    sw $15, 4($2)
    
    # jr $31
    # Return from the function by jumping to the address stored in $31 (the return address).
    jr $31
