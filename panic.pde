
class Panic {
  String name, nam;
  int x, y;
  int w, h;
  boolean active = false;
  int fadeCount = 0;
  int blinkCounter = 0;

  Panic() {
    name = "Panic";
    x = width-80;
    y = 450;
    w = 50;
    h = 50;
    rectMode(CENTER);
  }

  void display() {

    if (active) {
      fill(0, 255, 0);
      nam = "*";
    } else { 
      fill(dark);
      nam = name;
    }
    rect(x, y, w, h);
    fill(gray);
    textSize(11);
    text(nam, x, y);
    strokeWeight(1);

    blinkCounter++;
    if (blinkCounter<20) active = false;
  }




  void click(int mX, int mY) {
    if (mX>x-w/2 && mX<x+w/2 && mY>y-h/2 && mY<y+h/2 && active==false) {
      // clicked
      //println("panikk on");

      allNotesOff();
      allStopsOff();


      //println("panikk off");
    }
  }

  void allNotesOff() {

    active = true;
    display();
    blinkCounter = 0;


    // ALL NOTES OFF
    //    0 1 2 7 
    for (int i=0; i<128; i++) {
      myBus.sendNoteOff(0, i, 0);
      del(1);
    }
    for (int i=0; i<128; i++) {
      myBus.sendNoteOff(1, i, 0);
      del(1);
    }
    for (int i=0; i<128; i++) {
      myBus.sendNoteOff(2, i, 0);
      del(1);
    }
    for (int i=0; i<128; i++) {
      myBus.sendNoteOff(7, i, 0);
      del(1);
    }
  }

  void allStopsOff() {
    active = true;
    display();
    blinkCounter = 0;

    for (int i = 1; i < 63; i++) { 
      stops[i].activate(0);
      del(1);  // ath betur
    };
  }
}
