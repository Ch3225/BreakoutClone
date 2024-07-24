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
  pushMatrix();
  translate(ballX, ballY, ballRadius * scaleFactor);
  noStroke();
  fill(255);
  sphere(ballRadius * scaleFactor);
  popMatrix();
}

void handleCylinderCollision(int i) {
  float dx = ballX - x[i];
  float dy = ballY - y[i];
  float distance = sqrt(dx * dx + dy * dy);

  if (distance < ballRadius + radius[i]) {
    // Reflect the ball using the tangent direction
    float normalX = dx / distance;
    float normalY = dy / distance;
    float tangentX = -normalY;
    float tangentY = normalX;

    // Calculate dot product
    float dotProduct = ballSpeedX * tangentX + ballSpeedY * tangentY;

    // Reflect ball speed
    ballSpeedX = 2 * dotProduct * tangentX - ballSpeedX;
    ballSpeedY = 2 * dotProduct * tangentY - ballSpeedY;

    // Change the color of the cylinder
    currentColorIndex[i] = (currentColorIndex[i] + 1) % colors[i].length;
    if (currentColorIndex[0] == currentColorIndex[1] && currentColorIndex[1] == currentColorIndex[2]) {
      // Increase score by 10000
      score += 10000;
    }
    writeColor();
  }
}
