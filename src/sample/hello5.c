
#include <stdio.h>

struct {
  int a;
  int b;
} ab;

int main() {
  ab.a = 0;
  ab.b = 1;

  return printf("hello %d %p\n", ab.a, &ab.b);
}
