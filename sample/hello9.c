
#include <stdio.h>

char* hello1 = "hello %d\n";
const char* hello2 = "hello %d\n";
static const char* hello3 = "hello %d\n";
char hello4[] = "hello %d\n";
const char hello5[] = "hello %d\n";
static const char hello6[] = "hello %d\n";

int main(int argc, char* argv[]) {
  char* hello7 = "hello %d\n";
  const char* hello8 = "hello %d\n";
  static const char* hello9 = "hello %d\n";
  char hello10[] = "hello %d\n";
  const char hello11[] = "hello %d\n";
  static const char hello12[] = "hello %d\n";

  printf("hello %d\n", 0);
  printf(hello1, 1);
  printf(hello2, 2);
  printf(hello3, 3);
  printf(hello4, 4);
  printf(hello5, 5);
  printf(hello6, 6);
  printf(hello7, 7);
  printf(hello8, 8);
  printf(hello9, 9);
  printf(hello10, 10);
  printf(hello11, 11);
  printf(hello12, 12);

  printf("%p %s", "hello0\n", "hello0\n");
  printf("%p %s", hello1, hello1);
  printf("%p %s", hello2, hello2);
  printf("%p %s", hello3, hello3);
  printf("%p %s", hello4, hello4);
  printf("%p %s", hello5, hello5);
  printf("%p %s", hello6, hello6);
  printf("%p %s", hello7, hello7);
  printf("%p %s", hello8, hello8);
  printf("%p %s", hello9, hello9);
  printf("%p %s", hello10, hello10);
  printf("%p %s", hello11, hello11);
  printf("%p %s", hello12, hello12);

  return 0;
}
