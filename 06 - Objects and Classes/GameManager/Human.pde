class Human{
  public CharacterManager characterManager;

  public PVector pos, size, speed, target;

  float humanCol;
  PVector col;

  boolean isEnabled = true;
  boolean isZombie = false;

  float angle;
  float timerCurr;
  float timerMax;
  float timerRangeMax = 5*60;

  public Human(){
    pos = new PVector(random(width), random(height));
    float humanSize = random(18, 22);
    size = new PVector(humanSize, humanSize);
    speed = new PVector(1, 1);
    target = new PVector(random(width), random(height));

    humanCol = random(255);
    col = new PVector(humanCol, humanCol, humanCol);

    angle = 0;
    timerCurr = 0;
    timerMax = random(timerRangeMax);
  }

  public Human(PVector pos, PVector size, PVector speed, PVector target){
    this.pos = pos;
    this.size = size;
    this.speed = speed;
    this.target = target;

    humanCol = random(255);
    col = new PVector(humanCol, humanCol, humanCol);
    
    angle = 0;
    timerCurr = 0;
    timerMax = random(timerRangeMax);
  }

  public void update(){
    PVector direction = new PVector(0, 0);

    if(isZombie){  
    PVector targetMath = new PVector();
    targetMath.x = target.x;
    targetMath.y = target.y;

    direction = targetMath.sub(pos);
    direction.normalize();

    //print("Human:"+target+":"+pos+":"+direction+"\n");
    }
    else{
      direction.x = cos(angle);
      direction.y = sin(angle);
    }
    
    //abs(pos.x - target.x) < 1 && abs(pos.y - target.y) < 1
    if(pos.x > width){
      pos.x = width - 1;
      
      float aX = cos(angle);
      float aY = sin(angle);
      aX *= -1;
      angle = atan2(aY, aX);
    }
    else if(pos.x < size.x){
      pos.x = size.x + 1;
      
      float aX = cos(angle);
      float aY = sin(angle);
      aX *= -1;
      angle = atan2(aY, aX);
    }
    if(pos.y > height){
      pos.y = height - 1;
      
      float aX = cos(angle);
      float aY = sin(angle);
      aY *= -1;
      angle = atan2(aY, aX);
    }
    else if(pos.y < size.y){
      pos.y = size.y + 1;
      
      float aX = cos(angle);
      float aY = sin(angle);
      aY *= -1;
      angle = atan2(aY, aX);
    }

    pos.x += speed.x * direction.x;
    pos.y += speed.y * direction.y;

    if(isZombie){
      //a zombie
      if(characterManager == null){
        print("characterManager is null!\n");
        return;
      }
      
      PVector tmp = characterManager.findClosestHuman(pos);
      if(tmp == null){
        target = new PVector(0, 0);
        print("FindClosestHuman return null!\n");
      }
      else{
        target.x = tmp.x;
        target.y = tmp.y;
      }

      return;
    }
      
    timerCurr++;
    if(timerCurr >= timerMax){
      angle += radians(random(-90, 90));
      timerCurr = 0;
      timerMax = random(timerRangeMax);
      //target = new PVector(random(width), random(height));
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
