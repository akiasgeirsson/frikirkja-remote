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
      x = (width/2) - 135;
      y = 80;
      oldVal = 64;
      newVal = 64;
    }

    if (nr == 2) {
      name = "Schwell 2";
      x = (width/2) - 45;
      y = 80;
      oldVal = 64;
      newVal = 64;
    }

    if (nr == 3) {
      name = "Cresc 1";
      x = width/2 + 45;
      y = 80;
      oldVal = 0;
      newVal = 0;
    }

    if (nr == 4) {
      name = "Cresc 2";
      x = width/2 + 135;
      y = 80;
      oldVal = 0;
      newVal = 0;
    }
  }

  void display() {

    fill(180);
    stroke(0);
    if (id == functionForControlPedal) {
      fill(light);
    } else { 
      fill(dark);
    }
    rect(x, y, w, h);


    fill(22);
    noStroke();
    float size = value/127.0*w;
    rect(x, y, size, h);


    fill(244);
    textSize(11);
    text(name, x, y);
    strokeWeight(1);
  }


  void click(int mX, int mY) {
    if (mX>x-w/2 && mX<x+w/2 && mY>y-h/2 && mY<y+h/2) {
      // clicked
      functionForControlPedal = id;
      schwell1.display();
      schwell2.display();
      cres.display();
      cres2.display();
    }
  }

  void change(int val) {
    //println(val);

    if (id == 1) newVal = int(map(val, 0, 127, 64, 123));
    if (id == 2) newVal = int(map(val, 0, 127, 64, 123));
    if (id == 3) newVal = int(map(val, 0, 127, 0, 31));
    if (id == 4) newVal = int(map(val, 0, 127, 0, 31));
  }

  void fade() {

    if (id == 1) {
      if (newVal < oldVal) {
        oldVal--;
        myBus.sendControllerChange(0, 7, oldVal);
      }
      if (newVal > oldVal) {
        oldVal++;
        myBus.sendControllerChange(0, 7, oldVal);
      }

      value = int(map(oldVal, 64, 123, 0, 127));  // for display
      display();
    }

    if (id == 2) {
      if (newVal < oldVal) {
        oldVal--;
        myBus.sendControllerChange(1, 7, oldVal);
      }
      if (newVal > oldVal) {
        oldVal++;
        myBus.sendControllerChange(1, 7, oldVal);
      }
      value = int(map(oldVal, 64, 123, 0, 127));  // for display
      display();
    }


    if (id == 3) {
      if (newVal < oldVal) {
        oldVal--;
        cresc(oldVal);
        //println(" -- " + oldVal + " " );
      }
      if (newVal > oldVal) {
        oldVal++;
        cresc(oldVal);
        //println(" -- " + oldVal + " ");
      }
      value = int(map(oldVal, 0, 31, 0, 127));   // for display
      display();
    }

    if (id == 4) {
      if (newVal < oldVal) {
        oldVal--;
        cresc2(oldVal);
        //println(" -- " + oldVal + " " );
      }
      if (newVal > oldVal) {
        oldVal++;
        cresc2(oldVal);
        //println(" -- " + oldVal + " ");
      }
      value = int(map(oldVal, 0, 31, 0, 127));   // for display
      display();
    }
  }
}
