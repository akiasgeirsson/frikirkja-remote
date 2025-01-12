class DeviceInput {
  String activeName;
  int nr;
  String[] deviceName;
  String label;

  int x, y;
  int w, h;


  DeviceInput(String[] in) {
    //activeName = "USB MIDI Interface";
    activeName = in[0];
    myBus.addInput(activeName);
    nr = 0;
    deviceName = in;
    label = "MIDI Input";
    x = 100;
    y = 550;
    w = 150;
    h = 20;
    rectMode(CENTER);
  }

  void display() {

    fill(dark);
    rect(x, y, w, h);

    fill(light);
    textSize(11);
    text(label, x, y-22);
    text(activeName, x, y);
    strokeWeight(1);
  }


  void click(int mX, int mY) {
    if (mX>x-w/2 && mX<x+w/2 && mY>y-h/2 && mY<y+h/2) {
      // clicked
      nr++;
      nr = nr % deviceName.length;

      myBus.clearInputs();
      myBus.addInput(nr);
      activeName = deviceName[nr];

      display();
    }
  }
}
