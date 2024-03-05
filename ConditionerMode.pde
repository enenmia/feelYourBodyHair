class ConditionerMode extends Mode {
  PApplet parent;
  ArrayList<Hair> hairs;
  boolean isCombing = false;
  PVector lastMousePosition = new PVector(-1, -1);
  int brushSize = 50;
  ConditionerMode(PApplet parent) {
    this.parent = parent;
  }

  @Override
    void setup() {
    hairs = new ArrayList<Hair>();
    for (int i = 0; i < 1000; i++) {
      hairs.add(new Hair(parent.random(parent.width), parent.random(parent.height), parent.random(40, 80), parent.random(TWO_PI)));
    }
  }

  @Override
    void display() {
    parent.background(parent.color(243, 215, 202));
    PVector currentMousePosition = new PVector(parent.mouseX, parent.mouseY);
    PVector mouseDirection = PVector.sub(currentMousePosition, lastMousePosition);
    mouseDirection.normalize();

    boolean isMouseMoving = lastMousePosition.x != parent.mouseX || lastMousePosition.y != parent.mouseY;

    for (Hair hair : hairs) {
      hair.show();
      if (parent.mousePressed && isMouseMoving) {
        hair.comb(parent.mouseX, parent.mouseY, mouseDirection.x, mouseDirection.y, brushSize);
        hair.applyProduct(parent.mouseX, parent.mouseY, brushSize);
      }
    }

    lastMousePosition.set(parent.mouseX, parent.mouseY);
  }


  class Hair {
    float x, y, length, angle;
    ArrayList<PVector> forks;
    boolean hasProductApplied = false;

    Hair(float x, float y, float length, float angle) {
      this.x = x;
      this.y = y;
      this.length = length;
      this.angle = angle;
      this.forks = new ArrayList<PVector>();
      int forkCount = (int) random(2, 5);
      for (int i = 0; i < forkCount; i++) {
        float forkAngle = angle + random(-PI/4, PI/4);
        float forkLength = length * random(0.1, 0.3);
        forks.add(new PVector(forkLength, forkAngle));
      }
    }

    void show() {
      stroke(0);
      pushMatrix();
      translate(x, y);
      rotate(angle);
      line(0, 0, length, 0);
      if (!hasProductApplied) {
        for (PVector fork : forks) {
          rotate(fork.y);
          line(0, 0, fork.x, 0);
          rotate(-fork.y);
        }
      }
      popMatrix();
    }

    void comb(float mx, float my, float dirX, float dirY, int brushSize) {
      float distance = dist(mx, my, x, y);
      if (distance < brushSize) {
        float combAngle = atan2(dirY, dirX);
        angle = lerp(angle, combAngle, 0.1);
      }
    }

    void applyProduct(float mx, float my, int brushSize) {
      float distance = dist(mx, my, x, y);
      if (distance < brushSize) {
        hasProductApplied = true;
      }
    }
  }
}
