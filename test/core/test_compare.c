#include <stdio.h>
#include <inttypes.h>

int main(int argc, char* argv[]) {
  printf("%d\n", argc);
  printf("%d %d %d %d %d %d\n",
	 (uint8_t)(0xff) == (int8_t)(argc - 2),
	 (uint8_t)(0xff) == (uint8_t)(argc - 2),
	 (uint8_t)(0xff) > (int8_t)(argc - 2),
	 (uint8_t)(0xff) < (int8_t)(argc - 2),
	 (uint8_t)(0xf) > (int8_t)(argc - 2),
	 (uint8_t)(0xf) < (int8_t)(argc - 2));

  printf("%d %d %d %d %d %d\n",
	 (uint64_t)(0xffffffffffffffff) == (int64_t)(argc - 2),
	 (uint64_t)(0xffffffffffffffff) == (uint64_t)(argc - 2),
	 (uint64_t)(0xffffffffffffffff) > (int64_t)(argc - 2),
	 (uint64_t)(0xffffffffffffffff) < (int64_t)(argc - 2),
	 (uint64_t)(0xffffffffffffff) > (int64_t)(argc - 2),
	 (uint64_t)(0xffffffffffffff) < (int64_t)(argc - 2));
  return 0;
}
