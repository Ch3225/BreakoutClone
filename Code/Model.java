public class Model {
  float x, y;
  float speedX, speedY;
  
  Model() {
    x = width / 2;
    y = height / 2;
    speedX = 2;
    speedY = 2;
  }
  
  void update() {
    x += speedX;
    y += speedY;
    
    // 边界检测
    if (x < 0 || x > width) speedX *= -1;
    if (y < 0 || y > height) speedY *= -1;
  }
}
