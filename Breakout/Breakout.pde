
int brickRows = 5;
int brickCols = 10;
boolean[][] bricks = new boolean[brickRows][brickCols];
boolean ballLaunched = false;
float launchDirection = 0; // 发射方向的角度
float scaleFactor; // 缩放因子
boolean[] keys = new boolean[128]; // 存储按键状态

int score = 0;
int combo = 0;

void setup() {
  size(1800, 1200, P3D); // 使用P3D进行3D渲染
  scaleFactor = height / 400.0; // 计算缩放因子
  lights();
  reset();
  frameRate(60);

  new Thread(new Runnable() {
  public void run() {
    while (true) {
      println("Thread is running...");

      // 物理计算代码...
      try {
        Thread.sleep(15);
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
    }
  }
}).start();
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
  setupCylinders();
  score = 0;
  combo = 0;
}

void draw() {
  background(64);
  // 添加白色光源
  directionalLight(255, 255, 255, 0, 0, -1);
  // 添加从挡板向砖块的光源
  // directionalLight(58, 72, 77, 0, -1, 0);


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
  
  // 绘制球
  drawBall();
  // 绘制挡板
  drawPaddle();
  // 绘制圆柱体
  drawCylinders();

  // 更新球的位置
  if (!ballLaunched) {
    drawLaunchArrow();
  } 
  updateBall();
  updatePaddle();
  checkBallBrickCollision();
  checkBallPaddleCollision();

  // 保存当前的摄像机设置
  pushMatrix();
  camera();

  // 在屏幕上绘制文字
  fill(255);
  textSize(32);
  text("Score: " + score, width - 200, 50);
  text("Combo: " + combo, width - 200, 100);

  // 恢复之前的摄像机设置
  popMatrix();
}

void keyPressed() {
  if(key<128){
    keys[key] = true;
  }
}

void keyReleased() {
  if(key<128){
    keys[key] = false;
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