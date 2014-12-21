
#include <stdio.h>

/*
const char* HELLOS[3] = {
  "hello you!",
  "hello me!",
  "hello all!"
};
/*/
static const char* const HELLOS[] = {
  "hello you!",
  "hello me!",
  "hello all!"
};
//*/

int main() {
  for (int i = 0;; i ++) {
    printf("%s\n", HELLOS[i % 3]);
  }
  return 0;
}
