########################################################
# MIPS Program: dot_unrolled4 demo (int arrays, 32-bit)
# C equivalent:
# int dot_unrolled4(int *A, int *B, int N) {
#     int sum = 0, i = 0;
#     for (; i + 3 < N; i += 4) {
#         sum += A[i]   * B[i];
#         sum += A[i+1] * B[i+1];
#         sum += A[i+2] * B[i+2];
#         sum += A[i+3] * B[i+3];
#     }
#     for (; i < N; ++i) {
#         sum += A[i] * B[i];
#     }
#     return sum;
# }
########################################################

.data
A:        .word 1, 2, 3, 4, 5, 6, 7, 8
B:        .word 8, 7, 6, 5, 4, 3, 2, 1
N:        .word 8

msg:      .asciiz "dot_unrolled4 result = "
nl:       .asciiz "\n"

.text
.globl main

########################################################
# int dot_unrolled4(int* A, int* B, int N)
# Args:
#   $a0 = &A[0]
#   $a1 = &B[0]
#   $a2 = N
# Return:
#   $v0 = sum
########################################################
dot_unrolled4:
    # Prologue (no callee-saved regs used; leaf function)
    move    $t0, $a0        # pA
    move    $t1, $a1        # pB
    move    $t2, $a2        # N
    move    $v0, $zero      # sum = 0

    # chunks = N / 4 ; tail = N % 4
    srl     $t6, $t2, 2     # t6 = chunks
    andi    $t7, $t2, 3     # t7 = tail

# ---- main unrolled loop over 4 elements per iter ----
du4_loop4:
    beq     $t6, $zero, du4_tail

    # sum += A[0] * B[0]
    lw      $t3, 0($t0)
    lw      $t4, 0($t1)
    mul     $t5, $t3, $t4
    addu    $v0, $v0, $t5

    # sum += A[1] * B[1]
    lw      $t3, 4($t0)
    lw      $t4, 4($t1)
    mul     $t5, $t3, $t4
    addu    $v0, $v0, $t5

    # sum += A[2] * B[2]
    lw      $t3, 8($t0)
    lw      $t4, 8($t1)
    mul     $t5, $t3, $t4
    addu    $v0, $v0, $t5

    # sum += A[3] * B[3]
    lw      $t3, 12($t0)
    lw      $t4, 12($t1)
    mul     $t5, $t3, $t4
    addu    $v0, $v0, $t5

    addiu   $t0, $t0, 16    # pA += 4
    addiu   $t1, $t1, 16    # pB += 4
    addiu   $t6, $t6, -1    # chunks--
    b       du4_loop4

# ---- tail loop for remaining (N % 4) elements ----
du4_tail:
    beq     $t7, $zero, du4_done
du4_tail_loop:
    lw      $t3, 0($t0)
    lw      $t4, 0($t1)
    mul     $t5, $t3, $t4
    addu    $v0, $v0, $t5
    addiu   $t0, $t0, 4
    addiu   $t1, $t1, 4
    addiu   $t7, $t7, -1
    bgtz    $t7, du4_tail_loop

du4_done:
    jr      $ra

########################################################
# main: build arrays, call dot_unrolled4, print result
########################################################
main:
    # Call: dot_unrolled4(A, B, N)
    la      $a0, A
    la      $a1, B
    lw      $a2, N
    jal     dot_unrolled4
    move    $s0, $v0        # save result

    # print "dot_unrolled4 result = "
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
