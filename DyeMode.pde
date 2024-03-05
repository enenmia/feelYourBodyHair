public class DyeMode extends Mode{
  PApplet parent;
  Capture video;
  ArrayList<Hair> hairs;
  color dyeColor;
  int brushSize = 20; 
  int colorSampleSize = 50; 

  DyeMode(PApplet parent) {
    this.parent = parent;
  }

    @Override
    void setup() {
    video = new Capture(parent, 640, 480);
    video.start();

    hairs = new ArrayList<Hair>();
    dyeColor = parent.color(255, 0, 0); 

    for (int i = 0; i < 1000; i++) {
      hairs.add(new Hair(parent.random(parent.width), parent.random(parent.height), parent.random(40, 80), parent.random(TWO_PI)));
    }
    }

@Override
void display() {
    if (video.available()) {
        video.read();
    }

    parent.background(parent.color(243, 215, 202));
    drawVideoInSampleArea();
    dyeColor = getColorFromVideo();
    for (Hair hair : hairs) {
        hair.show();
    }
    parent.noFill();
    parent.stroke(dyeColor);
    parent.ellipse(parent.mouseX, parent.mouseY, brushSize, brushSize);
}
  @Override
  void mouseDragged() {
    //println("mouseDragged: " + parent.mouseX + ", " + parent.mouseY);
    for (Hair hair : hairs) {
      hair.dye(parent.mouseX, parent.mouseY, dyeColor, brushSize);
    }
    
  }

  void drawVideoInSampleArea() {
    int x = parent.width - colorSampleSize;
    int y = 0;
    PImage videoSample = video.get(x, y, colorSampleSize, colorSampleSize);
    parent.image(videoSample, x, y);
    parent.noFill();
    parent.stroke(255);
    parent.rect(x, y, colorSampleSize, colorSampleSize);
  }

  color getColorFromVideo() {
    int x = parent.width - colorSampleSize;
    int y = 0;
    int sampleArea = colorSampleSize * colorSampleSize;
    int r = 0, g = 0, b = 0;

    video.loadPixels();
    for (int i = x; i < x + colorSampleSize; i++) {
      for (int j = y; j < y + colorSampleSize; j++) {
        int index=j*video.width+i;
        color c = video.pixels[index];
        r += parent.red(c);
        g += parent.green(c);
        b += parent.blue(c);
      }
    }
    r /= sampleArea;
    g /= sampleArea;
    b /= sampleArea;

    return parent.color(r, g, b);
  }

  class Hair {
    float x, y, length, angle;
    color hairColor = color(0); 
    PVector controlPoint; 

    Hair(float x, float y, float length, float angle) {
      this.x = x;
      this.y = y;
      this.length = length;
      this.angle = angle;
      this.controlPoint = new PVector(x + cos(angle) * length/2 + random(-10, 10), y + sin(angle) * length/2 + random(-10, 10));
    }

    void show() {
      parent.stroke(hairColor);
      parent.noFill();
      parent.pushMatrix();
      PVector endPoint = new PVector(x + cos(angle) * length, y + sin(angle) * length);
      parent.bezier(x, y, controlPoint.x, controlPoint.y, controlPoint.x, controlPoint.y, endPoint.x, endPoint.y);
      parent.popMatrix();
    }

    void dye(float mx, float my, color c, int size) {
      float distance = dist(mx, my, x, y);
      //println("dye called: distance = " + distance);
      if (distance < size / 2) { 
        //println("Hair dyed"); 
        hairColor = c; 
        
      }
    }
  }
}
