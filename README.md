<!DOCTYPE html>
<html>
<head>

</head>
<body>
  <p># frikirkja-remote</p>
  <p>MIDI Control Application for Pipe Organ</p>
  <p></p>

  <p>..to control the organ in Frikirkjan from a remote midi keyboard.  project started in 2019 by Aki Asgeirsson</p>

<p>software</p>
  <ul>
    <li>processing</li>
    <li>themidibus library</li>
  </ul>

  <p>hardware</p>
  <ul>
    <li>frikirkja pipe organ</li>
    <li>midi keyboard, with control pedal or CC fader</li>
    <li>laptop computer</li>
    <li>midi interface and cables</li>
  </ul>

  
  <p>functionality</p>
  <ul>
    <li>stops</li>
    <li>crescendo pedal 1 and 2</li>
    <li>schwellwerk 1 and 2</li>
    <li>notes forwarded to selected keyboard channel</li>
    <li>combinations (saved to computer keybard keyes)</li>
    <li>split keyboard (fixed point)</li>
    <li>midi events, green blink</li>
    <li>select MIDI interface</li>
    <li>panic button</li>
  </ul>
  <p>todo</p>
  <ul>
    <li> note events on display. fix.  </li>
    <li> combinations display info </li>
    <li> fix panicButton display </li>
    <li> fixed control nr for cresc/scwell pedal</li>
    <li> sub-cresc on draw-bar sliders</li>
    <li> knobs for direct control (cresc1, cresc2, schwell1, schwell2)</li>
    <li> sustain pedal (note-off on pedal release)</li>
    <li> variable split point</li>
    <li> measure delay, check del() function</li>
  </ul>
  <p>instructions for use:</p>
  <ul>
    <li>computer keyboard arrow keyes (left/right) switch between swell1/swell2/crescendo.  incoming control messages are directed to the selected effect</li>
    <li>computer keyboard arrow keyes (up/down) switch between organ keyboards/pedalboard (Schwellwerk, Hauptwerk, Rückpositiv, Pedal).  incoming MIDI note-on messages are directed to the selected keyboard/pedalboard</li>
    <li>computer keyboard buttons select voice combination</li>
    <li>press SAVE button to save a combination to a computer keyboard button</li>
    <li>press MIDI-IN or MIDI-OUT buttons to select MIDI device</li>
     <li>press PANIC button (or SPACE BAR) to send NOTE-OFF message to all channels</li>
    <li>press ESC key to quit</li>
  </ul>

  <p>
    todo:
    jan 2025
    
    check midibus compatability with Processing 4  - https://discourse.processing.org/t/does-themidibus-library-work-in-processing-4/31851/6
  </p>

  ![Alt text](Screenshot.png?raw=true "screenshot")
 
</body>
</html>
