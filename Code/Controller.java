public class Controller {
  Model model;
  
  Controller(Model model) {
    this.model = model;
  }
  
  void update() {
    model.update();
  }
  
  void handleKeyPress(char key) {
    if (key == 'w') model.speedY = -2;
    if (key == 's') model.speedY = 2;
    if (key == 'a') model.speedX = -2;
    if (key == 'd') model.speedX = 2;
  }
  
  void handleKeyRelease(char key) {
    if (key == 'w' || key == 's') model.speedY = 0;
    if (key == 'a' || key == 'd') model.speedX = 0;
  }
}