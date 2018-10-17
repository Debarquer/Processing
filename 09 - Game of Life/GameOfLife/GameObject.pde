//TODO: Fix oscillators

class GameObject{
  float _x, _y;
  boolean _isAlive = false;
  boolean _dying = false;
  boolean _resurrecting = false;

  int _nrOfNeighbours;
  PVector[] _neighbours;

  public GameObject (float x, float y){
    _x = x;
    _y = y;
  }

  public void setNeighbours(ArrayList<PVector> neighbourNumbers){
    if(_x == 30 && _y == 30)
      print("Setting neighbours from position " + _x/10 + ", " + _y/10 + "\n");
    _neighbours = new PVector[neighbourNumbers.size()];
    for(int i = 0; i < _neighbours.length; i++){
      float xPos = neighbourNumbers.get(i).x;
      float yPos = neighbourNumbers.get(i).y;

      if(_x == 30 && _y == 30)
        print("Neighbour " + i + " at " + xPos + ", " + yPos + "\n");

      _neighbours[i] = new PVector(xPos, yPos);
    }
  }

  public void draw(){
      rect(_x*cellSize + drawOffsetX, _y*cellSize+ drawOffsetY, cellSize, cellSize);
  }

  public boolean update(){
    boolean isStable = true;

    float nrOfAliveNeighbours = 0;

    for(int i = 0; i < _neighbours.length; i++){
      int x = (int)_neighbours[i].x;
      int y = (int)_neighbours[i].y;

      if(cells[x][y]._isAlive){
        nrOfAliveNeighbours++;
      }
    }

    if(_isAlive){
      if(nrOfAliveNeighbours > 3){
        _dying = true;
        isStable = false;
      }
      // Remove this for mazes
      else if(nrOfAliveNeighbours < 2){
        _dying = true;
        isStable = false;
      }
      else{
        isStable = true;
      }
    }
    else{
      if(nrOfAliveNeighbours == 3){
        _resurrecting = true;
        isStable = false;
      }
      else{
        isStable = true;
      }
    }

    return isStable;
  }

  public void die(){
    _dying = false;
    _resurrecting = false;
    
    _isAlive = false;
  }

  public void resurrect(){
    _dying = false;
    _resurrecting = false;

    _isAlive = true;
  }
}
