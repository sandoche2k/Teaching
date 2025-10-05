#include <stdio.h>
#include <stdint.h>

#define N 256

// ---------------------------
// 1) Plain dot product (baseline)
// ---------------------------
int dot_ref(const int *a, const int *b, int n) {
    int acc = 0;
    for (int i = 0; i < n; i++) {
        acc += a[i] * b[i];
    }
    return acc;
}

// ---------------------------
// 2) 4-way unrolled dot product (optimized)
//    - Fewer branches per element
//    - More ILP (independent accumulators)
// ---------------------------
int dot_unrolled4(const int *a, const int *b, int n) {
    int acc0 = 0, acc1 = 0, acc2 = 0, acc3 = 0;
    int i = 0;

    // Core unrolled loop
    for (; i + 3 < n; i += 4) {
        acc0 += a[i]     * b[i];
        acc1 += a[i + 1] * b[i + 1];
        acc2 += a[i + 2] * b[i + 2];
        acc3 += a[i + 3] * b[i + 3];
    }

    // Clean up remaining elements
    for (; i < n; i++) {
        acc0 += a[i] * b[i];
    }

    return acc0 + acc1 + acc2 + acc3;
}

// ---------------------------
// 3) Branching sum above threshold (baseline)
// ---------------------------
int sum_gt_branchy(const int *x, int n, int t) {
    int s = 0;
    for (int i = 0; i < n; i++) {
        if (x[i] > t) {
            s += x[i];
        }
    }
    return s;
}

// ---------------------------
// 4) Branchless sum above threshold (optimized)
//    Uses two's-complement mask: (x>t) ? -1 : 0
//    mask = -((int)(x[i] > t));
//    s += x[i] & mask;   // add x[i] when mask=-1, add 0 when mask=0
// ---------------------------
int sum_gt_branchless(const int *x, int n, int t) {
    int s = 0;
    for (int i = 0; i < n; i++) {
        int mask = - (x[i] > t);   // 0 or -1
        s += x[i] & mask;
    }
    return s;
}

int main(void) {
    static int A[N], B[N], X[N];
    for (int i = 0; i < N; i++) {
        A[i] = (i % 11) - 5;           // small integers, including negatives
        B[i] = (i * 7 + 3) % 9 - 4;
        X[i] = (i * 5 - 17) % 13;      // threshold dataset
    }

    int d0 = dot_ref(A, B, N);
    int d1 = dot_unrolled4(A, B, N);

    int t  = 2;
    int s0 = sum_gt_branchy(X, N, t);
    int s1 = sum_gt_branchless(X, N, t);

    printf("dot_ref       = %d\n", d0);
    printf("dot_unrolled4 = %d\n", d1);
    printf("sum_branchy   = %d\n", s0);
    printf("sum_branchless= %d\n", s1);

    return 0;
}
