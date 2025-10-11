#include <stdio.h>

/* --------------------------------------------------------
   Reference dot product
   Computes: sum = Σ (A[i] * B[i]) for i = 0..N-1
-------------------------------------------------------- */
int dot_ref(int *A, int *B, int N)
{
    int i, sum = 0;

    for (i = 0; i < N; i++) {
        sum += A[i] * B[i];
    }

    return sum;
}

/* --------------------------------------------------------
   Main program to test dot_ref
-------------------------------------------------------- */
int main(void)
{
    int A[] = {1, 2, 3, 4, 5, 6, 7, 8};
    int B[] = {8, 7, 6, 5, 4, 3, 2, 1};
    int N = 8;

    int result = dot_ref(A, B, N);

    printf("dot_ref result = %d\n", result);

    return 0;
}
