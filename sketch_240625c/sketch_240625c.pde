
void setup() {
  size(1280, 720, P3D);
  perspective();
}

void draw() {
  background(255, 255, 255, 0);
  camera(1000, -1000, 1000, 0, 0, 0, 0, 1, 0);
  //box(500, 500, 500);
  box(1000, 200, 200);
}
