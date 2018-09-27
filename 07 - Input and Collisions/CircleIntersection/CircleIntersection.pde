private float _dt, _lt;
public ArrayList<Shape> shapes;

public Circle circ1, circ2, circ3, circ4, circ5, circ6, circ7;
public Box box1, box2, box3, box4, box5, box6, box7;
public Line line1, line2;
public MultiBox player;

public PVector lineIntersectPoint;

int nrOfCircles = 7;
int maxNrOfCircles = 7;

float timer = 5;
float startTimer = 5;
float timerIncrease = 1;
float timerIncreaseIncrease = 0.1;
boolean gameOver = false;
float score = 0;

public void setup(){
  size(640, 480);

  shapes = new ArrayList<Shape>();

  circ1 = new Circle(150, height - 150, 50);
  circ2 = new Circle(300, height - 250, 50);
  circ3 = new Circle(450, height - 350, 50);
  circ4 = new Circle(600, height - 450, 50);
  circ5 = new Circle(150, height - 350, 50);
  circ6 = new Circle(450, height - 150, 50);
  circ7 = new Circle(50, height - 450, 50);

  box1 = new Box(150, height - 100, 60, 40);
  box2 = new Box(300, height - 200, 60, 40);
  box3 = new Box(450, height - 300, 60, 40);
  box4 = new Box(600, height - 400, 60, 40);
  box5 = new Box(150, height - 300, 60, 40);
  box6 = new Box(450, height - 100, 60, 40);
  box7 = new Box(50, height - 400, 60, 40);

  line1 = new Line(10, 10, width - 10, height - 10);
  line2 = new Line(width - 10, 10, 10, height - 10);

  player = new MultiBox(300, height-50, 40, 80);

  lineIntersectPoint = new PVector(0, 0);

  shapes.add(circ1);
  shapes.add(circ2);
  shapes.add(circ3);
  shapes.add(circ4);
  shapes.add(circ5);
  shapes.add(circ6);
  shapes.add(circ7);

  shapes.add(box1);
  shapes.add(box2);
  shapes.add(box3);
  shapes.add(box4);
  shapes.add(box5);
  shapes.add(box6);
  shapes.add(box7);

  shapes.add(line1);
  shapes.add(line2);

  shapes.add(player);
}

public void draw(){
  fill(255, 255, 255);

  tickDeltaTime();
  background(128);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);

  if(gameOver){
    gameOver();
    return;
  }

  timer -= timerIncrease*_dt;
  if(timer < 0){
    print("You lose!\n");
    gameOver = true;
  }

  PFont f;
  f = createFont("Arial", 48, true);
  textFont(f, 48);
  fill(0, 0, 0);
  text("Score: " + (int)score + " Timer: " + (int)timer, width/2-200, 50);

  //print(nrOfCircles + "\n");
  if(nrOfCircles <= 0){
    for(Shape shape : shapes){
      if(shape instanceof Circle){
        shape.enabled = true;
      }
    }

    nrOfCircles = maxNrOfCircles;
    timerIncrease += timerIncreaseIncrease;
    //player.pos.x = player.center.size.x/2 + 10;
    //player.pos.y = height - player.center.size.y/2 - 10;
  }

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
        if(!shapes.get(j).enabled)
          continue;

        if(shapes.get(j) instanceof Box){
          if(((Box)shapes.get(j)).intersectsMultiBox(((MultiBox)shapes.get(i)))){
            //shapes.get(i).pos.x = shapes.get(j).pos.x;
            shapes.get(i).pos.y = shapes.get(j).pos.y - ((MultiBox)shapes.get(i)).center.size.y/2 - ((Box)shapes.get(j)).size.y/2;
            ((MultiBox)shapes.get(i)).v.y = 0;
          }
        }
        else if(shapes.get(j) instanceof Circle){
          if(((Circle)shapes.get(j)).intersectsMultiBox(((MultiBox)shapes.get(i)))){
            nrOfCircles--;
            timer += 1;
            score++;
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

  if(gameOver){
    resetGame();
  }
}

void resetGame(){
  gameOver = false;
  timer = startTimer;
  score = 0;
  timerIncrease = 1;
  player.pos.x = 300;
  player.pos.y = height-50;

  for(Shape shape : shapes){
    if(shape instanceof Circle){
      shape.enabled = true;
    }
  }
}

void gameOver(){
  PFont f;
  f = createFont("Arial", 48, true);
  textFont(f, 48);
  fill(0, 0, 0);
  text("Game over", width/2-135, 100);
  textFont(f, 36);
  text("Final score: " + (int)score, width/2-105, 251);
  text("Press any button to continue...", width/2-240, 451);
}
