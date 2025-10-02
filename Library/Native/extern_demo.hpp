#ifndef EXTERN_DEMO_HPP
#define EXTERN_DEMO_HPP

class demo_two_ints {
public:
    int a;
    int b;

    demo_two_ints(int a = 0, int b = 0) : a(a), b(b) {}
    void log_values() const;
};

int demo_sum_of_two_ints(const demo_two_ints* pair);
int demo_sum_of_int_list(const int* list, int size);
int demo_squared(int x);

#endif // EXTERN_DEMO_HPP

