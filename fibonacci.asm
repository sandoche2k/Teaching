.data
prompt:     .asciiz "Fibonacci Sequence:\n"
newline:    .asciiz "\n"

.text
.globl main

main:
    li $t0, 0          # F(0)
    li $t1, 1          # F(1)
    li $t4, 10         # Number of terms (you can change this)
    
    li $v0, 4
    la $a0, prompt     # Print the prompt
    syscall

    # Print F(0)
    move $a0, $t0
    li $v0, 1
    syscall

    li $v0, 4          # Print newline
    la $a0, newline
    syscall

    # Print F(1)
    move $a0, $t1
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $t2, 2          # Counter starts from 2

loop:
    bge $t2, $t4, exit # Exit when counter reaches n

    add $t3, $t0, $t1  # F(n) = F(n-1) + F(n-2)

    move $t0, $t1      # Update F(n-2)
    move $t1, $t3      # Update F(n-1)

    # Print F(n)
    move $a0, $t3
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    addi $t2, $t2, 1   # Increment counter
    j loop

exit:
    li $v0, 10         # Exit program
    syscall
