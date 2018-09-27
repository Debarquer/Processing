//http://processingjs.org/learning/custom/intersect/
public class Line extends Shape{
  public PVector dest;

  public Line(float x, float y, float x2, float y2){
    super(x, y);

    dest = new PVector(x2, y2);
  }

  public void update(float dt){
    super.update(dt);
    line(pos.x, pos.y, dest.x, dest.y);
  }

  public Intersection intersectsLine(Line other){
    Intersection intersection = new Intersection();

    //Compute own lines in standard form a, b, c
    float a1 = dest.y - pos.y;
    float b1 = pos.x - dest.x;
    float c1 = (dest.x * pos.y) - (pos.x * dest.y);

    //Compute r3 and r4.
    float r3 = ((a1 * other.pos.x) + (b1 * other.pos.y) + c1);
    float r4 = ((a1 * other.dest.x) + (b1 * other.dest.y) + c1);

    //Check if r3 and r4 both lie on same side of second line segment
    if ((r3 != 0) && (r4 != 0) && sameSign(r3, r4)){
      intersection.intersected = false;
      return intersection;
    }

    //Compute other lines a, b, c
    float a2 = other.dest.y - other.pos.y;
    float b2 = other.pos.x - other.dest.x;
    float c2 = (other.dest.x * other.pos.y) - (other.pos.x * other.dest.y);

    //Compute r1 and r2
    float r1 = ((a2 * pos.x) + (b2 * pos.y) + c2);
    float r2 = ((a2 * dest.x) + (b2 * dest.y) + c2);

    //Check if r1 and r2 both lie on same side of second line segment
    if ((r1 != 0) && (r2 != 0) && (sameSign(r1, r2))){
      intersection.intersected = false;
      return intersection;
    }

    //Denominator is 0, collinear och parallel
    if ((a1 * b2) - (a2 * b1) == 0) {
      intersection.intersected = false;
      return intersection;
    }

    //If at this point, do intersect
    float denom = (a1 * b2) - (a2 * b1);
    float offset;

    if(denom < 0){
      offset = -denom / 2;
    }
    else{
      offset = denom / 2;
    }

    float n = (b1 * c2) - (b2 * c1);
    if(n < 0){
      intersection.pos.x = (n - offset) / denom;
    }
    else{
      intersection.pos.x = (n + offset) / denom;
    }

    n = (a2 * c1) - (a1 * c2);
    if(n < 0){
      intersection.pos.y = (n - offset) / denom;
    }
    else{
      intersection.pos.y = (n + offset) / denom;
    }

    //It did intersect
    intersection.intersected = true;
    return intersection;
  }

  //Help function for checking if a and b have same sign
  boolean sameSign(float a, float b){
    return ((a * b) >= 0);
  }
}