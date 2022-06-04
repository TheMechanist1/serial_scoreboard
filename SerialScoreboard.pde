import processing.serial.*;
import java.util.*;
import controlP5.*;

ControlP5 cp5;
Serial port;

List<ScoreEntry> leaderboard = new ArrayList<>();

PFont font;
Textfield t;

int currentScore;

void setup() {
    size(500, 500);
  
    // List all the available serial ports
    printArray(Serial.list());
  
    // Open the port you are using at the rate you want:
    port = new Serial(this, Serial.list()[0], 14500000);
    
    
    cp5 = new ControlP5(this);
    font = createFont("arial", 20);
       
    textFont(font);
    
    createInput("bruh");
}

void draw() {
  background(0, 0, 0);
    while (port.available() > 0) {
        String inBuffer = port.readString();   
        if (inBuffer != null) {
            currentScore = int(inBuffer.replace("\n", "").replace("\r", ""));
            if(t != null) {t.remove();}
            t = cp5.addTextfield("Your Name")
               .setPosition(width/2 - 100/2, height/2 - 40/2)
               .setSize(100,40)
               .setFont(font)
               .setFocus(true)
               .setColor(color(255,0,0));
        }
    }
    
    if(leaderboard.size() > 0) {
      int i = 0;
      for(ScoreEntry entry: leaderboard) {
         entry.draw(0, i*20);
         i++;
      }
    }
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    String name = theEvent.getStringValue();
    ScoreEntry entry = new ScoreEntry(name, currentScore);
    leaderboard.add(entry);
    t.remove();
    
    
    Collections.sort(leaderboard);
    Collections.reverse(leaderboard);
    println(leaderboard + " ");
  }
}
