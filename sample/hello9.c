
#include <stdio.h>

char* hello1 = "hello1\n";
const char* hello2 = "hello2\n";
static const char* hello3 = "hello3\n";
char hello4[] = "hello4\n";
const char hello5[] = "hello5\n";
static const char hello6[] = "hello6\n";

int main(int argc, char* argv[]) {
  char* hello7 = "hello7\n";
  const char* hello8 = "hello8\n";
  static const char* hello9 = "hello9\n";
  char hello10[] = "hello10\n";
  const char hello11[] = "hello11\n";
  static const char hello12[] = "hello12\n";

  printf("hello0\n");
  printf(hello1);
  printf(hello2);
  printf(hello3);
  printf(hello4);
  printf(hello5);
  printf(hello6);
  printf(hello7);
  printf(hello8);
  printf(hello9);
  printf(hello10);
  printf(hello11);
  printf(hello12);

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
