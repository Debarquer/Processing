public class MultiBox extends Shape{
  public Box center;
  public Box inLeft, inRight, inTop, inBot;
  public Box onLeft, onRight, onTop, onBot;

  PVector a;
  PVector v;
  PVector vMax;

  boolean isJumping;

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

    a = new PVector(18, 9);
    v = new PVector(0, 0);
    vMax = new PVector (5, 5);

    isJumping = false;
  }

  public void update(float dt){
    super.update(dt);

    //v.y += a.y / 60;
    if(v.y > vMax.y){
      v.y = vMax.y;
    }
    else if(v.y < -vMax.y){
      v.y = -vMax.y;
    }

    if(v.x > 0.1){
      v.x -= a.x/1.4/60;
    }
    else if(v.x < -0.1){
      v.x += a.x/1.4/60;
    }
    else{
      v.x = 0;
    }

    if(moveRight){
        v.x += a.x / 60;
        if(v.x > vMax.x){
          v.x = vMax.x;
        }
    }
    if(moveLeft){
      v.x -= a.x / 60;
      if(v.x < -vMax.x){
        v.x = -vMax.x;
      }
    }

    //print(v.y + "\n");
    if(v.y == 0){
      if(jump){
        //print("Jumping! " + v.y + "\n");
        v.y = -40;
      }
    }

    v.y += a.y / 60;

    pos.y += v.y / 1;
    pos.x += v.x / 1;

    if(pos.y > height - center.size.y/2){
      pos.y = height - center.size.y/2;
      v.y = 0;
    }

    rectMode(CENTER);
    rect(pos.x, pos.y, center.size.x, center.size.y);
  }

  public boolean inGround(Box other){
    return inBot.intersectsBox(other);
  }

  public boolean onGround(Box other){
    return onBot.intersectsBox(other);
  }

  public float maxX(){
    return pos.x + center.size.x * 0.5;
  }

  public float maxY(){
    return pos.y + center.size.y * 0.5;
  }

  public float minX(){
    return pos.x - center.size.x * 0.5;
  }

  public float minY(){
    return pos.y - center.size.y * 0.5;
  }
}
