
#include <stdio.h>

int main() {
  short hello[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
  return printf("%08x\n", *(int*)(hello + 2));
}
