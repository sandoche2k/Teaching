#include <stdio.h>

/* --------------------------------------------------------
   dot_unrolled4
   Computes: sum = Σ A[i]*B[i], unrolled by 4
-------------------------------------------------------- */
int dot_unrolled4(int *A, int *B, int N)
{
    int sum = 0;
    int i = 0;

    /* process 4 elements per iteration */
    for (; i + 3 < N; i += 4) {
        sum += A[i]   * B[i];
        sum += A[i+1] * B[i+1];
        sum += A[i+2] * B[i+2];
        sum += A[i+3] * B[i+3];
    }

    /* handle the tail (N % 4 elements) */
    for (; i < N; ++i) {
        sum += A[i] * B[i];
    }

    return sum;
}

/* --------------------------------------------------------
   main: builds test arrays, calls dot_unrolled4, prints result
-------------------------------------------------------- */
int main(void)
{
    int A[] = {1,2,3,4,5,6,7,8};
    int B[] = {8,7,6,5,4,3,2,1};
    int N = sizeof(A)/sizeof(A[0]);

    int result = dot_unrolled4(A, B, N);

    printf("dot_unrolled4 result = %d\n", result);  /* expected: 120 */
    return 0;
}
