// Paddle.pde

float paddleX;
float paddleWidth = 80;
float paddleHeight = 10;
float paddleSpeed = 5; // 挡板移动速度
float paddleDepth = 10;

void initPaddle() {
  paddleX = width / 2 - (paddleWidth * scaleFactor) / 2;
}

void updatePaddle() {
  if (!ballLaunched) {
    if (keys['a'] || keys['A']) {
      launchDirection -= PI / 36; // 向左旋转5度
    } 
    if (keys['d'] || keys['D']) {
      launchDirection += PI / 36; // 向右旋转5度
    } 
    if (keys['j'] || keys['J']) {
      launchBall();
    }
  }
  if (ballLaunched) {
    if (keys['a'] || keys['A']) {
      paddleX -= paddleSpeed*scaleFactor;
    } 
    if (keys['d'] || keys['D']) {
      paddleX += paddleSpeed*scaleFactor;
    }
  }
  paddleX = constrain(paddleX, 0, width - paddleWidth * scaleFactor);
}

void drawPaddle() {
  pushMatrix();
  translate(paddleX + (paddleWidth * scaleFactor) / 2, height - (paddleHeight * scaleFactor) / 2, 0);
  fill(255);
  box(paddleWidth * scaleFactor, paddleHeight * scaleFactor, paddleDepth * scaleFactor);
  popMatrix();
}

void checkBallPaddleCollision() {
  if (ballY + ballRadius * scaleFactor > height - paddleHeight * scaleFactor && ballX + ballRadius * scaleFactor > paddleX && ballX - ballRadius * scaleFactor < paddleX + paddleWidth * scaleFactor) {
    playSound();
    float hitPos = (ballX - paddleX) / (paddleWidth * scaleFactor); // 计算击打位置的相对位置 (0.0到1.0之间)
    float angle = map(hitPos, 0, 1, -PI / 4, PI / 4); // 将击打位置映射到反弹角度
    float ballSpeed = sqrt(ballSpeedX * ballSpeedX + ballSpeedY * ballSpeedY); // 计算球速;
    ballSpeedX = ballSpeed * sin(angle);
    ballSpeedY = -ballSpeed * cos(angle);
    combo = 0;  // 重置连击次数
  }
}

