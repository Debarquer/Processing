GameObject cells[][];

int cellSize;
int nrOfColumns;
int nrOfRows;
int fillPercentage = 15;

String stable = "Unstable";

void setup(){
  size(600, 600);
  frameRate(4);

  cellSize = 20;
  nrOfColumns = (int)Math.floor(width/cellSize);
  nrOfRows = (int)Math.floor(height/cellSize);

  print(nrOfColumns+":"+nrOfRows+"\n");

  cells = new GameObject[nrOfColumns][nrOfRows];

  // Create cells
  for(int x = 0; x < nrOfColumns; x++){
    for(int y = 0; y < nrOfRows; y++){
      cells[x][y] = new GameObject(x*cellSize, y*cellSize, cellSize);
      // if(random(0, 100) < fillPercentage){
      //   cells[x][y]._isAlive = true;
      // }
      if( (x == 15 && y == 15) || (x == 16 && y == 15) || (x == 15 && y == 16) || (x == 16 && y == 16)){
        cells[x][y]._isAlive = true;
      }
    }
  }

  // Create neighbours
  for(int x = 0; x < nrOfColumns; x++){
    for(int y = 0; y < nrOfRows; y++){

      ArrayList<PVector> neighbourNumbers = new ArrayList<PVector>();

      boolean leftMost = false;
      boolean rightMost = false;
      boolean topMost = false;
      boolean bottomMost = false;

      if(x - 1 < 0){
        // We are the leftmost cell
        leftMost = true;
      }
      if(x + 1 > nrOfColumns){
        // We are the rightmost cell
        rightMost = true;
      }

      if(y - 1 < 0){
        // We are the topmost cell
        topMost = true;
      }
      if(y + 1 > nrOfRows){
        // We are the bottommost cell
        bottomMost = true;
      }

      if(!leftMost){
        //print("Adding neighbour at " + (x - 1) + ":" + (y) + "\n");
        neighbourNumbers.add(new PVector(x - 1, y));

        if(!topMost){
          //print("Adding neighbour at " + (x - 1) + ":" + (y - 1) + "\n");
          neighbourNumbers.add(new PVector(x - 1, y - 1));
        }
        if(y + 1 < 30){
          //print("Adding neighbour at " + (x - 1) + ":" + (y + 1) + "\n");
          neighbourNumbers.add(new PVector(x - 1, y + 1));
        }
      }

      if(x + 1 < 30){
        //print("Adding neighbour at " + (x + 1) + ":" + (y) + "\n");
        neighbourNumbers.add(new PVector(x + 1, y));

        if(!topMost){
          //print("Adding neighbour at " + (x + 1) + ":" + (y - 1) + "\n");
          neighbourNumbers.add(new PVector(x + 1, y - 1));
        }
        if(y + 1 < 30){
          //print("Adding neighbour at " + (x + 1) + ":" + (y + 1) + "\n");

          neighbourNumbers.add(new PVector(x + 1, y + 1));
        }
      }

      if(!topMost){
        //print("Adding neighbour at " + (x) + ":" + (y - 1) + "\n");
        neighbourNumbers.add(new PVector(x, y - 1));
      }

      if(y + 1 < 30){
        //print("Adding neighbour at " + (x) + ":" + (y + 1) + "\n");
        neighbourNumbers.add(new PVector(x, y + 1));
      }

      cells[x][y].setNeighbours(neighbourNumbers);
    }
  }
}

void draw(){
  background(0, 255, 0);

  drawGrid();

  boolean isStable = true;
  // Check cell status, set _dying or _resurrecting
  for(int x = 0; x < nrOfColumns; x++){
    for(int y = 0; y < nrOfRows; y++){
        isStable = cells[x][y].update();
    }
  }

  if(isStable){
    stable = "Stable";
  }

  // Update cell staus, die() or resurrect()
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

  // Draw cells
  for(int x = 0; x < nrOfColumns; x++){
    for(int y = 0; y < nrOfRows; y++){
      cells[x][y].draw();
    }
  }

  //Draw UI
  DrawText(32, 50, 50, stable);
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
  //fill(0, 0, 0);

  fill(0);
  for(int i = -1; i < 2; i++){
  //  for(int y = -1; y < 2; y++){
  //    text("LIKE THIS!", 20+x,20+y);
  //  }
      text(s, x+i,y);
      text(s, x,y+i);
  }
  fill(255);
  text(s, x,y);

  //text(s, x, y);
}
