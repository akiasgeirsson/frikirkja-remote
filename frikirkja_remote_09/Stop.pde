class Stop {

  String name, foot;
  int midiChan, midiNr;

  boolean active = false;
  int x, y;
  int w, h;

  color upperColor;
  color lowerColor;

  Stop(String name_in, String foot_in, String upperColor_in, String lowerColor_in, int midiChan_in, int midiNr_in, String leftRight_in, int row_in, int column_in) {

    name = name_in;
    foot = foot_in;
    midiChan = midiChan_in-1;
    midiNr = midiNr_in-1;

    int marginLeft = 35;
    int marginRight = 850;
    int marginTop = 111;
    int spacingX = 35;
    int spacingY = 100;

    w = 28;
    h = 70;

    if (leftRight_in.equals("left")) x = marginLeft;
    if (leftRight_in.equals("right")) x = marginRight;

    x += column_in * spacingX;
    y = marginTop - h;
    y += row_in * spacingY;

    if (upperColor_in.equals("pink")) upperColor =  pink;
    if (upperColor_in.equals("white")) upperColor =  white;
    if (upperColor_in.equals("blue")) upperColor =  blue;
    if (upperColor_in.equals("green")) upperColor =  green;

    if (lowerColor_in.equals("pink")) lowerColor =  pink;
    if (lowerColor_in.equals("white")) lowerColor =  white;
    if (lowerColor_in.equals("blue")) lowerColor =  blue;
    if (lowerColor_in.equals("green")) lowerColor =  green;


    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    //textSize(8);
  }

  void display() {
    strokeWeight(1);
    stroke(0);
    fill(0);
    rect(x, y, w+2, h);

    textSize(8);

    int yOffset = -5;
    if (active) yOffset = 5;
    fill(255);
    rect(x, y+yOffset, w, h-10);
    // ellipse(x, y, w, w);
    fill(upperColor);
    arc(x, y+yOffset, w, w, radians(180), radians(360), OPEN);
    fill(lowerColor);
    arc(x, y+yOffset, w, w, radians(0), radians(180), OPEN);
    fill(22);
    text(name, x, y+yOffset-20);
    text(foot, x, y+yOffset+20);
  }

  void sendMidiCtlChange() {
  }

  void click(int mX, int mY) {
    if (mX>x-w/2 && mX<x+w/2 && mY>y-h/2 && mY<y+h/2) {
      if (active) {
        active = false;
        sendProgramChange(midiChan, midiNr+1 );  //  Turn OFF
      } else { 
        active = true;
        sendProgramChange(midiChan, midiNr );  // Turn ON
      }
    }
  }

  void activate(int onoff) {
    if (onoff==1) {
      if (active==false) {
        sendProgramChange(midiChan, midiNr-1 );  // ON
        active = true;
      }
    } else { 
      if (active==true) {
        sendProgramChange(midiChan, midiNr );  //  OFF
        active = false;
      }
    }
  }
}