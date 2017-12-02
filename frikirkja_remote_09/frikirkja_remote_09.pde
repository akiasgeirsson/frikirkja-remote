//Frikirkja MIDI Remote Console
//Program to manage remote organ console with MIDI keyboard
//Aki Asgeirsson
//November 2017


//crescendo pedal 
//swell
//note events on display?
//combinations 
//channel assignment for note events
//split keyboard


int test = 0;
import themidibus.*; 

MidiBus myBus; 

int midiChannelForNoteEvents = 1;
int functionForControlPedal = 2;



Stop[] stops;
ControlPedal cres, schwell1, schwell2;
Keyboard bass, man1, man2, man3;

color pink = color(255, 111, 200);
color white = color(255, 244, 244);
color blue =  color(111, 177, 244);
color green =  color(222, 233, 128);



void setup() {
  size(1280, 800);
  background(111);
  frameRate(30);

  MidiBus.list(); 
  myBus = new MidiBus(this, "Bus 1", "IAC Bus 2"); 

  schwell1 = new ControlPedal(1);
  cres = new ControlPedal(2);
  schwell2 = new ControlPedal(3);

  bass = new Keyboard(0);
  man1 = new Keyboard(1);
  man2 = new Keyboard(2);
  man3 = new Keyboard(7);

  // Stop(String name_in, String foot_in, String upperColor_in, String lowerColor_in, int midiChan, int midinr_in, String leftRight_in, int row_in, int column_in) 
  stops = new Stop[63];
  stops[0] = new Stop("ekkert", "8'", "pink", "pink", 13, 22, "left", 0, 0);

  stops[1] = new Stop("Flöt", "8'", "pink", "pink", 2, 1, "left", 1, 0);
  stops[2] = new Stop("Röhr", "8'", "pink", "pink", 2, 3, "left", 1, 1);
  stops[3] = new Stop("Viola", "8'", "pink", "pink", 2, 5, "left", 1, 2);
  stops[4] = new Stop("Bach", "4'", "pink", "pink", 2, 7, "left", 1, 3);
  stops[5] = new Stop("Violin", "4'", "pink", "pink", 2, 9, "left", 1, 4);
  stops[6] = new Stop("Princip", "2'", "pink", "pink", 2, 11, "left", 1, 5);
  stops[7] = new Stop("Picc", "2'", "pink", "pink", 2, 13, "left", 1, 6);
  stops[8] = new Stop("Sesq", "2f", "pink", "pink", 2, 15, "left", 1, 7);
  stops[9] = new Stop("Acuta", "3-4f", "pink", "pink", 2, 17, "left", 1, 8);
  stops[10] = new Stop("Rank", "16'", "pink", "pink", 2, 19, "left", 1, 9);
  stops[11] = new Stop("Krumm", "8'", "pink", "pink", 2, 21, "left", 1, 10);
  stops[12] = new Stop("III/II", " ", "blue", "pink", 2, 23, "left", 1, 11);

  stops[13] = new Stop("Bordun", "16'", "white", "white", 1, 1, "left", 2, 0);
  stops[14] = new Stop("Princi", "8'", "white", "white", 1, 3, "left", 2, 1);
  stops[15] = new Stop("FlHarm", "8'", "white", "white", 1, 5, "left", 2, 2);
  stops[16] = new Stop("VlGamb", "8'", "white", "white", 1, 7, "left", 2, 3);
  stops[17] = new Stop("Dulci", "8'", "white", "white", 1, 9, "left", 2, 4);
  stops[18] = new Stop("Oktav", "4'", "white", "white", 1, 11, "left", 2, 5);
  stops[19] = new Stop("Flöte", "4'", "white", "white", 1, 13, "left", 2, 6);
  stops[20] = new Stop("Oktav", "2'", "white", "white", 1, 15, "left", 2, 7);
  stops[21] = new Stop("Mixt", "4-5f'", "white", "white", 17, 1, "left", 2, 8);
  stops[22] = new Stop("Trp", "8'", "white", "white", 1, 19, "left", 2, 9);
  stops[23] = new Stop("II/I", " ", "pink", "white", 1, 21, "left", 2, 10);
  stops[24] = new Stop("III/I", " ", "blue", "white", 1, 23, "left", 2, 11);

  stops[25] = new Stop("Sub", "I", "white", "white", 1, 25, "left", 3, 2);
  stops[26] = new Stop("Super", "I", "white", "white", 1, 27, "left", 3, 3);
  stops[27] = new Stop("Sub", "II/I", "pink", "white", 1, 29, "left", 3, 4);
  stops[28] = new Stop("Super", "II/I", "pink", "white", 1, 31, "left", 3, 5);
  stops[29] = new Stop("Sub", "III/I", "blue", "white", 1, 33, "left", 3, 6);
  stops[30] = new Stop("Super", "III/I", "blue", "white", 1, 35, "left", 3, 7);
  stops[31] = new Stop("Sub", "III/II", "blue", "pink", 2, 25, "left", 3, 8);
  stops[32] = new Stop("Super", "III/II", "blue", "pink", 2, 27, "left", 3, 9);
  stops[33] = new Stop("Sub", "II", "pink", "pink", 2, 29, "left", 3, 10);
  stops[34] = new Stop("Super", "II", "pink", "pink", 2, 31, "left", 3, 11);

  stops[35] = new Stop("Lieb", "16'", "blue", "blue", 3, 1, "right", 1, 0);
  stops[36] = new Stop("Geige", "8'", "blue", "blue", 3, 3, "right", 1, 1);
  stops[37] = new Stop("Konz", "8'", "blue", "blue", 3, 5, "right", 1, 2);
  stops[38] = new Stop("Quint", "8'", "blue", "blue", 3, 7, "right", 1, 3);
  stops[39] = new Stop("Aeol", "8'", "blue", "blue", 3, 9, "right", 1, 4);
  stops[40] = new Stop("Vox", "8'", "blue", "blue", 3, 11, "right", 1, 5);
  stops[41] = new Stop("Fuga", "4'", "blue", "blue", 3, 13, "right", 1, 6);
  stops[42] = new Stop("Flauto", "4'", "blue", "blue", 3, 15, "right", 1, 7);
  stops[43] = new Stop("Flauti", "2'", "blue", "blue", 3, 17, "right", 1, 8);
  stops[44] = new Stop("Harm", "3f", "blue", "blue", 3, 19, "right", 1, 9);
  stops[45] = new Stop("Oboe", "8'", "blue", "blue", 3, 21, "right", 1, 10);

  stops[46] = new Stop("Contra", "16'", "green", "green", 8, 1, "right", 2, 0);
  stops[47] = new Stop("Subb", "16'", "green", "green", 8, 3, "right", 2, 1);
  stops[48] = new Stop("Echo", "16'", "green", "green", 8, 5, "right", 2, 2);
  stops[49] = new Stop("BFl", "16'", "green", "green", 8, 7, "right", 2, 3);
  stops[50] = new Stop("Cello", "16'", "green", "green", 8, 9, "right", 2, 4);
  stops[51] = new Stop("Flöte", "16'", "green", "green", 8, 11, "right", 2, 5);
  stops[52] = new Stop("Hinter", "16'", "green", "green", 8, 13, "right", 2, 6);
  stops[53] = new Stop("Bsn", "16'", "green", "green", 8, 15, "right", 2, 7);
  stops[54] = new Stop("Pos", "16'", "green", "green", 8, 17, "right", 2, 8);
  stops[55] = new Stop("Zimbel", "16'", "white", "white", 8, 19, "right", 2, 10);

  stops[56] = new Stop(" ", "I/P", "white", "green", 8, 21, "right", 3, 0);
  stops[57] = new Stop(" ", "II/P", "white", "green", 8, 23, "right", 3, 1);
  stops[58] = new Stop(" ", "III/P", "white", "green", 8, 25, "right", 3, 2);
  stops[59] = new Stop("Super", "II/P", "white", "green", 8, 27, "right", 3, 3);
  stops[60] = new Stop("Sub", "III", "blue", "blue", 3, 23, "right", 3, 5);
  stops[61] = new Stop("Super", "III", "blue", "blue", 3, 25, "right", 3, 6);
  stops[62] = new Stop("Trem", "III", "blue", "blue", 3, 27, "right", 3, 8);
}

