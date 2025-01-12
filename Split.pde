class Split {
  String name;
  int x, y;
  int w, h;
  boolean active = false;


  Split() {
    name = "Split";
    x = width/2;
    y = 300;
    w = 25;
    h = 25;
    rectMode(CENTER);
  }

  void display() {

    if (active) {
      fill(light);
    } else { 
      fill(dark);
    }
    rect(x, y, w, h);

    fill(244);
    textSize(11);
    text(name, x, y);
    strokeWeight(1);
  }


  void click(int mX, int mY) {
    if (mX>x-w/2 && mX<x+w/2 && mY>y-h/2 && mY<y+h/2) {
      // clicked
      if (active) {
        active = false;
      } else {
        active = true;
      }
      splitOn = active;

      display();
    }
  }
}
