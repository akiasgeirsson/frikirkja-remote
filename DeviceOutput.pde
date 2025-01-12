class DeviceOutput {
  String activeName;
  int nr;
  String[] deviceName;
  String label;

  int x, y;
  int w, h;


  DeviceOutput(String[] out) {
    //activeName = "USB MIDI Interface";
    activeName = out[0];
    myBus.addOutput(activeName);
    nr = 0;
    deviceName = out;
    label = "MIDI Output";
    x = 100;
    y = 600;
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

      myBus.clearOutputs();
      myBus.addOutput(nr);
      activeName = deviceName[nr];
      
      display();
    }
  }
}
