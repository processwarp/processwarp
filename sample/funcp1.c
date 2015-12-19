
#include <stdio.h>

void func0() {
  printf("func0\n");
}

void func1(int p1) {
  if (p1) printf("func1\n");
}

void func2(int *p1) {
  if (*p1) printf("func2\n");
}

void func3(double p1) {
  if ((int)p1) printf("func3\n");
}

void (*fp0)() = func0;
void (*fp1)(int) = func1;
void (*fp2)(int*) = func2;
void (*fp3)(double) = func3;

int main(int argc, char* argv[]) {
  if (argc > 0) {
    fp0();
    fp1(argc);
    fp2(&argc);
    fp3(2.0 * argc);
  }

  return 0;
}
