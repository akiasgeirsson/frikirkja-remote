class Keyboard {
  String name;
  int id = 0;
  int x, y;
  int w, h;
  int value;
  int oldVal;
  int newVal;
  boolean selected;

  Keyboard(int nr) {
    id = nr;
    w = 300;
    h = 25;
    rectMode(CENTER);
    value = 0;

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
      strokeWeight(4);
      rect(x, y, w, h);
    } else { 
      noStroke();
      rect(x, y, w+4, h+4);
    }


    fill(22);
    noStroke();
    float size = value/127.0*w;
    rect(x, y, size, h);


    fill(244);
    textSize(11);
    text(name, x, y);
    strokeWeight(1);
  }

  //FIX
  void click(int mX, int mY) {
    if (mX>x-w/2 && mX<x+w/2 && mY>y-h/2 && mY<y+h/2) {
      value++;
    }
  }
}