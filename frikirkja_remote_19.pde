//Frikirkja MIDI Remote Console
//Program to manage remote organ console with MIDI keyboard
//Aki Asgeirsson
//May 2019


// 


// todo



/*

 ath CPU monitor
 
 note events on display. fix.
 combinations, display preset info
 
 add crescendo1 data,  excel skjal
 
 fix panicButton display
 
 
 panik f raddir
 pank f notur
 
 ___
 
 
 sjálfstætt ctl nr fyrir swell og cresc, takki
 
 bæta inn cresc 1
 
 breytilegt splitt: H,c,c#,d,es,e,f,f#,g
 
 
 */





int test = 0;
import themidibus.*; 

MidiBus myBus; 

int midiChannelForNoteEvents = 0;
int functionForControlPedal = 2;
int activeCombination = 4;

Stop[] stops;
ControlPedal cres, cres2, schwell1, schwell2;
Keyboard bass, man1, man2, man3;
Comb[] buttons;

Save saveButton;
boolean saveToCombination = false;

Panic panicButton;

Split splitButton;
boolean splitOn = false;
int splitNote = 52;  

color pink = color(255, 111, 200);
color white = color(255, 244, 244);
color blue =  color(111, 177, 244);
color green =  color(222, 233, 128);

color dark = color(50);
color gray = color(125);
color light = color(200);

color bg = color(88);

color midiColor;


int info1 = 0;
int info2 = 0;

DeviceInput midiIn;
DeviceOutput midiOut;

void setup() {
  size(1280, 800);
  background(bg);
  frameRate(20);

  //MidiBus.list(); 
  // user choose input 
  //MidiBus.availableInputs().length

  midiColor = dark;

  // myBus = new MidiBus(this, "USB MIDI Interface", "USB MIDI Interface"); 
  myBus = new MidiBus(this); 

  MidiBus.list();

  midiIn = new DeviceInput(myBus.availableInputs());
  midiOut = new DeviceOutput(myBus.availableOutputs());

  schwell1 = new ControlPedal(1);
  schwell2 = new ControlPedal(2);
  cres = new ControlPedal(3);
  cres2 = new ControlPedal(4);


  bass = new Keyboard(7);
  man1 = new Keyboard(0);
  man2 = new Keyboard(1);
  man3 = new Keyboard(2);

  saveButton = new Save();
  panicButton = new Panic();
  splitButton = new Split();

  // Stop(String name_in, String foot_in, String upperColor_in, String lowerColor_in, int midiChan, int midinr_in, String leftRight_in, int row_in, int column_in) 
  stops = new Stop[63];
  stops[0] = new Stop("ekkert", "8'", "pink", "pink", 13, 22, "left", -1, 0);

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

  buttons = new Comb[40];
  buttons[0] = new Comb(1, '1', 0, 0);
  buttons[1] = new Comb(2, '2', 0, 1);
  buttons[2] = new Comb(3, '3', 0, 2);
  buttons[3] = new Comb(4, '4', 0, 3);
  buttons[4] = new Comb(5, '5', 0, 4);
  buttons[5] = new Comb(6, '6', 0, 5);
  buttons[6] = new Comb(7, '7', 0, 6);
  buttons[7] = new Comb(8, '8', 0, 7);
  buttons[8] = new Comb(9, '9', 0, 8);
  buttons[9] = new Comb(10, '0', 0, 9);

  buttons[10] = new Comb(11, 'q', 1, 0);
  buttons[11] = new Comb(12, 'w', 1, 1);
  buttons[12] = new Comb(13, 'e', 1, 2);
  buttons[13] = new Comb(14, 'r', 1, 3);
  buttons[14] = new Comb(15, 't', 1, 4);
  buttons[15] = new Comb(16, 'y', 1, 5);
  buttons[16] = new Comb(17, 'u', 1, 6);
  buttons[17] = new Comb(18, 'i', 1, 7);
  buttons[18] = new Comb(19, 'o', 1, 8);
  buttons[19] = new Comb(20, 'p', 1, 9);

  buttons[20] = new Comb(21, 'a', 2, 0);
  buttons[21] = new Comb(22, 's', 2, 1);
  buttons[22] = new Comb(23, 'd', 2, 2);
  buttons[23] = new Comb(24, 'f', 2, 3);
  buttons[24] = new Comb(25, 'g', 2, 4);
  buttons[25] = new Comb(26, 'h', 2, 5);
  buttons[26] = new Comb(27, 'j', 2, 6);
  buttons[27] = new Comb(28, 'k', 2, 7);
  buttons[28] = new Comb(29, 'l', 2, 8);
  buttons[29] = new Comb(30, 'æ', 2, 9);

  buttons[30] = new Comb(31, 'z', 3, 0);
  buttons[31] = new Comb(32, 'x', 3, 1);
  buttons[32] = new Comb(33, 'c', 3, 2);
  buttons[33] = new Comb(34, 'v', 3, 3);
  buttons[34] = new Comb(35, 'b', 3, 4);
  buttons[35] = new Comb(36, 'n', 3, 5);
  buttons[36] = new Comb(37, 'm', 3, 6);
  buttons[37] = new Comb(38, ',', 3, 7);
  buttons[38] = new Comb(39, '.', 3, 8);
  buttons[39] = new Comb(40, 'þ', 3, 9);


  schwell1.display();
  schwell2.display();
  cres.display();
  cres2.display();


  bass.display();
  man1.display();
  man2.display();
  man3.display();

  for (int i=1; i<63; i++) {
    stops[i].display();
  }

  for (int i=0; i<40; i++) {
    buttons[i].display();
  }

  saveButton.display();
  panicButton.display();
  splitButton.display();

  midiIn.display();
  midiOut.display();

  fill(0);
  textSize(22);
  textAlign(LEFT);
  text("Fríkirkja Remote MIDI Control, v0.19", 50, height-55);
  textAlign(RIGHT);
  text("Áki Ásgeirsson, 2019", width-50, height-55);
  textAlign(CENTER, CENTER);
  
  panicButton.allStopsOff();
  
}



