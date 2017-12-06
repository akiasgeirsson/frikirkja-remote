class Comb {

  char name;
  String nam;
  int id;
  boolean active = false;
  int x, y;
  int w, h;

  String[] combination;
  String filename;



  Comb(int id_in, char name_in, int row_in, int column_in) {

    name = name_in;
    id = id_in;

    combination = new String[63];


    int marginTop = 480;
    int spacingX = 90;
    int spacingY = 70;
    int marginLeft = 210+(30*row_in);

    w = 50;
    h = 50;

    x = marginLeft;

    x += column_in * spacingX;
    y = marginTop - h;
    y += row_in * spacingY;


    nam = str(name);
    nam = nam.toUpperCase();

    filename = "presets/combination-" + nam + ".txt";

    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    //textSize(8);
  }

  void display() {
    strokeWeight(1);
    stroke(0);
    if (activeCombination == id) {
      fill(gray);
    } else {
      fill(dark);
    }
    rect(x, y, w, h);

    textSize(24);
    fill(light);
    text(nam, x, y);
  }


  void click(int mX, int mY) {
    if (mX>x-w/2 && mX<x+w/2 && mY>y-h/2 && mY<y+h/2) {
      activeCombination = id;
      load();
      for (int i=0; i<40; i++) {
        buttons[i].display();
      }
    }
  }

  void press(char key_in) {
    if (key_in == name) {
      activeCombination = id;
      load();
      for (int i=0; i<40; i++) {
        buttons[i].display();
      }
    }
  }

  void save() {
    String[] empty = { };
    combination = empty;
    for (int i=1; i<63; i++) {
      combination = append(combination, stops[i].get());
    }
    saveStrings(filename, combination);
  }

  void load() {
    String[] lines = loadStrings(filename);
    for (int i = 0; i < lines.length; i++) {
      int onoff;
      if (lines[i].equals("1")) { 
        onoff = 1;
      } else {
        onoff = 0;
      }
      stops[i].activate(onoff);
    }
  }
}