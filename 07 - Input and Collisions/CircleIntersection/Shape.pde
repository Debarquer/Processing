public abstract class Shape{
  boolean enabled = true;
  public PVector pos;

  public Shape(float x, float y){
    pos = new PVector(x, y);
  }

  public void update(float dt){
  }
}
