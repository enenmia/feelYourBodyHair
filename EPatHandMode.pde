public class PatHandMode extends Mode {
  PApplet parent;
  Capture video;
  OpenCV opencv;
  PImage backgroundImg;
  ArrayList<Hair> hairs;
  boolean isScraping = false;
  PVector lastHandPosition = new PVector(-1, -1);
  PVector handDirection = new PVector(0, 0);

  PatHandMode(PApplet parent) {
    this.parent = parent;
  }

  @Override
  void setup() {
    //parent.size(640, 480);
    video = new Capture(parent, 640, 480);
    opencv = new OpenCV(parent, 640, 480);
    opencv.loadCascade("hand.xml");
    video.start();
    backgroundImg = createSemiTransparentBackground(640, 480);
    hairs = new ArrayList<Hair>();
    for (int i = 0; i < 1000; i++) {
      hairs.add(new Hair(parent.random(640), parent.random(480), parent.random(30, 60), parent.PI / 2 + parent.random(-parent.PI / 4, parent.PI / 4)));
    }
  }

  @Override
  void display() {
    if (video.available()) {
      video.read();
    }
    parent.image(video, 0, 0);

    opencv.loadImage(video);
    Rectangle[] hands = opencv.detect();
    Rectangle chosenHand = chooseHand(hands);

    if (chosenHand != null) {
      float handX = chosenHand.x + chosenHand.width / 2;
      float handY = chosenHand.y + chosenHand.height / 2;
      handDirection = PVector.sub(new PVector(handX, handY), lastHandPosition);
      handDirection.normalize(); 

      parent.fill(255, 0, 0);
      parent.noStroke();
      parent.ellipse(handX, handY, 10, 10);

      lastHandPosition.set(handX, handY);
      isScraping = true;
    } else {
      lastHandPosition.set(-1, -1);
      isScraping = false;
    }

    for (Hair hair : hairs) {
      hair.show();
      if (isScraping) {
        hair.comb(lastHandPosition.x, lastHandPosition.y, handDirection.x, handDirection.y);
      }
    }
  }

  Rectangle chooseHand(Rectangle[] hands) {
  if (hands.length == 0) return null;
  Rectangle largestHand = hands[0];
  for (Rectangle hand : hands) {
    if (hand.width * hand.height > largestHand.width * largestHand.height) {
      largestHand = hand;
    }
  }
  return largestHand;
}

PImage createSemiTransparentBackground(int w, int h) {
  PGraphics img = createGraphics(w, h);
  img.beginDraw();
  img.background(128, 128, 128, 150); 
  img.endDraw();
  return img;
}

class Hair {
  float x, y, length, angle;
  float stiffness; 

  Hair(float x, float y, float length, float angle) {
    this.x = x;
    this.y = y;
    this.length = length;
    this.angle = angle;
    this.stiffness = random(0.1, 0.3); 
  }

  void show() {
    stroke(0);
    pushMatrix();
    translate(x, y);
    rotate(angle);
    line(0, 0, length, 0);
    popMatrix();
  }

  void comb(float hx, float hy, float dirX, float dirY) {
    float distance = dist(hx, hy, x, y);
    if (distance < 50) { 
      float combAngle = atan2(dirY, dirX);
      angle = lerp(angle, combAngle, stiffness);
    }
  }
}

}
