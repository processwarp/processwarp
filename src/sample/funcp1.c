
#include <stdlib.h>

void func0() {
  puts("func0");
}

int func1(int p1) {
  if (p1) puts("func1");
}

int func2(int *p1) {
  if (*p1) puts("func2");
}

int func3(double p1) {
  if ((int)p1) puts("func3");
}

void (*fp0)() = func0;
int  (*fp1)(int) = func1;
int  (*fp2)(int*) = func2;
int  (*fp3)(double) = func3;

int main(int argc, char* argv[]) {
  if (argc > 0) {
    fp0();
    fp1(argc);
    fp2(&argc);
    fp3(2.0 * argc);
  }

  return 0;
}
