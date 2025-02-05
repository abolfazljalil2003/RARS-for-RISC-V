.data         # declare and initialize variables
num1:   .word  5       # First number
num2:   .word  7       # Second number
result: .word 0       # Variable to store result

.text         # code starts here
main:           # label marking the entry point of the program
  # Load the numbers into registers
  la t0, num1       # Load address of num1 into t0
  lw t1, 0(t0)      # Load the value of num1 into t1
  la t0, num2       # Load address of num2 into t0
  lw t2, 0(t0)      # Load the value of num2 into t2

  # Perform the addition
  add t3, t1, t2    # Add t1 and t2 and store result in t3

  # Store the result into memory
  la t0, result     # Load address of result into t0
  sw t3, 0(t0)      # Store the result in the memory location

  # Exit the program
  addi a7, zero, 10 # System call to exit
  ecall             # Make the system call to exit
