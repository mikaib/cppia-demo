#include "extern_demo.hpp"
#include <cstdio>

int demo_sum_of_two_ints(const demo_two_ints* pair) {
    return pair->a + pair->b;
}

int demo_sum_of_int_list(const int* list, int size) {
    int sum = 0;
    for (int i = 0; i < size; i++) {
        sum += list[i];
    }
    return sum;
}

int demo_squared(int x) {
    return x * x;
}

void demo_two_ints::log_values() const {
    printf("a: %d, b: %d\n", a, b);
}