
#include <stdio.h>
#include <string.h>

struct RT {
  char A;
  int B[10][20];
  char C;
};
struct ST {
  int X;
  double Y;
  struct RT* Z;
};

int *foo(struct ST *s, int n) {
  return &s[1].Z->B[n][13];
}

int main(int argc, char* argv[]) {
  struct ST st[3];
  struct RT rt[3];
  memset(st, argc, sizeof(st));
  memset(rt, argc - 1, sizeof(rt));
  st[0].Z = &rt[0];
  st[1].Z = &rt[1];
  st[2].Z = &rt[2];
  return printf("%d\n", *foo(st + 1, argc));
}
