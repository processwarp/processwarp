
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
  void* bottom = alloca(4);
  void* top    = alloca(4);
  if (bottom < top) {
    memset(bottom, 1, top - bottom);
  } else {
    memset(top, 1, bottom - top);
  }
  printf("%p %x\n%p %x\n", bottom, *(short*)bottom, top, *(short*)toper);
  return 0;
}
