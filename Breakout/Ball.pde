float ballX, ballY;
float ballSpeedX, ballSpeedY;
float ballRadius = 10;

void initBall() {
  ballX = width / 2;
  ballY = height / 2;
  ballSpeedX = 0;
  ballSpeedY = 0;
}

void updateBall() {
  ballX += ballSpeedX;
  ballY += ballSpeedY;
  if (ballX < ballRadius || ballX > width - ballRadius) {
    ballSpeedX *= -1;
  }
  if (ballY < ballRadius) {
    ballSpeedY *= -1;
  }
  if (ballY - ballRadius > height) {
    reset();
  }
}

void drawBall() {
  ellipse(ballX, ballY, ballRadius * 2, ballRadius * 2);
}
