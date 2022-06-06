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
  
  JSONObject getJsonObject() {
    JSONObject json = new JSONObject();
    json.setString("name", this.getName());
    json.setInt("score", this.getScore());
    return json;
  }
  
  void draw(int x, int y) {
     textSize(23);
      
     fill(255, 255, 255);
     stroke(255,255,255);
     line(x + textWidth(this.getName()) + 10, y + 14, width - textWidth(str(this.getScore())) - 15, y + 14);
     
     text(this.getName(), x + 5, y+20);
     text(this.getScore(), width - textWidth(str(this.getScore())) - 10, y+20);
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
