
#include <cstdio>

class Hello {
public:
  void hello() {
    printf("hello world!\n");
  }
};

int main(int argc, char* argv[]) {
  Hello hello;

  hello.hello();

  return 0;
}
