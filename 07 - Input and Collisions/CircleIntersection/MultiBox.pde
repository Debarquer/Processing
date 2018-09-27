public class MultiBox extends Shape{
  public Box center;
  public Box inLeft, inRight, inTop, inBot;
  public Box onLeft, onRight, onTop, onBot;
  
  public MultiBox(float x, float y, float w, float h){
    super(x, y);
    
    center = new Box(x, y, w, h);
    
    inLeft = new Box(x - w * 0.5 + 2, y, 2, 10);
    inRight = new Box(x + w * 0.5 - 2, y, 2, 10);
    inTop = new Box(x, y - h * 0.5 + 2, 10, 2);
    inBot = new Box(x, y + h * 0.5 - 2, 10, 2);
    
    onLeft = new Box(x - w * 0.5 - 1, y, 2, 10);
    onRight = new Box(x + w * 0.5 + 1, y, 2, 10);
    onTop = new Box(x, y - h * 0.5 - 1, 10, 2);
    onBot = new Box(x, y + h * 0.5 + 1, 10, 2);
  }
  
  public void update(float dt){
    super.update(dt);
    rectMode(CENTER);
    rect(pos.x, pos.y, center.size.x, center.size.y);
  }
  
  public boolean inGround(Box other){
    return inBot.intersectsBox(other);
  }
  
  public boolean onGround(Box other){
    return onBot.intersectsBox(other);
  }
}