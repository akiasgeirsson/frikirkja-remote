class ControlPedal {
  String name;
  int id = 0;
  int x, y;
  int w, h;
  int value;
  int oldVal;
  int newVal;
  boolean selected;

  ControlPedal(int nr) {
    id = nr;
    w = 60;
    h = 40;
    rectMode(CENTER);
    value = 0;

    if (nr == 1) {
      name = "Schwell 1";
      x = (width/2) - 100;
      y = 80;
      oldVal = 64;
      newVal = 64;
    }

    if (nr == 2) {
      name = "Crescendo";
      x = width/2;
      y = 80;
      oldVal = 0;
      newVal = 0;
    }

    if (nr == 3) {
      name = "Schwell 2";
      x = (width/2) + 100;
      y = 80;
      oldVal = 64;
      newVal = 64;
    }
  }

  void display() {
    
    fill(180);
    stroke(0);
    if (id == functionForControlPedal) {
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

  void change(int val) {
    //value = val; 
    if (id == 1) newVal = int(map(val, 0, 127, 64, 123));
    if (id == 2) newVal = int(map(val, 0, 127, 0, 31));
    if (id == 3) newVal = int(map(val, 0, 127, 64, 123));
  }

  void fade() {


    if (id == 1) {
      if (newVal < oldVal) {
        oldVal--;
        myBus.sendControllerChange(0, 6, oldVal);
        println("oldVal = " + oldVal);
      }
      if (newVal > oldVal) {
        oldVal++;
        myBus.sendControllerChange(0, 6, oldVal);
        println("oldVal = " + oldVal);
      }
      value = int(map(oldVal, 64, 123, 0, 127));
    }

    if (id == 2) {
      if (newVal < oldVal) {
        oldVal--;
        cresc(oldVal);
      }
      if (newVal > oldVal) {
        oldVal++;
        cresc(oldVal);
      }
      value = int(map(oldVal, 0, 31, 0, 127)); 
    }

    if (id == 3) {
      if (newVal < oldVal) {
        oldVal--;
        myBus.sendControllerChange(1, 6, oldVal);
      }
      if (newVal > oldVal) {
        oldVal++;
        myBus.sendControllerChange(1, 6, oldVal);
      }
      value = int(map(oldVal, 64, 123, 0, 127));
    }
  }
}