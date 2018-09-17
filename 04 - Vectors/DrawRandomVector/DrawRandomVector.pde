Boolean generateNewLine = true;

Boolean startedDrawing = false;
Boolean stoppedDrawing = false;

PVector startDraw;
PVector endDraw;

class MyLine{
  float x1, y1, x2, y2;
  public MyLine(float x1, float y1, float x2, float y2){
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }
}
MyLine randomLine;
PVector randomVector;

void setup(){
  size(768, 432);

  //randomVector = new PVector(random(width/2), random(height/2));
  //randomLine = new MyLine(0.0f, 0.0f, randomVector.x, randomVector.y);
}

void draw(){
  background(255);
  strokeWeight(10);
  line(400, 0, 400, height);
  strokeWeight(2);
  drawGrid();

  if(generateNewLine){
    generateNewLine = false;

    randomVector = new PVector(random(width/4), random(height/4));
    randomVector.normalize();
    randomVector.mult(width/4);
    randomLine = new MyLine(0.0f, 0.0f, randomVector.x, randomVector.y);

    print("Your vector is: " + randomVector + "\n");
  }

  //line(randomLine.x1, randomLine.y1, randomLine.x2, randomLine.y2);

  if(startedDrawing){
    if(stoppedDrawing){
      startedDrawing = false;
      stoppedDrawing = false;

      //print("Your vector is: " + randomVector + "\n");
      PVector yourVector = new PVector();
      yourVector = endDraw;
      yourVector.sub(startDraw);
      //print("Your vector: " + yourVector + " Start pos: " + startDraw + " End pos: " + endDraw + "\n");

      PVector diff = new PVector(abs(yourVector.x - randomVector.x), abs(yourVector.y - randomVector.y));
      float totalDiff = diff.x + diff.y;
      if(totalDiff < 10){
        print("Difference: " + diff + "Amazing! \n");
      }
      else if(totalDiff < 25){
        print("Difference: " + diff + "Good job! \n");
      }
      else if(totalDiff < 50){
        print("Difference: " + diff + "Nice try! \n");
      }
      else if(totalDiff < 100){
        print("Difference: " + diff + "Better luck next time! \n");
      }
      else if(totalDiff < 150){
        print("Difference: " + diff + "I know you can do better! \n");
      }
      else{
        print("Difference: " + diff + "Come on, do it more closier! \n");
      }


      generateNewLine = true;
    }
    else{
      line(startDraw.x, startDraw.y, mouseX, mouseY);
    }

  }
}

void drawGrid(){
  int space = 50;

  for(int i = 0; i < width; i+=space){
    line(i, 0, i, height);
  }

  for(int i = 0; i < height; i+=space){
    line(0, i, width, i);
  }
}

void mousePressed(){
  //print("Mouse pressed \n");
  startedDrawing = true;
  startDraw = new PVector(mouseX, mouseY);
}

void mouseReleased(){
  if(startedDrawing){
    //print("Mouse clicked \n");
    stoppedDrawing = true;
    endDraw = new PVector(mouseX, mouseY);
  }
}
