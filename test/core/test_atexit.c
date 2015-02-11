#include <stdio.h>
#include <stdlib.h>

static void exitA11() {
  printf("A11\n");
}

static void exitA12() {
  printf("A12\n");
}

static void exitA21() {
  printf("A21\n");
}

static void exitA22() {
  printf("A22\n");
}

static void exitB1() {
  exit(1);
  printf("B1\n");
}

static void exitB2() {
  printf("B2\n");
}

static void exitA1() {
  printf("A1\n");
  atexit(exitA11);
  atexit(exitA12);
}

static void exitA2() {
  printf("A2\n");
  atexit(exitA21);
  atexit(exitA22);
}

static void exitB() {
  printf("B\n");
  atexit(exitB1);
  atexit(exitB2);
}

static void exitA() {
  printf("A\n");
  atexit(exitA1);
  atexit(exitA2);
}

int main() {
  atexit(exitA);
  atexit(exitB);
  exit(2);
}
