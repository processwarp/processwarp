#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
 
static void *thread_func(void *vptr_args) {
  int i;
 
  for (i = 0; i < 200; i++) {
    printf("  b\n");
  }
 
  return NULL;
}
 
int main(void) {
  int i;
  pthread_t thread;
 
  if (pthread_create(&thread, NULL, thread_func, NULL) != 0) {
    return EXIT_FAILURE;
  }
 
  for (i = 0; i < 200; i++) {
    printf("a\n");
  }
 
  if (pthread_join(thread, NULL) != 0) {
    return EXIT_FAILURE;
  }
 
  return EXIT_SUCCESS;
}
