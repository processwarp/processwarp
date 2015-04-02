
#include <cstdio>
#include <cstdlib>

#include <emscripten.h>

//#ifndef __EMSCRIPTEN__

static int count = 0;

// main loop for Emscripten
static void ems_loop() {
  if (count ++ < 10) std::printf("loop : %d\n", count);
}

/**
 * Entry point for Emscripten.
 * This function must not return.
 * @return return code
 */
int main() {
  // set main loop for Emscripten
  emscripten_set_main_loop(ems_loop, 0, true);
  
  return EXIT_SUCCESS;
}

//#endif
