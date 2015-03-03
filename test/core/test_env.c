
#include <stdio.h>

int main(int argc, char* argv[], char* envp[]) {
  for (int i = 0; i < argc; i ++) {
    printf("arg:%s\n", argv[i]);
  }
  for (int i = 0; envp[i] != NULL; i ++) {
    printf("env:%s\n", envp[i]);
  }
  return 0;
}
