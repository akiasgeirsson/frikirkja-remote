class Keyboard {
  String name;
  int id = 0;
  int x, y;
  int w, h;
  int value;
  int oldVal;
  int newVal;
  boolean selected;
  boolean noteOn = false;
  //int blink = 180;

  Keyboard(int nr) {
    id = nr;
    w = 330;
    h = 25;
    rectMode(CENTER);
    value = 64;

    if (nr == 0) {
      name = "Pedal";
      x = (width/2);
      y = 350;
    }

    if (nr == 1) {
      name = "Manual I";
      x = (width/2);
      y = 250;
    }

    if (nr == 2) {
      name = "Manual II";
      x = (width/2);
      y = 200;
    }
    if (nr == 7) {
      name = "Manual III";
      x = (width/2);
      y = 150;
    }
  }

  void display() {

    fill(180);
    stroke(0);
    if (id == midiChannelForNoteEvents) {
      fill(light);
    } else { 
      fill(dark);
    }
    rect(x, y, w, h);

    // midi note on activity
    if (noteOn) {
      fill(dark);
      noStroke();
      float noteX = map(value, 0, 127, x-(w/2), x+(w/2));
      ellipse(noteX, y, h, h);
    }

    fill(gray);
    textSize(11);
    text(name, x, y);
    strokeWeight(1);
  }

  //FIX
  void click(int mX, int mY) {
    if (mX>x-w/2 && mX<x+w/2 && mY>y-h/2 && mY<y+h/2) {
      midiChannelForNoteEvents = id;
      bass.display();
      man1.display();
      man2.display();
      man3.display();
    }
  }
}