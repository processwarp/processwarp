#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

pthread_mutex_t mutex;

static void *thread_func(void *vptr_args) {
  int i;
  printf("start b %p\n", pthread_self());

  for (i = 0; i < 1; i++) {
    pthread_mutex_lock(&mutex);
    fputs("  b\n", stderr);
    sleep(1);
  }
 
  return NULL;
}
 
int main(void) {
  int i;
  pthread_t thread;

  printf("start a %p\n", pthread_self());

  if (pthread_mutex_init(&mutex, NULL) != 0) {
    return EXIT_FAILURE;
  }
 
  if (pthread_create(&thread, NULL, thread_func, NULL) != 0) {
    return EXIT_FAILURE;
  }
 
  for (i = 0; i < 5; i++) {
    pthread_mutex_unlock(&mutex);
    pthread_mutex_lock(&mutex);
    puts("a");
    sleep(1);
    pthread_mutex_unlock(&mutex);
  }
 
  if (pthread_join(thread, NULL) != 0) {
    sleep(2);
    return EXIT_FAILURE;
    
  } else {
    sleep(2);
    return EXIT_SUCCESS;
  }
}
