#include <stdio.h>
#include <time.h>

#define N 100

int matrix[N][N];

int main() {
    clock_t start, end;
    long long sum = 0;

    // Row-wise traversal
    start = clock();
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            sum += matrix[i][j];
        }
    }
    end = clock();
    printf("Row-wise Time: %.2f ms\n", 1000.0 * (end - start) / CLOCKS_PER_SEC);

    // Column-wise traversal
    start = clock();
    sum = 0;
    for (int j = 0; j < N; j++) {
        for (int i = 0; i < N; i++) {
            sum += matrix[i][j];
        }
    }
    end = clock();
    printf("Column-wise Time: %.2f ms\n", 1000.0 * (end - start) / CLOCKS_PER_SEC);

    return 0;
}
