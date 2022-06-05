public class ScoreEntry implements Comparable<ScoreEntry> {
  private String name;
  private Integer score;
  
  ScoreEntry(String name, Integer score) {
    this.name = name;
    this.score = score;
  }
  
  String getName() {
    return this.name; 
  }
  
  Integer getScore() {
    return this.score; 
  }
  
  void setName(String name) {
    this.name = name;
  }
  
  void setScore(Integer score) {
    this.score = score;
  }
  
  void draw(int x, int y) {
     textSize(16);
     String stringOut = this.getName() + "---" + this.getScore();
     float w = textWidth(stringOut) + 2;
     
     fill(255, 255, 255);
     rect(x, y, w, 20);
     fill(0, 0, 0);
     
     text(stringOut, x+1, y+16);
  }
  
  @Override
  public int compareTo(ScoreEntry entry) {
    return (int)(this.getScore() - entry.getScore());
  }
    
  @Override
  public String toString() {
    return "[" + this.getName() + ", " + this.getScore() + "]";
  }
}
