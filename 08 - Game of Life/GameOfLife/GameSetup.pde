void GameSetup(){
  sound = new Sound(this);

  WMAs = new ArrayList<Firework>();

  cellSize = 10;
  nrOfColumns = (int)Math.floor(width/cellSize);
  nrOfRows = (int)Math.floor(height/cellSize);

  print(nrOfColumns+":"+nrOfRows+"\n");

  cells = new GameObject[nrOfColumns][nrOfRows];

  ImageLoader imgLoader = new ImageLoader();
  imgLoader.loadImage("testimg.png");
  RGBHolder[][] cellData = imgLoader.getImagePixelData();

  print(nrOfColumns+":"+cells.length+" -- " + nrOfRows + ":" + cells[0].length + "\n");

  // Create cells
  for(int x = 0; x < nrOfColumns; x++){
    for(int y = 0; y < nrOfRows; y++){
      cells[x][y] = new GameObject(x*cellSize, y*cellSize, cellSize);

      float rgbValue = cellData[y][x]._r + cellData[y][x]._g + cellData[y][x]._b;
      if(/*rgbValue < 3*200*/random(100) < 15){
        cells[x][y]._resurrecting = true;
      }
    }
  }

  // Create neighbours
  calculateNeighbours();
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
        neighbourNumbers.add(new PVector(x - 1, y));

        if(!topMost){
          neighbourNumbers.add(new PVector(x - 1, y - 1));
        }
        if(!bottomMost){
          neighbourNumbers.add(new PVector(x - 1, y + 1));
        }
      }

      if(!rightMost){
        neighbourNumbers.add(new PVector(x + 1, y));

        if(!topMost){
          neighbourNumbers.add(new PVector(x + 1, y - 1));
        }
        if(!bottomMost){
          neighbourNumbers.add(new PVector(x + 1, y + 1));
        }
      }

      if(!topMost){
        neighbourNumbers.add(new PVector(x, y - 1));
      }

      if(!bottomMost){
        neighbourNumbers.add(new PVector(x, y + 1));
      }

      cells[x][y].setNeighbours(neighbourNumbers);
    }
  }
}
