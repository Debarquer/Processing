public class Circle extends Shape{
  public float r;

  public Circle(float x, float y, float d){
    super(x, y);

    this.r = d * 0.5;
  }

  public void update(float dt){
    super.update(dt);
    ellipse(pos.x, pos.y, r * 2, r * 2);
  }

  public boolean intersectsCircle(Circle other){
    return dist(pos.x, pos.y, other.pos.x, other.pos.y) < r + other.r;
  }

  public boolean intersectsMultiBox(MultiBox other){
    if(!(
      other.minX() > pos.x+r ||
      other.maxX() < pos.x-r ||
      other.maxY() < pos.y-r ||
      other.minY() > pos.y+r
    )){
      enabled = false;
      return true;
    }
    else{
      return false;
    }
  }
}
