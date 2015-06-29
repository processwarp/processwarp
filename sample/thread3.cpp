#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

pthread_key_t key;

void atexit_a() {
  printf("atexit a\n");
}

void thread_key_death(void*) {
  printf("key death %p\n", pthread_self());
}

static void *thread_b_func(void *vptr_args) {
  int i;
  printf("start b %p\n", pthread_self());
  pthread_setspecific(key, NULL);
  for (i = 0; i < 1; i++) {
    fputs("  b\n", stderr);
    sleep(1);
  }
 
  return NULL;
}

static void *thread_c_func(void *vptr_args) {
  int i;
  printf("start c %p\n", pthread_self());
  pthread_setspecific(key, &key);
  for (i = 0; i < 1; i++) {
    fputs("  b\n", stderr);
    sleep(1);
    exit(1);
  }
 
  return NULL;
}
 
int main(void) {
  int i;
  pthread_t thread;

  printf("start a %p\n", pthread_self());

  atexit(atexit_a);
  
  pthread_key_create(&key, thread_key_death);
  pthread_setspecific(key, &key);
  
  if (pthread_create(&thread, NULL, thread_b_func, NULL) != 0 ||
      pthread_create(&thread, NULL, thread_c_func, NULL) != 0) {
    return EXIT_FAILURE;
  }
 
  for (i = 0; i < 5; i++) {
    puts("a");
    sleep(1);
  }
 
  pthread_exit(NULL);
  printf("pthread_exit a\n");
  
  if (pthread_join(thread, NULL) != 0) {
    sleep(2);
    return EXIT_FAILURE;
    
  } else {
    sleep(2);
    return EXIT_SUCCESS;
  }
}
