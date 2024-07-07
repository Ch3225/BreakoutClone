// 定义挡板
float paddleX;
float paddleWidth = 80;
float paddleHeight = 10;

void initPaddle() {
  paddleX = width / 2 - paddleWidth / 2;
}

void updatePaddle() {
  paddleX = constrain(mouseX - paddleWidth / 2, 0, width - paddleWidth);
}

void drawPaddle() {
  rect(paddleX, height - paddleHeight, paddleWidth, paddleHeight);
}

void checkBallPaddleCollision() {
  if (ballY + ballRadius > height - paddleHeight && ballX > paddleX && ballX < paddleX + paddleWidth) {
    ballSpeedY *= -1;
  }
}
