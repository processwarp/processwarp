#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

typedef struct {
  char a;
  char b;
} struct1;

typedef struct {
  int a;
  short b;
  int c;
  double d;
} struct2;

void vaarg(char unused, ...) {
  va_list vl;
  va_start(vl, unused);
  printf("1 : %d\n", va_arg(vl, short));
  printf("2 : %c\n", va_arg(vl, int));
  printf("3 : %f\n", va_arg(vl, double));
  printf("4 : %d\n", va_arg(vl, char));
  printf("5 : %d\n", va_arg(vl, struct1).a);
  printf("6 : %d\n", va_arg(vl, struct2).b);
  printf("7 : %d\n", *va_arg(vl, short*));
  va_end(vl);
}

int main(int argc, char* argv[]) {
  struct1 st1;
  st1.a = 1;
  st1.b = 2;
  struct2 st2;
  st2.a = 10;
  st2.b = 20;
  vaarg(0, 1, 'b', (float)3.1, 4, st1, st2, &st2.b);
  return 0;
}
