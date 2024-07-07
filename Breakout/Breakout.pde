// 定义砖块
int brickRows = 5;
int brickCols = 10;
boolean[][] bricks = new boolean[brickRows][brickCols];

void setup() {
  size(600, 400);
  reset();
}

void reset() {
  // 初始化砖块
  for (int i = 0; i < brickRows; i++) {
    for (int j = 0; j < brickCols; j++) {
      bricks[i][j] = true;
    }
  }

  // 初始化球和挡板
  initBall();
  initPaddle();
}

void draw() {
  background(0);

  // 绘制砖块
  for (int i = 0; i < brickRows; i++) {
    for (int j = 0; j < brickCols; j++) {
      if (bricks[i][j]) {
        drawBrick(j * brickWidth, i * brickHeight);
      }
    }
  }

  // 更新和绘制球
  updateBall();
  drawBall();

  // 绘制挡板
  updatePaddle();
  drawPaddle();

  // 球和砖块的碰撞检测
  checkBallBrickCollision();
  // 球和挡板的碰撞检测
  checkBallPaddleCollision();
}
