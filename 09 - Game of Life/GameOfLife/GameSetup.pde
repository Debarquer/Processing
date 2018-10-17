void GameSetup(){
  sound = new Sound(this);

  float a = 0.0;
  float b = 0.15;
  float c = 0.001f;
  sound.volume(a+b+c);

  WMAs = new ArrayList<Firework>();

  cellSize = 5;
  nrOfColumns = (int)Math.floor(width/cellSize);
  nrOfRows = (int)Math.floor(height/cellSize);

  print(nrOfColumns+":"+nrOfRows+"\n");

  ImageLoader imgLoader = new ImageLoader();
  imgLoader.loadImage("testimg.png");
  RGBHolder[][] cellData = imgLoader.getImagePixelData();

  print(nrOfColumns+":"+cellData.length+" -- " + nrOfRows + ":" + cellData[0].length + "\n");

  nrOfColumns = cellData.length;
  nrOfRows = cellData[0].length;

  cells = new GameObject[nrOfColumns][nrOfRows];

  // Create cells
  for(int x = 0; x < nrOfColumns; x++){
    for(int y = 0; y < nrOfRows; y++){
      cells[x][y] = new GameObject(x, y);

      float rgbValue = cellData[x][y]._r + cellData[x][y]._g + cellData[x][y]._b;
        if(rgbValue < 3*200){
          cells[x][y]._resurrecting = true; //<>//
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

      for(int dx = -1; dx <= 1; dx++){
        for(int dy = -1; dy <= 1; dy++){

          if(dx == 0 && dy == 0){
            continue;
          }

          try{
            GameObject cell = cells[x+dx][y+dy];
          }
          catch(Exception e){
            //print("Invalid neighbour from ["+x+","+y+"] to ["+(x+dx)+","+(y+dy)+"] \n");
            continue;
          }

          //print("Adding neighbour from ["+x+","+y+"] to ["+(x+dx)+","+(y+dy)+"] \n");
          neighbourNumbers.add(new PVector(x+dx, y+dy));
        }
      }

      cells[x][y].setNeighbours(neighbourNumbers);
    }
  }
}
