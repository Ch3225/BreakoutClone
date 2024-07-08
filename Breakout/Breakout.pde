int brickRows = 5;
int brickCols = 10;
boolean[][] bricks = new boolean[brickRows][brickCols];
boolean ballLaunched = false;
float launchDirection = 0; // 发射方向的角度

void setup() {
  size(600, 400);
  reset();
}

void reset() {
  ballLaunched = false;
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
  // 绘制和更新球
  if (ballLaunched) {
    updateBall();
  }
  drawBall(); // 在未发射时也绘制小球

  // 绘制发射方向箭头
  if (!ballLaunched) {
    drawLaunchArrow();
  }
  
  // 绘制挡板
  updatePaddle();
  drawPaddle();

  // 球和砖块的碰撞检测
  if (ballLaunched) {
    checkBallBrickCollision();
    // 球和挡板的碰撞检测
    checkBallPaddleCollision();
  }
}

void keyPressed() {
  if (!ballLaunched) {
    if (key == 'a' || key == 'A') {
      launchDirection -= PI / 36; // 向左旋转5度
    } else if (key == 'd' || key == 'D') {
      launchDirection += PI / 36; // 向右旋转5度
    } else if (key == 'j' || key == 'J') {
      launchBall();
    }
  }
}

void drawLaunchArrow() {
  stroke(255);
  float arrowLength = 50;
  float arrowX = ballX + arrowLength * cos(launchDirection);
  float arrowY = ballY + arrowLength * sin(launchDirection);
  line(ballX, ballY, arrowX, arrowY);
  // 画箭头的头部
  float arrowHeadSize = 10;
  float arrowHeadAngle = PI / 6;
  line(arrowX, arrowY, arrowX - arrowHeadSize * cos(launchDirection - arrowHeadAngle), arrowY - arrowHeadSize * sin(launchDirection - arrowHeadAngle));
  line(arrowX, arrowY, arrowX - arrowHeadSize * cos(launchDirection + arrowHeadAngle), arrowY - arrowHeadSize * sin(launchDirection + arrowHeadAngle));
}

void launchBall() {
  ballSpeedX = 5 * cos(launchDirection);
  ballSpeedY = 5 * sin(launchDirection);
  ballLaunched = true;
}
