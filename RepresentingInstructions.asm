.data
A:    .space 1600       # Reserve space for 400 integers (4 bytes each)
h:    .word 5           # Let h = 5

.text
.globl main
main:
    la $t1, A           # Load base address of array A into $t1
    lw $s2, h           # Load value of h into $s2

    li $t2, 300
    sll $t2, $t2, 2     # Multiply index by 4 to get byte offset (300 * 4)
    add $t2, $t1, $t2   # Address of A[300] in $t2

    lw $t0, 0($t2)      # Load A[300] into $t0
    add $t0, $s2, $t0   # Add h + A[300]
    sw $t0, 0($t2)      # Store result back into A[300]
