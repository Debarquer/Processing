import processing.sound.*;

GameObject cells[][];

/* Array alternative: One dimensional array cells[]

  cells = new int[nrOfCells];

  for(int i = 0; i < nrOfRows; i++){
    for(int j = 0; j < nrOfColumns; j++){
      int row = i * nrOfColumns; //i multiplied by the width of the array
      int column = j; //get the position on the row
      cells[row + column] = row+column;
    }
  }

  for(int i = 0; i < nrOfCells; i++){
    print(cells[i] + "\n");
  }

  Row x, column y is accessed by [((x - 1) * widthOfArray) + (row - 1)]
  print(cells[((x-1)*nrOfColumns) + (y-1)]);

*/

int cellSize;
int nrOfColumns;
int nrOfRows;
int fillPercentage = 15;
int speed = 5;
int speedIncreaseIncrement = 5;

int nrOfGenerations = 0;

String stable = "Unstable";

ArrayList<Firework> WMAs;

Sound sound;

boolean pauseSimulation = true;

void setup(){
  size(800, 800);
  frameRate(speed);
  GameSetup();
}

void draw(){
  Input();

  background(0, 255, 0);
  float a = 0.0;
  float b = 0.15;
  float c = 0.001f;
  sound.volume(a+b+c);

  //drawGrid();
  stable = "Status: Unstable after " + nrOfGenerations + " generations Speed: " + (int)speed/5 + "x";

  if(!pauseSimulation){
    if(CalculateCellStatus()){
      // TODO: Implement fireworks
      stable = "Status: Stable after " + nrOfGenerations + " generations Speed: " + (int)speed/5 + "x";

      //Fireworks!!
      if(random(100) < 5){
        float size = random(10, 20);
        WMAs.add(new Firework(new PVector(random(width), height), new PVector(size, size), random(2)));
      }

      for(Firework wma : WMAs){
        wma.update();
        wma.draw();
      }
      for(int i = 0; i < WMAs.size(); i++){
        if(!WMAs.get(i)._enabled){
          WMAs.remove(i);
        }
      }
    }
    else{
      nrOfGenerations++;
      stable = "Status: Unstable after " + nrOfGenerations + " generations Speed: " + (int)speed/5 + "x";
    }
  }
  else{
  }

  UpdateCellStatus();
  DrawCells();
  DrawUI();
}

void drawGrid(){
  for(int x = 0; x < height; x+=cellSize){
    line(x, 0, x, height);
  }
  for(int y = 0; y < width; y+=cellSize){
    line(0, y, width, y);
  }
}

void DrawText(float size, float x, float y, String s){
  PFont f;
  f = createFont("Arial", size, true);
  textFont(f, size);

  fill(0);
  for(int i = -1; i < 2; i++){
      text(s, x+i,y);
      text(s, x,y+i);
  }
  fill(255);
  text(s, x,y);
}

boolean CalculateCellStatus(){
  boolean isStable = true;
  for(int x = 0; x < nrOfColumns; x++){
    for(int y = 0; y < nrOfRows; y++){
      if(!cells[x][y].update()){
        isStable = false;
      }
    }
  }

  return isStable;
}

void Input(){
  if(moveUpP2){
    print("Increase speed\n");
    if(speed < 100)
      speed+=speedIncreaseIncrement;
  }
  else if(moveDownP2){
    print("Decrease speed\n");
    if(speed > speedIncreaseIncrement)
      speed-=speedIncreaseIncrement;
  }
  frameRate(speed);

  moveUpP2 = false;
  moveDownP2 = false;
}

void UpdateCellStatus(){
  for(int x = 0; x < nrOfColumns; x++){
    for(int y = 0; y < nrOfRows; y++){
      if(cells[x][y]._dying){
        cells[x][y].die();
      }
      else if(cells[x][y]._resurrecting){
        cells[x][y].resurrect();
      }
      else{
        // Do nothing
      }
    }
  }
}

void DrawCells(){
  for(int x = 0; x < nrOfColumns; x++){
    for(int y = 0; y < nrOfRows; y++){
      cells[x][y].draw();
    }
  }
}

void DrawUI(){
  DrawText(32, 50, 50, stable);

  if(pauseSimulation){
    DrawText(32, width/2 - 100, height/2 - 16, "SIMULATION PAUSED");
    DrawText(24, width/2 - 65, height/2 + 25, "Press space to unpause");
  }
}
