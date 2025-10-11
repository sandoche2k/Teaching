########################################################
# MIPS Program: dot_ref demo (int arrays, 32-bit)
########################################################

.data
A:        .word 1, 2, 3, 4, 5, 6, 7, 8
B:        .word 8, 7, 6, 5, 4, 3, 2, 1
N:        .word 8

msg:      .asciiz "dot_ref result = "
nl:       .asciiz "\n"

.text
.globl main

# int dot_ref(int* A, int* B, int N)
dot_ref:
    move    $t0, $a0        # pA
    move    $t1, $a1        # pB
    move    $t2, $a2        # n
    move    $v0, $zero      # sum = 0

dr_loop:
    beq     $t2, $zero, dr_done

    lw      $t3, 0($t0)     # a = *pA
    lw      $t4, 0($t1)     # b = *pB
    mul     $t5, $t3, $t4   # product (pseudo → mult+mflo)
    addu    $v0, $v0, $t5   # sum += product

    addiu   $t0, $t0, 4
    addiu   $t1, $t1, 4
    addiu   $t2, $t2, -1
    b       dr_loop

dr_done:
    jr      $ra

main:
    la      $a0, A
    la      $a1, B
    lw      $a2, N
    jal     dot_ref
    move    $s0, $v0        # result

    # print "dot_ref result = "
    li      $v0, 4
    la      $a0, msg
    syscall

    # print result
    li      $v0, 1
    move    $a0, $s0
    syscall

    # newline
    li      $v0, 4
    la      $a0, nl
    syscall

    # exit
    li      $v0, 10
    syscall
