int frame = 0;
float multiplier = 0.04;

Boolean descending = true;

float[][] dotPoints;
int nrOfPointsIncrement = 100;
int nrOfPoints = 0;

void setup()
{
  size(640, 480);
  strokeWeight(5);

  dotPoints = new float[nrOfPoints][];

  for(int i = 0; i < nrOfPoints; i++){
    dotPoints[i] = new float[2];
    dotPoints[i][0] = 0;
    dotPoints[i][1] = 0;
  }
}

void draw()
{
  background(255);

  //Draw animated point
  GeneratePointsSin(0, nrOfPointsIncrement, 0);
  GeneratePointsCos(nrOfPointsIncrement, 2*nrOfPointsIncrement, 4*nrOfPointsIncrement);

  // for(int i = 0; i < 10; i++){
  //   GeneratePointsSin(nrOfPointsIncrement * i, (i+1)*nrOfPointsIncrement, 500+i);
  // }
  DrawPoints();
  //DrawLines();

  frame++;
}

void GeneratePointsSin(int start, int end, int posOffset){

  if(start > nrOfPoints || end > nrOfPoints){ //<>// //<>//
    UpdateDotPoints(nrOfPoints + nrOfPointsIncrement);
    print("Start: " + start + " nrOfPoints: " + nrOfPoints + " end: " + end + "Increasing array size\n");
    //end += nrOfPointsIncrement;
  }

  for(int i = start; i < end; i++){
    stroke(255, 155, 155);
    float x = i*5 - posOffset;
    float y = 240 + sin((i+frame) * multiplier) * 200;

    dotPoints[i] = new float[2];
    dotPoints[i][0] = x;
    dotPoints[i][1] = y;

    //point(i*5, 240 + sin((i+frame) * multiplier) * 200);
  }
}

void GeneratePointsCos(int start, int end, int posOffset){

  if(start > nrOfPoints || end > nrOfPoints){ //<>// //<>//
    UpdateDotPoints(nrOfPoints + nrOfPointsIncrement);
    print("Start: " + start + " nrOfPoints: " + nrOfPoints + " end: " + end + "Increasing array size\n");
    //end += nrOfPointsIncrement;
  }

  for(int i = start; i < end; i++){
    stroke(155, 155, 255);
    float x = i*5 - posOffset;
    float y = 240 + cos((i+frame) * multiplier) * 200;

    dotPoints[i] = new float[2];
    dotPoints[i][0] = x;
    dotPoints[i][1] = y;

    //point(i*5, 240 + cos((i+frame) * multiplier) * 200);
  }
}

void UpdateDotPoints(int newNrOfPoints){
  float[][] tmp = new float[nrOfPoints][]; //<>// //<>// //<>//
  for(int i = 0; i < nrOfPoints; i++){
    tmp[i] = new float[2];
    tmp[i][0] = dotPoints[i][0];
    tmp[i][1] = dotPoints[i][1];
  }

  dotPoints = new float[newNrOfPoints][];
  for(int i = 0; i < nrOfPoints; i++){
    dotPoints[i] = new float[2];
    dotPoints[i][0] = tmp[i][0];
    dotPoints[i][1] = tmp[i][1];
  }
  nrOfPoints = newNrOfPoints;
} //<>//

void DrawPoints(){
  for(int i = 0; i < nrOfPoints; i++){ //<>// //<>//
    float x = dotPoints[i][0];
    float y = dotPoints[i][1];
    point(x, y);
  }
}

void DrawLines(){
  for(int i = 0; i < nrOfPoints-1; i++){
    float x1 = dotPoints[i][0];
    float y1 = dotPoints[i][1];
    float x2 = dotPoints[i+1][0];
    float y2 = dotPoints[i+1][1];
    line(x1, y1, x2, y2);
  }
}
