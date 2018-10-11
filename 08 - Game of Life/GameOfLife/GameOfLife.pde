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

Sound s;

boolean pauseSimulation = true;

void setup(){
  size(800, 800);
  frameRate(speed);

  s = new Sound(this);

  WMAs = new ArrayList<Firework>();

  cellSize = 10 ;
  nrOfColumns = (int)Math.floor(width/cellSize);
  nrOfRows = (int)Math.floor(height/cellSize);

  print(nrOfColumns+":"+nrOfRows+"\n");

  cells = new GameObject[nrOfColumns][nrOfRows];

  ImageLoader imgLoader = new ImageLoader();
  imgLoader.loadImage("testimg.png");
  RGBHolder[][] cellData = imgLoader.getImagePixelData();

  print(nrOfColumns+":"+cells.length+" -- " + nrOfRows + ":" + cells[0].length + "\n");
  //System.exit(0);

  // Create cells
  for(int x = 0; x < nrOfColumns; x++){
    for(int y = 0; y < nrOfRows; y++){
      cells[x][y] = new GameObject(x*cellSize, y*cellSize, cellSize);
      //print("RBG at ["+x+","+y+"] -- ["+cellData[x][y]._r+","+cellData[x][y]._g+","+cellData[x][y]._b + "]\n");

      float rgbValue = cellData[y][x]._r + cellData[y][x]._g + cellData[y][x]._b;
      if(/*rgbValue < 3*200*/random(100) < 15){
        cells[x][y]._resurrecting = true;
      }



      // if( (x == 15 && y == 15) || (x == 16 && y == 15) || (x == 15 && y == 16) || (x == 16 && y == 16)){
      //   cells[x][y]._isAlive = true;
      // }
    }
  }

  // Create neighbours
  calculateNeighbours();
}

void draw(){
  background(0, 255, 0);
  float a = 0.0;
  float b = 0.15;
  float c = 0.001f;
  s.volume(a+b+c);

  //drawGrid();
  stable = "Status: Unstable after " + nrOfGenerations + " generations Speed: " + (int)speed/5 + "x";

  if(!pauseSimulation){
    boolean isStable = true;
    // Check cell status, set _dying or _resurrecting
    for(int x = 0; x < nrOfColumns; x++){
      for(int y = 0; y < nrOfRows; y++){
        if(!cells[x][y].update()){
          isStable = false;
        }
      }
    }

    if(isStable){
      // TODO: Implement fireworks
      //print("Stable!\n");
      stable = "Status: Stable after " + nrOfGenerations + " generations Speed: " + (int)speed/5 + "x";

      //Fireworks!!
      if(random(100) < 5){
        //print("Executing fireworks!!\n");
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

  //input
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

  if(pauseSimulation){
    //rect(width/2 - 110, height/2-50, width/2+-545, height/2+-210);
    DrawText(32, width/2 - 100, height/2 - 16, "SIMULATION PAUSED");
    DrawText(24, width/2 - 65, height/2 + 25, "Press space to unpause");
  }
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

void calculateNeighbours(){
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
      if(x + 1 >= nrOfColumns){
        // We are the rightmost cell
        rightMost = true;
      }

      if(y - 1 < 0){
        // We are the topmost cell
        topMost = true;
      }
      if(y + 1 >= nrOfRows){
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
        if(!bottomMost){
          //print("Adding neighbour at " + (x - 1) + ":" + (y + 1) + "\n");
          neighbourNumbers.add(new PVector(x - 1, y + 1));
        }
      }

      if(!rightMost){
        //print("Adding neighbour at " + (x + 1) + ":" + (y) + "\n");
        neighbourNumbers.add(new PVector(x + 1, y));

        if(!topMost){
          //print("Adding neighbour at " + (x + 1) + ":" + (y - 1) + "\n");
          neighbourNumbers.add(new PVector(x + 1, y - 1));
        }
        if(!bottomMost){
          //print("Adding neighbour at " + (x + 1) + ":" + (y + 1) + "\n");

          neighbourNumbers.add(new PVector(x + 1, y + 1));
        }
      }

      if(!topMost){
        //print("Adding neighbour at " + (x) + ":" + (y - 1) + "\n");
        neighbourNumbers.add(new PVector(x, y - 1));
      }

      if(!bottomMost){
        //print("Adding neighbour at " + (x) + ":" + (y + 1) + "\n");
        neighbourNumbers.add(new PVector(x, y + 1));
      }

      cells[x][y].setNeighbours(neighbourNumbers);
    }
  }
}
