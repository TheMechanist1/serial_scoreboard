import processing.serial.*;
import java.util.*;
import controlP5.*;

ControlP5 cp5;
Serial port;

List<ScoreEntry> leaderboard = new ArrayList<>();

PFont font;
Textfield t;

File selected;

int currentScore;



void setup() {
    size(500, displayHeight);
  
    // List all the available serial ports
    printArray(Serial.list());
  
    // Open the port you are using at the rate you want:
    port = new Serial(this, Serial.list()[0], 14500000);
    
    cp5 = new ControlP5(this);
    font = createFont("arial", 20);
       
    textFont(font);
    
    selectInput("Select File", "loadFileToArray");
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
         entry.draw(0, i*30);
         i++;
      }
    }
}

void addToLeaderboard(String name, int currentScore) {
    ScoreEntry entry = new ScoreEntry(name, currentScore);
    leaderboard.add(entry); 
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    addToLeaderboard(theEvent.getStringValue(), currentScore);
    t.remove();
    
    
    Collections.sort(leaderboard);
    Collections.reverse(leaderboard);
    putArrayToFile();
    println(leaderboard + " ");
  }
}

void loadFileToArray(File selection) {
  selected = selection;
  if(selection.length() > 0) {
    JSONArray values = loadJSONArray(selected);
  
    for (int i = 0; i < values.size(); i++) {
      
      JSONObject entry = values.getJSONObject(i); 
  
      String name = entry.getString("name");
      int score = entry.getInt("score");
      addToLeaderboard(name, score);
      println(name + ", " + score);
    }
  }
}

void putArrayToFile() {
  try {
  PrintWriter writer = new PrintWriter(selected);
  writer.print("");
  writer.close();
  } 
  catch(Exception FileNotFoundException) {
    println("How did you even manage to do that");
  }

  
  JSONArray values = new JSONArray();
  int i = 0;
  for (ScoreEntry entry: leaderboard) {

    JSONObject JSONEntry = new JSONObject();

    JSONEntry.setString("name", entry.getName());
    JSONEntry.setInt("score", entry.getScore());

    values.setJSONObject(i, JSONEntry);
    i++;
  }

  saveJSONArray(values, selected.getAbsolutePath());
}