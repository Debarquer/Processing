class Firework{

  PVector _pos, _size;

  float _timerMax = 0;
  float _timerCurr = 0;

  boolean _enabled;
  boolean _draw;

  ArrayList<Debris> _debris;

  SoundFile _fireworkBoom;

  PImage img;

  public Firework(PVector pos, PVector size, float timerMax){
    _debris = new ArrayList<Debris>();

    _pos = pos;
    _size = size;
    _timerMax = timerMax;
    _timerCurr = 0;

    _enabled = true;
    _draw = true;

    _fireworkBoom = new SoundFile(GameOfLife.this, "fireworkBoom.wav");
    img = loadImage("rocket.png");
  }

  public void update(){
    _timerCurr += (float)1/frameRate;
    if(_timerCurr >= _timerMax){
      explode();
    }

    move();
    updateDebris();
  }

  void move(){
    _pos.y -= 5+(float)1/frameRate;
  }

  void updateDebris(){
    for(Debris debris : _debris){
      debris.update();
      debris.draw();
    }

    cleanupDebrisList();
  }

  void cleanupDebrisList(){
    for(int i = 0; i < _debris.size(); i++){
      if(!_debris.get(i).enabled){
        _debris.remove(i);
      }
      if(_debris.size() == 0){
        _enabled = false;
      }
    }
  }

  public void draw(){
    if(_draw){
      image(img, _pos.x-img.width/2, _pos.y-img.height/2);
    }
  }

  public void explode(){
    if(_draw){
      _fireworkBoom.play();
      for(int i = 0; i < 20; i++){
        float size = random(10, 20);
        _debris.add(new Debris(new PVector(_pos.x, _pos.y), new PVector(size, size), random(0.1, 0.75), new PVector(random(-1, 1), random(-1, 1))));
      }
    }

    _draw = false;
  }
}
