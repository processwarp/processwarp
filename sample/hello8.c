#include <stdio.h>

#pragma pack(1)
struct SPerson {
  char  szName[21];  // 名前
  int   nAge;        // 年齢
  char  nBirthmonth; // 誕生月
  char  fSex;        // 性別
};
#pragma pack()

struct SPerson person = {
  "sample tarou",
  20,
  5,
  'f'
};

int main() {
  printf("SPerson のサイズは %zu バイトです。\n ", sizeof(struct SPerson));
  char* addr = (char*)&person;
  for (size_t i = 0; i < sizeof(struct SPerson); i ++) {
    printf(" %02x", *(addr + i));
  }
  printf("\n");

  return 0;
}
