class Save {
  String name, nam;
  int x, y;
  int w, h;
  boolean active = false;
  int fadeCount = 0;

  Save() {
    name = "Save";
    x = 80;
    y = 450;
    w = 50;
    h = 50;
    rectMode(CENTER);
  }

  void display() {

    if (active) {
      fill(light);
      nam = "Select";
    } else { 
      fill(dark);
      nam = name;
    }
    rect(x, y, w, h);

    fill(gray);
    textSize(11);
    text(nam, x, y);
    strokeWeight(1);
  }


  void click(int mX, int mY) {
    if (mX>x-w/2 && mX<x+w/2 && mY>y-h/2 && mY<y+h/2 && active==false) {
      // clicked
      active = true;
      saveToCombination = true;
      //fadeCount = 0;
      //buttons[activeCombination-1].save();
      display();
    }
  }



  void deactivate() {
    active = false;
    display();
  }
}
