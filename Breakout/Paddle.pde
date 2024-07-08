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
  if (ballLaunched) {
    if (keyPressed) {
      paddleSpeed = 5 * scaleFactor;
      if (key == 'a' || key == 'A') {
        paddleX -= paddleSpeed;
      } else if (key == 'd' || key == 'D') {
        paddleX += paddleSpeed;
      }
    } else {
      paddleSpeed = 0;
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
    float hitPos = (ballX - paddleX) / (paddleWidth * scaleFactor); // 计算击打位置的相对位置 (0.0到1.0之间)
    float angle = map(hitPos, 0, 1, -PI / 4, PI / 4); // 将击打位置映射到反弹角度
    float ballSpeed = sqrt(ballSpeedX * ballSpeedX + ballSpeedY * ballSpeedY); // 计算球速;
    ballSpeedX = ballSpeed * sin(angle);
    ballSpeedY = -ballSpeed * cos(angle);
  }
}