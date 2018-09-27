private float _dt, _lt;
public ArrayList<Shape> shapes;

public Circle circ1, circ2;
public Box box1, box2;
public Line line1, line2;
public MultiBox player;

public PVector lineIntersectPoint;

public void setup(){
  size(640, 480);

  shapes = new ArrayList<Shape>();

  circ1 = new Circle(300, 200, 50);
  circ2 = new Circle(325, 225, 50);

  box1 = new Box(400, 200, 60, 40);
  box2 = new Box(430, 220, 60, 40);

  line1 = new Line(10, 10, width - 10, height - 10);
  line2 = new Line(width - 10, 10, 10, height - 10);

  player = new MultiBox(400, 141, 40, 80);

  lineIntersectPoint = new PVector(0, 0);

  shapes.add(circ1);
  shapes.add(circ2);

  shapes.add(box1);
  shapes.add(box2);

  shapes.add(line1);
  shapes.add(line2);

  shapes.add(player);
}

public void draw(){
  fill(255, 255, 255);

  tickDeltaTime();
  background(128);

  line1.dest.x = mouseX;
  line1.dest.y = mouseY;

  for(int i = 0; i < shapes.size(); i++){
    shapes.get(i).update(_dt);
  }

  //println(circ1.intersectsCircle(circ2));
  //println(box1.intersectsBox(box2));
  //println(line1.intersectsLine(line2));
  //println("onGround: " + player.onGround(box1));
  //println("inGround: " + player.inGround(box1));

  Intersection intersection = line1.intersectsLine(line2);
  if(intersection.intersected){

    //print("Intersected at ["+intersection.pos.x+","+intersection.pos.y+"]\n");

    lineIntersectPoint.x = intersection.pos.x;
    lineIntersectPoint.y = intersection.pos.y;

    fill(255, 0, 0);
    ellipse(lineIntersectPoint.x, lineIntersectPoint.y, 20, 20);
  }
  else{
    //print("No intersection!\n");
  }
}

public void tickDeltaTime(){
  _dt = (millis() - _lt) * 0.001;
  _lt = millis();
}
