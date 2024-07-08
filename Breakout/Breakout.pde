int brickRows = 5;
int brickCols = 10;
boolean[][] bricks = new boolean[brickRows][brickCols];
boolean ballLaunched = false;
float launchDirection = 0; // 发射方向的角度
float scaleFactor; // 缩放因子

void setup() {
  size(1800, 1200, P3D); // 使用P3D进行3D渲染
  scaleFactor = height / 400.0; // 计算缩放因子
  lights();
  reset();
}

void reset() {
  ballLaunched = false;
  for (int i = 0; i < brickRows; i++) {
    for (int j = 0; j < brickCols; j++) {
      bricks[i][j] = true;
    }
  }
  initBall();
  initPaddle();
}

void draw() {
  background(64);
  // 添加白色光源
  directionalLight(255, 255, 255, 0, 0, -1);
  // 添加从挡板向砖块的光源
  directionalLight(58, 72, 77, 0, -1, 0);
  
  // 设置摄像机
  camera(width / 2, height / 2 + 1000, (height / 2) / tan(PI / 6) * 1.2, width / 2, height / 2, 0, 0, 1, 0);
  
  // 绘制背景盒
  drawBox();
  // 绘制砖块
  for (int i = 0; i < brickRows; i++) {
    for (int j = 0; j < brickCols; j++) {
      if (bricks[i][j]) {
        drawBrick(j * brickWidth * scaleFactor, i * brickHeight * scaleFactor);
      }
    }
  }
  
  // 绘制和更新球
  if (ballLaunched) {
    updateBall();
  } else {
    drawLaunchArrow();
  }
  drawBall();
  
  // 绘制挡板
  updatePaddle();
  drawPaddle();

  // 检查碰撞
  if (ballLaunched) {
    checkBallBrickCollision();
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
  float arrowLength = 50 * scaleFactor;
  float arrowX = ballX + arrowLength * cos(launchDirection);
  float arrowY = ballY + arrowLength * sin(launchDirection);
  line(ballX, ballY, arrowX, arrowY);
  float arrowHeadSize = 10 * scaleFactor;
  float arrowHeadAngle = PI / 6;
  line(arrowX, arrowY, arrowX - arrowHeadSize * cos(launchDirection - arrowHeadAngle), arrowY - arrowHeadSize * sin(launchDirection - arrowHeadAngle));
  line(arrowX, arrowY, arrowX - arrowHeadSize * cos(launchDirection + arrowHeadAngle), arrowY - arrowHeadSize * sin(launchDirection + arrowHeadAngle));
}

void launchBall() {
  ballSpeedX = 5 * cos(launchDirection) * scaleFactor;
  ballSpeedY = 5 * sin(launchDirection) * scaleFactor;
  ballLaunched = true;
}

void drawBox() {
  stroke(255); // Set the color of the box
  noFill(); // Make the box transparent

  // Draw the bottom
  rect(0, 0, width, height);

  // Draw the sides
  line(0, 0, 0, height);
  line(width, 0, width, height);

  // Draw the top
  line(0, 0, width, 0);
}
