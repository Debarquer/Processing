class Zombie extends Human{

  public Zombie(){
    super();

    col = new PVector(0, 255, 0);
    speed.x /= 2;
    speed.y /= 2;

    isZombie = true;
  }

  public Zombie(PVector pos, PVector size, PVector speed, PVector target){
    super(pos, size, speed, target);
    speed.x /= 2;
    speed.y /= 2;

    col = new PVector(0, 255, 0);

    isZombie = true;
    
    
  }

  public void draw(){
    PVector targetMath = new PVector();
    targetMath.x = target.x;
    targetMath.y = target.y;

    PVector direction = targetMath.sub(pos);

    float armLength = 30;
    float angle = atan2(direction.y, direction.x);

    PVector newDir = new PVector();
    newDir.x = direction.x;
    newDir.y = direction.y;
    newDir.x = cos(angle + 90) * 10;
    newDir.y = sin(angle + 90) * 10;

    //print("Zombie:"+target + ":"+pos+":" + direction + "\n");

    direction.normalize();
    line(pos.x + newDir.x - size.x/2, pos.y + newDir.y - size.y/2, pos.x+direction.x*armLength + newDir.x - size.x/2, pos.y+direction.y*armLength + newDir.y - size.y/2);
    line(pos.x - newDir.x - size.x/2, pos.y - newDir.y - size.y/2, pos.x+direction.x*armLength - newDir.x - size.x/2, pos.y+direction.y*armLength - newDir.y - size.y/2);

    super.draw();
  }
}
