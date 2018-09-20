class Human{
  PVector pos, size, speed, target;

  float humanCol;
  PVector col;

  boolean isEnabled = true;
  boolean isZombie = false;

  float angle;
  float timer;

  public Human(){
    pos = new PVector(random(width), random(height));
    float humanSize = random(18, 22);
    size = new PVector(humanSize, humanSize);
    speed = new PVector(1, 1);
    target = new PVector(random(width), random(height));

    humanCol = random(255);
    col = new PVector(humanCol, humanCol, humanCol);

    angle = 0;
    timer = random(10);
  }

  public Human(PVector pos, PVector size, PVector speed, PVector target){
    this.pos = pos;
    this.size = size;
    this.speed = speed;
    this.target = target;

    humanCol = random(255);
    col = new PVector(humanCol, humanCol, humanCol);
  }

  public void update(){
    PVector targetMath = new PVector();
    targetMath.x = target.x;
    targetMath.y = target.y;

    PVector direction = targetMath.sub(pos);
    direction.normalize();

    //print("Human:"+target+":"+pos+":"+direction+"\n");

    pos.x += direction.x;
    pos.y += direction.y;

    if(abs(pos.x - target.x) < 1 && abs(pos.y - target.y) < 1){
      if(!isZombie){
        angle = random(-90 + angle, 90 + angle);

        float lengthWidth = random(width);
        float lengthHeight = random(height);

        //float myAngle = atan2(pos.y, pos.x);
        //angle += an;

        target.x = cos(radians(angle)) * lengthWidth;
        target.y = sin(radians(angle)) * lengthHeight;

        if(target.x < 0){
          target.x = 0;
        }
        if(target.x > width){
          target.x = width;
        }
        if(target.y < 0){
          target.y = 0;
        }
        if(target.y > height){
          target.y = height;
        }
      }
      else{
        //a zombie
        target = findClosestHuman(pos);
      }
    }

  }

  public void draw(){
    fill(col.x, col.y, col.z);
    ellipse(pos.x - size.x/2, pos.y -size.y/2, size.x, size.y);
  }

boolean roundCollision(float x, float y, float size)
{
  float maxDistance = this.size.x + size;

  //first a quick check to see if we are too far away in x or y direction
  //if we are far away we dont collide so just return false and be done.
  if(abs(this.pos.x - x) > maxDistance || abs(this.pos.y - y) > maxDistance)
  {
    return false;
  }
  //we then run the slower distance calculation
  //dist uses pytagoras to get exact distance, if we still are to far away we are not colliding.
  else if(dist(this.pos.x, this.pos.y, x, y) > maxDistance)
  {
    return false;
  }
  //We now know the points are closer then the distance so we are colliding!
  else
  {
   return true;
  }
}
}