void draw() {

  schwell1.display();
  cres.display();
  schwell2.display();

  //if (frameCount%30 == 0) 
  schwell1.fade();
  cres.fade();
  schwell2.fade();

  bass.display();
  man1.display();
  man2.display();
  man3.display();

  //println(frameRate);

  for (int i=1; i<63; i++) {
    stops[i].display();
  }


  //int channel = 0;
  //int pitch = 64;
  //int velocity = 127;
  //Note note = new Note(channel, pitch, velocity);

  //myBus.sendNoteOn(note); // Send a Midi noteOn
  //delay(200);
  //myBus.sendNoteOff(note); // Send a Midi nodeOff

  //myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  //delay(200);
  //myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff


  //int number = 0;
  //int value = 90;
  //ControlChange change = new ControlChange(channel, number, velocity);
  //myBus.sendControllerChange(change); // Send a controllerChange
  //delay(2000);
  // myBus.sendControllerChange(channel, number, value);
}

void mousePressed() {
  for (int i=0; i<62; i++) {
    stops[i].click(mouseX, mouseY);
  }

  schwell1.click(mouseX, mouseY);
  schwell2.click(mouseX, mouseY);
  cres.click(mouseX, mouseY);
}

//void mouseDragged() {
//schwell1.click(mouseX, mouseY);
//schwell2.click(mouseX, mouseY);
//cres.click(mouseX, mouseY);
//}


