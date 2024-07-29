#include <Adafruit_NeoPixel.h>
#include <TimerOne.h>
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(3, 2, NEO_RGB + NEO_KHZ800);
int colors[3];
int timer=0;
void setup() {
  Serial.begin(9600);
  pixels.begin();
  pinMode(3,OUTPUT);
  timer=0;

  Timer1.initialize(500000); // 每秒触发一次
  Timer1.attachInterrupt(bulbs);
}
void bulbs() {
  // 中断执行的代码
  if(colors[0]==colors[1]&&colors[1]==colors[2]){
    if(timer%2==0){
      digitalWrite(3,HIGH);
    }else{
      digitalWrite(3,LOW);
    }
  }else{
    digitalWrite(3,LOW);
  }
  timer++;
}
void loop() {
  if (Serial.available() > 0) {
  String data = Serial.readStringUntil('\n');

    if (sscanf(data.c_str(), "%d,%d,%d", &colors[0], &colors[1], &colors[2]) == 3) {
    // Map colors to RGB values
    for (int i = 0; i < 3; i++) {
      switch (colors[i]) {
        case 0:
          pixels.setPixelColor(i, pixels.Color(255, 0, 0)); // Red
          break;
        case 1:
          pixels.setPixelColor(i, pixels.Color(0, 255, 0)); // Green
          break;
        case 2:
          pixels.setPixelColor(i, pixels.Color(0, 0, 255)); // Blue
          break;
        // Add more cases if you have more colors
      }
    }
    pixels.show(); // Update the LED colors
  }
  delay(20);
}

/*
  pixels.setPixelColor( 0, pixels.Color(0, 0, 255) );
  pixels.setPixelColor( 1, pixels.Color(0, 0, 255) );
  pixels.setPixelColor( 2, pixels.Color(0, 0, 255) );
  pixels.show();
  digitalWrite(3,HIGH);
  delay(1000);

  pixels.setPixelColor( 0, pixels.Color(255, 0, 0) );
  pixels.setPixelColor( 1, pixels.Color(255, 0, 0) );
  pixels.setPixelColor( 2, pixels.Color(255, 0, 0) );
  pixels.show();
  digitalWrite(3,LOW);
  delay(1000);
*/
}