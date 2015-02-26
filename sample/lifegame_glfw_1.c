
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <GLFW/glfw3.h>

#include <processwarp.h>

static const int W = 32;
static const int H = 32;
static const float CELL_SIZE = 10;

GLFWwindow* window;

char obverse[W][H];
char reverse[W][H];

int noise_x;
int noise_y;
int noise_xx;
int noise_yy;

void shuffle() {
  for (int w = 0; w < W; w ++) {
    for (int h = 0; h < H; h ++) {
      if ((rand() % 2) == 0) {
	obverse[w][h] = (char)1;
      } else {
	obverse[w][h] = 0;
      }
    }
  }
}

void update() {
  for (int w = 0; w < W; w ++) {
    for (int h = 0; h < H; h ++) {
      
      char next_count = 0;
      for (int ww = -1; ww <= 1; ww ++)
	for (int hh = -1; hh <= 1; hh ++)
	  next_count += reverse[(w + ww + W) % W][(h + hh + H) % H];
      next_count -= reverse[w][h];
      
      if (next_count == 3) {
	obverse[w][h] = 1;
      } else if (next_count == 2) {
	obverse[w][h] = reverse[w][h];
      } else {
	obverse[w][h] = 0;
      }
    }
  }
}

void noise() {
  noise_xx =+ (rand() % 7) - 3;
  noise_yy =+ (rand() % 7) - 3;
  noise_x = (noise_x + noise_xx + W) % W;
  noise_y = (noise_y + noise_yy + H) % H;
  
  obverse[noise_x][noise_y] = 1;
}

void draw() {
  glClear(GL_COLOR_BUFFER_BIT);
  for (int w = 0; w < W; w ++) {
    for (int h = 0; h < H; h ++) {
      if (w == noise_x && h == noise_y) {
	glColor3f(199.0 / 255, 62.0 / 255, 58.0 / 255);
	glBegin(GL_QUADS);
	glVertex2f(((float)w / W - 0.5) * 2, ((float)h / H - 0.5) * 2);
	glVertex2f((((float)w + 1.0) / W - 0.5) * 2, ((float)h / H - 0.5) * 2);
	glVertex2f((((float)w + 1.0) / W - 0.5) * 2, (((float)h + 1.0) / H - 0.5) * 2);
	glVertex2f(((float)w / W - 0.5) * 2, (((float)h + 1.0) / H - 0.5) * 2);
	glEnd();

      } else if (obverse[w][h]) {
	glColor3f(0.0 / 255, 137.0 / 255, 108.0 / 255);
	glBegin(GL_QUADS);
	glVertex2f(((float)w / W - 0.5) * 2, ((float)h / H - 0.5) * 2);
	glVertex2f((((float)w + 1.0) / W - 0.5) * 2, ((float)h / H - 0.5) * 2);
	glVertex2f((((float)w + 1.0) / W - 0.5) * 2, (((float)h + 1.0) / H - 0.5) * 2);
	glVertex2f(((float)w / W - 0.5) * 2, (((float)h + 1.0) / H - 0.5) * 2);
	glEnd();
      }
    }
  }
}

void init() {
  printf("begin init\n");
  srand((unsigned)time(NULL));

  glfwInit();
  window = glfwCreateWindow(W * CELL_SIZE, H * CELL_SIZE, "life game", NULL, NULL);
  glfwMakeContextCurrent(window);
  glfwSwapInterval(1);
  printf("end init\n");
}

void quit() {
  printf("begin quit\n");
  glfwDestroyWindow(window);
  glfwTerminate();
  printf("end quit\n");
}

int main(int argc, char* argv[]) {
  set_processwarp_param(PW_KEY_WARP_TIMING, PW_VAL_ON_POLLING); // ★
  at_befor_warp(quit); // ★
  at_after_warp(init); // ★

  init();
  shuffle();

  while (!glfwWindowShouldClose(window)) {
    memcpy(reverse, obverse, sizeof(obverse));

    update();
    noise();
    draw();
    
    glfwSwapBuffers(window);
    glfwPollEvents();
    poll_warp_request(); // ★
  }

  quit();

  return EXIT_SUCCESS;
}
