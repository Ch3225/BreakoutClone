// 定义砖块
int brickWidth = 60;
int brickHeight = 20;

void drawBrick(float x, float y) {
  fill(255);
  rect(x, y, brickWidth, brickHeight);
}

void checkBallBrickCollision() {
  int brickX = int(ballX / brickWidth);
  int brickY = int(ballY / brickHeight);
  if (brickX >= 0 && brickX < brickCols && brickY >= 0 && brickY < brickRows && bricks[brickY][brickX]) {
    bricks[brickY][brickX] = false;
    ballSpeedY *= -1;
  }
}
