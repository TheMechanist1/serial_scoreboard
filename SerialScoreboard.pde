import processing.serial.*;
import java.util.*;  

Serial myPort;  // The serial port
String text = "";
Map<String, ScoreEntry> scoreMap = new HashMap<>();

void setup() {
    size(500, 500);
  
    // List all the available serial ports
    printArray(Serial.list());
  
    // Open the port you are using at the rate you want:
    myPort = new Serial(this, Serial.list()[0], 14500000);
}

void draw() {
    while (myPort.available() > 0) {
        String inBuffer = myPort.readString();   
        if (inBuffer != null) {
            scoreboardHandler(int(inBuffer.replace("\n", "").replace("\r", "")));
        }
    }
}