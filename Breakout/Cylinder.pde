float[] x = new float[3];
float[] y = new float[3];
float[] radius = new float[3];
color[][] colors = new color[3][3];
int[] currentColorIndex = new int[3];

void setupCylinders() {
  // Initialize cylinders at desired positions
  float offsetX = width / 2 - 300; // 偏移量使圆柱放置在中间偏上一点
  float offsetY = height * 2 / 3;

  for (int i = 0; i < 3; i++) {
    x[i] = offsetX + 300 * i;
    y[i] = offsetY;
    radius[i] = 80;
    colors[i] = new color[]{color(255, 0, 0), color(0, 255, 0), color(0, 0, 255)};
    currentColorIndex[i] = 0;
  }
}

void drawCylinders() {
  for (int i = 0; i < 3; i++) {
    pushMatrix();
    translate(x[i], y[i], brickHeight / 2); // Adjust Z position to center the cylinder vertically
    fill(colors[i][currentColorIndex[i]]);
    drawCylinder(radius[i], brickHeight);
    popMatrix();
    handleCylinderCollision(i); // Check for collision
  }
}

void drawCylinder(float r, float h) {
  int detail = 30; // number of segments
  float angleStep = 360.0 / detail;

  // 绘制圆柱侧面
  beginShape(QUAD_STRIP);
  for (int i = 0; i <= detail; i++) {
    float angle = radians(i * angleStep);
    float x = r * cos(angle);
    float z = r * sin(angle);
    vertex(x, z, -h / 2);
    vertex(x, z, h / 2);
  }
  endShape();

  // 绘制圆柱顶面
  beginShape(TRIANGLE_FAN);
  vertex(0, 0, -h / 2);
  for (int i = 0; i <= detail; i++) {
    float angle = radians(i * angleStep);
    float x = r * cos(angle);
    float z = r * sin(angle);
    vertex(x, z, -h / 2);
  }
  endShape();

  // 绘制圆柱底面
  beginShape(TRIANGLE_FAN);
  vertex(0, 0, h / 2);
  for (int i = 0; i <= detail; i++) {
    float angle = radians(i * angleStep);
    float x = r * cos(angle);
    float z = r * sin(angle);
    vertex(x, z, h / 2);
  }
  endShape();
}