void draw() {
  schwell1.fade();
  cres.fade();
  cres2.fade();
  schwell2.fade();
  // saveButton.fade();
  //bass.fade();
  //man1.fade();
  //man2.fade();
  //man3.fade();

  panicButton.display();

  stroke(midiColor);
  noFill();
  rect(100, 550, 150, 20);
}



void sendProgramChange(int channel, int number ) {
  myBus.sendMessage(0xC0, channel, number, 0);
}


void controllerChange(ControlChange change) {

  // Receive a controllerChange

  //if (change.number() == 64) {
  //  //panic
  //  panicButton.allNotesOff();
  //} else {
  if (functionForControlPedal == 1) schwell1.change(change.value());
  if (functionForControlPedal == 2) schwell2.change(change.value());
  if (functionForControlPedal == 3) cres.change(change.value());
  if (functionForControlPedal == 4) cres2.change(change.value());
  info1 = change.value();
  //}
}



void noteOn(Note note) {
  // Receive a noteOn


  // isolate channel
  //if (note.channel() == 0) {
  //  myBus.sendNoteOn(0, note.pitch(), note.velocity());
  //  myBus.sendNoteOn(1, note.pitch(), note.velocity());
  //}

  myBus.sendNoteOn(midiChannelForNoteEvents, note.pitch(), note.velocity());
  if (splitOn && note.pitch() <= splitNote) myBus.sendNoteOn(7, note.pitch(), note.velocity());


  // noteBlink(midiChannelForNoteEvents);
  //if (midiChannelForNoteEvents == 0) man1.noteOn(note.pitch());
  //if (midiChannelForNoteEvents == 1) man2.noteOn(note.pitch());
  //if (midiChannelForNoteEvents == 2) man3.noteOn(note.pitch());
  //if (midiChannelForNoteEvents == 7) bass.noteOn(note.pitch());
  midiColor = green;
}

void noteOff(Note note) {
  // Receive a noteOff
  myBus.sendNoteOff(midiChannelForNoteEvents, note.pitch(), note.velocity());
  if (splitOn && note.pitch() <= splitNote) myBus.sendNoteOff(7, note.pitch(), note.velocity());
  midiColor = dark;
}


void mousePressed() {

  //buttons[1].save();

  for (int i=1; i<63; i++) {
    stops[i].click(mouseX, mouseY);
  }

  schwell1.click(mouseX, mouseY);
  schwell2.click(mouseX, mouseY);
  cres.click(mouseX, mouseY);
  cres2.click(mouseX, mouseY);
  //bass.click(mouseX, mouseY);
  //man1.click(mouseX, mouseY);
  //man2.click(mouseX, mouseY);
  //man3.click(mouseX, mouseY);

  for (int i=0; i<40; i++) {
    buttons[i].click(mouseX, mouseY);
  }

  saveButton.click(mouseX, mouseY);
  panicButton.click(mouseX, mouseY);
  splitButton.click(mouseX, mouseY);
  midiIn.click(mouseX, mouseY);
  midiOut.click(mouseX, mouseY);
}


void keyPressed() {

  for (int i=0; i<40; i++) {
    buttons[i].press(key);
  }

  if (key == ' ') {
    panicButton.allNotesOff();
    panicButton.allStopsOff();
  }
  

  //arrow keys control pedal function and midi note out channel
  if (key == CODED) {

    if (keyCode == BACKSPACE) {
      panicButton.allNotesOff();
    }
      
    if (keyCode == LEFT) {
      functionForControlPedal--;
      if (functionForControlPedal==0) functionForControlPedal = 4;
      schwell1.display();
      cres.display();
      cres2.display();
      schwell2.display();
    }
    if (keyCode == RIGHT) {
      functionForControlPedal++;
      if (functionForControlPedal==5) functionForControlPedal = 1;
      schwell1.display();
      cres.display();
      cres2.display();
      schwell2.display();
    }
    if (keyCode == UP) {
      midiChannelForNoteEvents++;
      if (midiChannelForNoteEvents==8) midiChannelForNoteEvents = 0;
      if (midiChannelForNoteEvents==3) midiChannelForNoteEvents = 7;
      bass.display();
      man1.display();
      man2.display();
      man3.display();
      panicButton.allNotesOff();
    }
    if (keyCode == DOWN) {
      midiChannelForNoteEvents--;
      if (midiChannelForNoteEvents==6) midiChannelForNoteEvents = 2;
      if (midiChannelForNoteEvents==-1) midiChannelForNoteEvents = 7;
      bass.display();
      man1.display();
      man2.display();
      man3.display();
      panicButton.allNotesOff();
    }
  }
  // combinations, memory presets
}




void del(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}
