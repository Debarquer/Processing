class Intersection{
  public boolean intersected;
  public PVector pos;

  public Intersection(){
    intersected = false;
    pos = new PVector(0, 0);
  }

  public Intersection(boolean intersected, PVector pos){
    this.intersected = intersected;
    this.pos = pos;
  }
}
