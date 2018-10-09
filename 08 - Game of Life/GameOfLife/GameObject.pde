class GameObject{

  float _x, _y, _size;
  boolean _isAlive = false;
  boolean _dying = false;
  boolean _resurrecting = false;

  float _age = 0;
  float _dyingAnimation = 0;

  int _nrOfNeighbours;
  PVector[] _neighbours;

  public GameObject (float x, float y, float size){
    _x = x;
    _y = y;
    _size = size;
  }

  public void setNeighbours(ArrayList<PVector> neighbourNumbers){
    _neighbours = new PVector[neighbourNumbers.size()];
    for(int i = 0; i < _neighbours.length; i++){
      _neighbours[i] = new PVector(neighbourNumbers.get(i).x, neighbourNumbers.get(i).y);
    }
  }

  public void draw(){
    if(true){
      fill(_age, 0, _age, _dyingAnimation);
      rect(_x, _y, _size, _size);
    }
  }

  public boolean update(){
    if(_isAlive){
      _dyingAnimation = 255;

      _age+=2*15;
      if(_age > 255){
        _age = 255;
      }
    }
    if(!_isAlive){
      _dyingAnimation-=5*15;
    }

    // Check if we should die
    float nrOfAliveNeighbours = 0;

    for(int i = 0; i < _neighbours.length; i++){
      GameObject nCell;
      int x = (int)_neighbours[i].x;
      int y = (int)_neighbours[i].y;
      try{
        nCell = cells[x][y];
      }
      catch(Exception e){
        print(e + " at ["+x+","+y+"]\n");
        return false;
      }

      if(nCell._isAlive){
        nrOfAliveNeighbours++;
      }
    }

    if(nrOfAliveNeighbours > 3){
      //if(_isAlive)
        //print("AliveNeighbours: " + nrOfAliveNeighbours + "\n");
      _dying = true;
      return false;
    }
    else if(nrOfAliveNeighbours == 3){
      //if(!_isAlive)
        //print("AliveNeighbours: " + nrOfAliveNeighbours + "\n");
      _resurrecting = true;
      return false;
    }
    // Rmeove this for mazes
    else if(nrOfAliveNeighbours < 2){
      _dying = true;
      return false;
    }
    else{
      return true;
    }
  }

  public void die(){
    if(_isAlive){
      _age = 0;

    }
    _dying = false;
    _resurrecting = false;

    _isAlive = false;
  }

  public void resurrect(){
    if(!_isAlive){
      _age = 0;
    }

    _dying = false;
    _resurrecting = false;

    _isAlive = true;

  }
}
