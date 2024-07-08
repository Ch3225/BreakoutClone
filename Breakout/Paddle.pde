float paddleX;
float paddleWidth = 80;
float paddleHeight = 10;
float paddleSpeed = 5; // 挡板移动速度

void initPaddle() {
  paddleX = width / 2 - paddleWidth / 2;
}

void updatePaddle() {
  if (ballLaunched) {
    if (keyPressed) {
      paddleSpeed=5;
      if (key == 'a' || key == 'A') {
        paddleX -= paddleSpeed;
      } else if (key == 'd' || key == 'D') {
        paddleX += paddleSpeed;
      }
    }else{
      paddleSpeed=0;
    }
  }
  paddleX = constrain(paddleX, 0, width - paddleWidth);
}

void drawPaddle() {
  rect(paddleX, height - paddleHeight, paddleWidth, paddleHeight);
}

void checkBallPaddleCollision() {
  if (ballY + ballRadius > height - paddleHeight && ballX + ballRadius > paddleX && ballX - ballRadius < paddleX + paddleWidth) {
    float hitPos = (ballX - paddleX) / paddleWidth; // 计算击打位置的相对位置 (0.0到1.0之间)
    float angle = map(hitPos, 0, 1, -PI / 4, PI / 4); // 将击打位置映射到反弹角度
    ballSpeedX = 5 * sin(angle);
    ballSpeedY = -5 * cos(angle);
  }
}
