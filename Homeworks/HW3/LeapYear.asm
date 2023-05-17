# Find out if a given year is leap

.text
.globl main
main:
    # Calculate the 50th Fibonacci number
    li $t0, 50   # Number 50
    li $t1, 0    # Previous Fibonacci number F(n-1)
    li $t2, 1    # Current Fibonacci number F(n)
    li $t3, 2    # Loop counter

    fibonacci_loop:
        beq $t3, $t0, fibonacci_done   # Check if loop counter equals 50

        # Calculate the next Fibonacci number
        addu $t4, $t1, $t2   # F(n) = F(n-1) + F(n)
        move $t1, $t2        # Update F(n-1) to F(n)
        move $t2, $t4        # Update F(n) to the new Fibonacci number

        addiu $t3, $t3, 1    # Increment the loop counter
        j fibonacci_loop

    fibonacci_done:
        # Print the result
        move $a0, $t2   # Move the Fibonacci number to $a0
        li $v0, 1       # System call code for printing an integer
        syscall

        # Exit program
        li $v0, 10
        syscall
