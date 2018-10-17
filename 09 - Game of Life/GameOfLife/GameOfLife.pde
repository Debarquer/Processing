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
float drawOffsetX = 0;
float drawOffsetY = 0;

int nrOfColumns;
int nrOfRows;
int fillPercentage = 15;

int speed = 5;
int speedIncreaseIncrement = 5;

int nrOfGenerations = 0;

String stable = "Status: Unstable after " + nrOfGenerations + " generations Speed: " + (int)speed/5 + "x";

ArrayList<Firework> WMAs;

Sound sound;

boolean pauseSimulation = true;

void setup(){
  size(800, 640);
  frameRate(speed);
  GameSetup();
}

void draw(){
  processInput();
  background(0, 255, 0);
  //drawGrid();

  if(!pauseSimulation){
    if(CalculateCellStatus()){
      stable = "Status: Stable after " + nrOfGenerations + " generations Speed: " + (int)speed/5 + "x";
      updateFireworks();
    }
    else{
      nrOfGenerations++;
      stable = "Status: Unstable after " + nrOfGenerations + " generations Speed: " + (int)speed/5 + "x";
    }
  }

  UpdateCellStatus();
  DrawCells();
  DrawUI();
}

void drawGrid(){
  for(int x = 0; x < width; x+=cellSize){
    line(x, 0, x, height);
  }
  for(int y = 0; y < height; y+=cellSize){
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

void updateFireworks(){
  if(random(100) < 5){
    float size = random(10, 20);
    WMAs.add(new Firework(new PVector(random(width), height), new PVector(size, size), random(1, height/250)));
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

void processInput(){
  float moveSpeed = 10*cellSize;
  if(moveUp){
    drawOffsetY += moveSpeed;
  }
  if(moveDown){
    drawOffsetY -= moveSpeed;
  }
  if(moveLeft){
    drawOffsetX += moveSpeed;
  }
  if(moveRight){
    drawOffsetX -= moveSpeed;
  }

  // Values from scrollWheel() func are reversed from expected
  cellSize += -scrollWheel;
  if(cellSize < 1){
    cellSize = 1;
  }
  scrollWheel = 0;

  if(oldMousePos != null){
		PVector newMousePos = new PVector(mouseX, mouseY);
    PVector direction = new PVector();

    direction.x = newMousePos.x;
    direction.y = newMousePos.y;
		direction.sub(oldMousePos);

		drawOffsetX += direction.x;
		drawOffsetY += direction.y;

    oldMousePos = newMousePos;
	}

  frameRate(speed);
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
    }
  }
}

void DrawCells(){
  fill(0, 0, 0, 255);
  for(int x = 0; x < nrOfColumns; x++){
    for(int y = 0; y < nrOfRows; y++){
      if(cells[x][y]._isAlive){
        // Check if the cell is within the screen view
        if(cells[x][y]._x > 0 && cells[x][y]._y > 0 && cells[x][y]._x < width && cells[x][y]._y < height)
          cells[x][y].draw();
      }
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
