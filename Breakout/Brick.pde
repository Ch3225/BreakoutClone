// 定义砖块
int brickWidth = 60;
int brickHeight = 20;

void drawBrick(float x, float y) {
  fill(255);
  rect(x, y, brickWidth, brickHeight);
}

void checkBallBrickCollision() {
  for (int i = 0; i < brickRows; i++) {
    for (int j = 0; j < brickCols; j++) {
      if (bricks[i][j]) {
        float brickX = j * brickWidth;
        float brickY = i * brickHeight;
        
        // 球心与砖块边缘的距离
        float closestX = constrain(ballX, brickX, brickX + brickWidth);
        float closestY = constrain(ballY, brickY, brickY + brickHeight);
        
        // 计算距离
        float distanceX = ballX - closestX;
        float distanceY = ballY - closestY;
        float distance = sqrt(distanceX * distanceX + distanceY * distanceY);
        
        // 碰撞检测
        if (distance < ballRadius) {
          // 碰撞发生
          bricks[i][j] = false;
          
          // 判断碰撞类型
          boolean isHorizontal = ballX >= brickX && ballX <= brickX + brickWidth;
          boolean isVertical = ballY >= brickY && ballY <= brickY + brickHeight;

          if (isHorizontal) {
            // 上下边碰撞
            if (ballY > brickY + brickHeight / 2) {
              // 从下方撞击砖块，反弹向下
              ballSpeedY = abs(ballSpeedY);
            } else {
              // 从上方撞击砖块，反弹向上
              ballSpeedY = -abs(ballSpeedY);
            }
          } else if (isVertical) {
            // 左右边碰撞
            if (ballX > brickX + brickWidth / 2) {
              // 从右侧撞击砖块，反弹向右
              ballSpeedX = abs(ballSpeedX);
            } else {
              // 从左侧撞击砖块，反弹向左
              ballSpeedX = -abs(ballSpeedX);
            }
          } else {
            // 斜侧面碰撞，计算反弹角度
            float angle = atan2(distanceY, distanceX);
            ballSpeedX = 5 * cos(angle);
            ballSpeedY = 5 * sin(angle);
          }
          return; // 立即退出循环，防止多次碰撞检测
        }
      }
    }
  }
}