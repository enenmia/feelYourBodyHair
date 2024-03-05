//Before using the tool, user needs to installed 
//the OpenCV library for Processing(Sketch-import library-opencv). 
//Then, move the hand.xml file which is included in the folder, 
//and place it in the Processing libraries directory 
//(…/Processing/libraries/opencv_processing/library/cascade-files/hand.xml).


Button patHandButton, conditionerButton, cutButton, dyeButton;
Mode currentMode = null;
import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;
import java.util.ArrayList;
void setup() {
  size(640, 480);
  patHandButton = new Button("Pat", 50, 100, 200, 50);
  conditionerButton = new Button("Care", 50, 200, 200, 50);
  cutButton = new Button("Trim", 50, 300, 200, 50);
  dyeButton = new Button("Dye", 50, 400, 200, 50);
}

void draw() {
  background(255);
  displayHeader();

  patHandButton.display();
  conditionerButton.display();
  cutButton.display();
  dyeButton.display();

  if (currentMode != null) {
    currentMode.display();
  } else {
    displayModeDescriptions();
  }
}

void displayHeader() {
  fill(0);
  textAlign(CENTER, TOP);

  textSize(24);
  text("Feel your body hair", width / 2, 20);

  textSize(12);
  text("Hair protect us in its way, though we sometimes feel ashamed for its existence. ", width / 2, 50);
  text("Choose a mode to interact with it, and renew your relationship with your body hair.", width / 2, 70);
}

void displayModeDescriptions() {
  fill(0);
  textAlign(LEFT, TOP);
  textSize(12);
  text("Use your hand (or the fist) to pat your hair", 260, 115);
  text("*You may need to wait a few seconds to start the program*", 260, 135);
  text("Press the mouse to care for your hair", 260, 215);
  text("Use your hand (or the fist) to trim your hair", 260, 315);
  text("*You may need to wait a few seconds to start the program*", 260, 335);
  text("hold your favorite color CLOSE to the camera, ", 260, 415);
  text("then use the mouse to dye your hair ", 260, 435);
}



void mousePressed() {
  if (patHandButton.over()) {
    if (!(currentMode instanceof PatHandMode)) {
      currentMode = new PatHandMode(this);
      currentMode.setup();
    }
  } else if (dyeButton.over()) {
    if (!(currentMode instanceof DyeMode)) {
      currentMode = new DyeMode(this);
      currentMode.setup();
    }
  }else if (cutButton.over()) {
    if (!(currentMode instanceof CutMode)) {
      currentMode = new CutMode(this);
      currentMode.setup();
    }
  }else if (conditionerButton.over()) {
    if (!(currentMode instanceof ConditionerMode)) {
      currentMode = new ConditionerMode(this);
      currentMode.setup();
    }
  }
}
    void mouseDragged() {
      if (currentMode instanceof DyeMode) {
        currentMode.mouseDragged();
      }
    }

    class Button {
      String label;
      float x, y, w, h;

      Button(String label, float x, float y, float w, float h) {
        this.label = label;
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
      }

      void display() {
        fill(120);
        rect(x, y, w, h);
        fill(0);
        textAlign(CENTER, CENTER);
        text(label, x + w / 2, y + h / 2);
      }

      boolean over() {
        return mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;
      }
    }
    abstract class Mode {
      abstract void setup();
      abstract void display();
      void mouseDragged() {

      }
    }
