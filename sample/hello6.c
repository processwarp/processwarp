
#include <stdio.h>

int g = 1;

int main() {
  int l = 2;
  g += l;
  return printf("hello %d\n", g);
}
