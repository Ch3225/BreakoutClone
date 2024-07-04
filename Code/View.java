public class View {
  Model model;
  
  View(Model model) {
    this.model = model;
  }
  
  void display() {
    background(200);
    ellipse(model.x, model.y, 50, 50);
  }
}
