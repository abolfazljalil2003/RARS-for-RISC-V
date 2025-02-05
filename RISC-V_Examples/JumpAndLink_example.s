    .data
msg:    .asciz "Hello, World!"  # Message to be printed

    .text
    .globl _start

_start:
    jal x1, print_hello   # Jump to print_hello function and save the return address in x1

    # Further code can be added here

    # Exit the program
    li a7, 10             # System call to exit the program
    ecall                 # Make the system call

print_hello:
    # Function to print "Hello, World!"
    li a7, 4              # Load system call for print (4 corresponds to print)
    la a0, msg            # Load address of "Hello, World!" into a0
    ecall                 # Make the system call

    jalr x0, 0(x1)        # Return to the address stored in x1 (the return address from _start)
