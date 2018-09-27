private float _dt, _lt;
public ArrayList<Shape> shapes;

public Circle circ1, circ2, circ3, circ4;
public Box box1, box2, box3, box4;
public Line line1, line2;
public MultiBox player;

public PVector lineIntersectPoint;

public void setup(){
  size(640, 480);

  shapes = new ArrayList<Shape>();

  circ1 = new Circle(300, height - 50, 50);
  circ2 = new Circle(150, height - 50, 50);
  circ3 = new Circle(50, height - 50, 50);
  circ4 = new Circle(350, height - 50, 50);

  box1 = new Box(100, height - 100, 60, 40);
  box2 = new Box(200, height - 200, 60, 40);
  box3 = new Box(300, height - 300, 60, 40);
  box4 = new Box(400, height - 400, 60, 40);

  line1 = new Line(10, 10, width - 10, height - 10);
  line2 = new Line(width - 10, 10, 10, height - 10);

  player = new MultiBox(-400, -400, 40, 80);

  lineIntersectPoint = new PVector(0, 0);

  shapes.add(circ1);
  shapes.add(circ2);
  shapes.add(circ3);
  shapes.add(circ4);

  shapes.add(box1);
  shapes.add(box2);
  shapes.add(box3);
  shapes.add(box4);

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
    if(!shapes.get(i).enabled)
      continue;

    if(shapes.get(i) instanceof MultiBox){
      fill(0, 255, 0);
    }
    else{
      fill(255, 255, 255);
    }
    shapes.get(i).update(_dt);
  }

  for(int i = 0; i < shapes.size(); i++){
    if(shapes.get(i) instanceof MultiBox){
      for(int j = 0; j < shapes.size(); j++){
        if(shapes.get(j) instanceof Box){
          if(((Box)shapes.get(j)).intersectsMultiBox(((MultiBox)shapes.get(i)))){
            //shapes.get(i).pos.x = shapes.get(j).pos.x;
            shapes.get(i).pos.y = shapes.get(j).pos.y - ((MultiBox)shapes.get(i)).center.size.y/2 - ((Box)shapes.get(j)).size.y/2;
            ((MultiBox)shapes.get(i)).v.y = 0;
          }
        }
        else if(shapes.get(j) instanceof Circle){
          if(((Circle)shapes.get(j)).intersectsMultiBox(((MultiBox)shapes.get(i)))){
            //shapes.get(i).pos.x = shapes.get(j).pos.x;
            //shapes.get(i).pos.y = shapes.get(j).pos.y - ((MultiBox)shapes.get(i)).center.size.y/2 - ((Box)shapes.get(j)).size.y/2;
            //((MultiBox)shapes.get(i)).v.y = 0;
          }
        }
      }
    }
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

public void mousePressed(){
  player.pos.x = mouseX;
  player.pos.y = mouseY;
}
