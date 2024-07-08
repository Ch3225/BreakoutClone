// Brick.pde
int brickWidth = 60;
int brickHeight = 20;
int brickGap = 4;

void drawBrick(float x, float y) {
  pushMatrix();
  translate(x + (brickWidth * scaleFactor) / 2, y + (brickHeight * scaleFactor) / 2, 0);
  fill(255);
  box((brickWidth - 2) * scaleFactor, (brickHeight - 2) * scaleFactor, 10 * scaleFactor); // 添加一个小间隙
  popMatrix();
}

void checkBallBrickCollision() {
  for (int i = 0; i < brickRows; i++) {
    for (int j = 0; j < brickCols; j++) {
      if (bricks[i][j]) {
        float brickX = j * brickWidth * scaleFactor + brickGap / 2 * scaleFactor;
        float brickY = i * brickHeight * scaleFactor + brickGap / 2 * scaleFactor;
        float adjustedBrickWidth = (brickWidth - brickGap) * scaleFactor;
        float adjustedBrickHeight = (brickHeight - brickGap) * scaleFactor;

        // 球心与砖块边缘的距离
        float closestX = constrain(ballX, brickX, brickX + adjustedBrickWidth);
        float closestY = constrain(ballY, brickY, brickY + adjustedBrickHeight);
        
        // 计算距离
        float distanceX = ballX - closestX;
        float distanceY = ballY - closestY;
        float distance = sqrt(distanceX * distanceX + distanceY * distanceY);
        
        // 碰撞检测
        if (distance < ballRadius * scaleFactor) {
          // 碰撞发生
          bricks[i][j] = false;
          
          // 判断碰撞类型
          boolean isHorizontal = ballX >= brickX && ballX <= brickX + adjustedBrickWidth;
          boolean isVertical = ballY >= brickY && ballY <= brickY + adjustedBrickHeight;

          if (isHorizontal) {
            // 上下边碰撞
            if (ballY > brickY + adjustedBrickHeight / 2) {
              // 从下方撞击砖块，反弹向下
              ballSpeedY = abs(ballSpeedY);
            } else {
              // 从上方撞击砖块，反弹向上
              ballSpeedY = -abs(ballSpeedY);
            }
          } else if (isVertical) {
            // 左右边碰撞
            if (ballX > brickX + adjustedBrickWidth / 2) {
              // 从右侧撞击砖块，反弹向右
              ballSpeedX = abs(ballSpeedX);
            } else {
              // 从左侧撞击砖块，反弹向左
              ballSpeedX = -abs(ballSpeedX);
            }
          } else {
            // 斜侧面碰撞，计算反弹角度
            float angle = atan2(distanceY, distanceX);
            float ballSpeed = sqrt(ballSpeedX * ballSpeedX + ballSpeedY * ballSpeedY); // 计算球速;
            ballSpeedX = ballSpeed * cos(angle);
            ballSpeedY = ballSpeed * sin(angle);
          }
          return; // 立即退出循环，防止多次碰撞检测
        }
      }
    }
  }
}