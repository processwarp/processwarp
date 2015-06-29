#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

void exit_a() {
  printf("exit a %p\n", pthread_self());
}

void exit_b() {
  printf("exit b %p\n", pthread_self());
}
 
void exit_bb(void*) {
  printf("exit bb %p\n", pthread_self());
}

void exit_cc(void*) {
  printf("exit cc %p\n", pthread_self());
}

static void *thread_c_func(void*) {
  printf("start c %p\n", pthread_self());
  pthread_cleanup_push(exit_cc, NULL);
  sleep(2);
  pthread_exit(NULL);
  pthread_cleanup_pop(0);
}

static void *thread_func(void *vptr_args) {
  int i;
  printf("start b %p\n", pthread_self());
  atexit(exit_b);
  pthread_cleanup_push(exit_bb, NULL);
  for (i = 0; i < 5; i++) {
    fputs("  b\n", stderr);
    pthread_t thread;
    if (pthread_create(&thread, NULL, thread_c_func, NULL) != 0) {
      exit(EXIT_FAILURE);
    }

    sleep(1);
    exit(0);

    if (pthread_join(thread, NULL) != 0) {
      exit(EXIT_FAILURE);
    }
  }
  pthread_cleanup_pop(0);
 
  return NULL;
}
 
int main(void) {
  int i;
  pthread_t thread;

  printf("start a %p\n", pthread_self());
  atexit(exit_a);
 
  if (pthread_create(&thread, NULL, thread_func, NULL) != 0) {
    return EXIT_FAILURE;
  }
 
  for (i = 0; i < 5; i++) {
    puts("a");
    sleep(1);
  }
 
  if (pthread_join(thread, NULL) != 0) {
    sleep(2);
    return EXIT_FAILURE;
    
  } else {
    sleep(2);
    return EXIT_SUCCESS;
  }
}
