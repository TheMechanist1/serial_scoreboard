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
  
  @Override
    public int compareTo(ScoreEntry entry) {
        return (int)(this.score - entry.getScore());
    }
}
