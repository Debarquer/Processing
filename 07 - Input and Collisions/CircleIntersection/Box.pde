public class Box extends Shape{
  public PVector size;
  
  public Box(float x, float y, float w, float h){
    super(x, y);
    
    size = new PVector(w, h);
  }
  
  public void update(float dt){
    super.update(dt);
    rectMode(CENTER);
    rect(pos.x, pos.y, size.x, size.y);
  }
  
  public boolean intersectsBox(Box other){
    return !(
      other.minX() > maxX() ||
      other.maxX() < minX() ||
      other.maxY() < minY() ||
      other.minY() > maxY()
    );
  }
  
  public float maxX(){
    return pos.x + size.x * 0.5;
  }
  
  public float maxY(){
    return pos.y + size.y * 0.5;
  }
  
  public float minX(){
    return pos.x - size.x * 0.5;
  }
  
  public float minY(){
    return pos.y - size.y * 0.5;
  }
}