
#include <stdio.h>

void hello() {
  printf("hello world.\n");
}

int hello_name(const char* name) {
  return printf("hello world %s.\n", name);
}

int hello_num(int times) {
  int i = 0;
  for (i = 0; i < times; i ++) {
    printf("hello.(%d)\n", i);
  }
  return i;
}

int main(int argc, char* argv[]) {
  hello();
  int num = hello_name("joker");
  return hello_num(num / 3);
}
