
#include <stdio.h>
//#include <unistd.h>

int main() {
  for (int i = 1;; i++) {
    printf("hello %d !\n", i);
    //usleep(500);
  }
  return 1;
}
