class CutMode extends Mode {
  PApplet parent;
  Capture video;
  OpenCV opencv;
  ArrayList<Hair> hairs;
  boolean isScraping = false;
  PVector lastHandPosition = new PVector(-1, -1); 

  CutMode(PApplet parent) {
    this.parent = parent;
    video = new Capture(parent, 640, 480);
    opencv = new OpenCV(parent, 640, 480);
    opencv.loadCascade("hand.xml");
    video.start();
  }

  @Override
    void setup() {
    hairs = new ArrayList<Hair>();
    for (int i = 0; i < 1000; i++) {
      hairs.add(new Hair(parent.random(parent.width), parent.random(parent.height), parent.random(10, 20), parent.random(TWO_PI)));
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
        hair.scrape(lastHandPosition.x, lastHandPosition.y);
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
    float x, y, originalX, originalY, length, angle;
    boolean isScraped = false; 
    float fallSpeed = 0; 

    Hair(float x, float y, float length, float angle) {
      this.x = this.originalX = x;
      this.y = this.originalY = y;
      this.length = length;
      this.angle = angle;
    }

    void show() {
      if (!isScraped) {
        stroke(0);
      } else {
        stroke(150, 75, 0); 
      }
      pushMatrix();
      translate(x, y);
      rotate(angle);
      line(0, 0, length, 0);
      popMatrix();

      if (isScraped) {
        fall();
      }
    }

    void scrape(float hx, float hy) {
      float distance = dist(hx, hy, x, y);
      if (distance < 50 && !isScraped) { 
        isScraped = true;
        fallSpeed = random(2, 5); 
      }
    }

    void fall() {
      y += fallSpeed; 
      length = max(length - 0.1, 10); 
    }
  }
}