void sendProgramChange(int channel, int number ) {
  int status_byte = 0xC0; 
  int channel_byte = channel; 
  int first_byte = number; 
  int second_byte = 0; 
  myBus.sendMessage(status_byte, channel_byte, first_byte, second_byte);
}


void noteOn(Note note) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+note.channel());
  println("Pitch:"+note.pitch());
  println("Velocity:"+note.velocity());
  myBus.sendNoteOn(midiChannelForNoteEvents, note.pitch(), note.velocity());
}

void noteOff(Note note) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+note.channel());
  println("Pitch:"+note.pitch());
  println("Velocity:"+note.velocity());

  // ath NOTEON velocity 0, vs NOTEOFF
  myBus.sendNoteOff(midiChannelForNoteEvents, note.pitch(), note.velocity());
}

void keyPressed() {

  //arrow keys control pedal function and midi note out channel
  if (key == CODED) {
    if (keyCode == LEFT) {
      functionForControlPedal--;
      if (functionForControlPedal==0) functionForControlPedal = 3;
    }
    if (keyCode == RIGHT) {
      functionForControlPedal++;
      if (functionForControlPedal==4) functionForControlPedal = 1;
    }
    if (keyCode == UP) {
      midiChannelForNoteEvents++;
      if (midiChannelForNoteEvents==8) midiChannelForNoteEvents = 0;
      if (midiChannelForNoteEvents==3) midiChannelForNoteEvents = 7;
    }
    if (keyCode == DOWN) {
      midiChannelForNoteEvents--;
      if (midiChannelForNoteEvents==6) midiChannelForNoteEvents = 2;
      if (midiChannelForNoteEvents==-1) midiChannelForNoteEvents = 7;
    }
  }
  // combinations, memory presets
}


void controllerChange(ControlChange change) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+change.channel());
  println("Number:"+change.number());
  println("Value:"+change.value());

  // to general crescendo
  //if (change.number() == 11) {


  if (functionForControlPedal == 1) {
    //schwell 1
    schwell1.change(change.value());
  }
  if (functionForControlPedal == 2) {
    //crescendo
    cres.change(change.value());
  }
  if (functionForControlPedal == 3) {
    //schwell 2
    schwell2.change(change.value());
  }
}

void del(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}