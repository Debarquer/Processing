class Debris{
  PVector _pos, _size, _direction;

  float _timerMax = 0;
  float _timerCurr = 0;

  boolean enabled;

  public Debris(PVector pos, PVector size, float timerMax, PVector direction){
    _pos = pos;
    _size = size;
    _timerMax = timerMax;
    _timerCurr = 0;
    _direction = direction;
    _direction.normalize();

    enabled = true;
  }

  public void update(){
    _pos.x += _direction.x*5+(float)1/frameRate;
    _pos.y += _direction.y*5+(float)1/frameRate;

    _timerCurr += (float)1/frameRate;
    if(_timerCurr >= _timerMax){
      explode();
    }
  }

  public void draw(){
    fill(255, 0, 0);
    ellipse(_pos.x, _pos.y, _size.x, _size.y);
  }

  public void explode(){
    enabled = false;
  }
}
