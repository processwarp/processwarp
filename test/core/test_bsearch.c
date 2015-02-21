#include <stdlib.h>
#include <stdio.h>

int cmp(const void* key, const void* member) {
  return *(int*)key - *(int*)member;
}

void printResult(int* needle, int* haystack, unsigned int len) {
  void* result = bsearch(needle, haystack, len, sizeof(unsigned int), cmp);

  if (result == NULL) {
    printf("null\n");
  } else {
    printf("%d\n", *(unsigned int*)result);
  }
}

int main() {
  int a[] = {-2, -1, 0, 6, 7, 9};
  int val = -2;
  printResult(&val, a, 6);
  return 0;
}
