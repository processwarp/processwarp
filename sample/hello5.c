
#include <stdio.h>

struct AB {
  int a;
  union {
    int b_i;
    long b_l;
  } b;
} ab;

int main() {
  ab.a = 0;
  ab.b.b_l = 1;

  return printf("hello %d %d\n", ab.a, ab.b.b_i);
}
