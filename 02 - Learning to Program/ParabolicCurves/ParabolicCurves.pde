class ParabolicCurve{
    void drawParabolicCurves(PVector pos, LineCoord LCY, LineCoord LCX, int numberOfLines, int PCWidth){
      stroke(128, 128, 128, 128);
      strokeWeight(PCWidth);

    //calculates the direction of the curves in the y and x axis
    int modY = 0;
    if(LCY.y2 > LCY.y1){
      modY = 1;
    }
    else if(LCY.y2 < LCY.y1){
      modY = -1;
    }
    else{
      print("Error: y2 == y1?");
    }

    int modX = 0;
    if(LCX.x2 > LCX.x1){
      modX = 1;
    }
    else if(LCX.x2 < LCX.x1){
      modX = -1;
    }
    else{
      print("Error: x2 == x1?");
    }


    for(int i = 0; i < numberOfLines; i++){
      float x1 = pos.x + LCY.x1;
      float y1 = pos.y + LCY.y1 + (i * abs(LCY.y2 - LCY.y1)/numberOfLines * modY);
      float x2 = pos.x + LCX.x1 + (i * abs(LCX.x2 - LCX.x1)/numberOfLines * modX);
      float y2 = pos.y + LCX.y1;

      if(i%3==0){
            stroke(0, 0, 0, 255);
          }
          else{
            stroke(128, 128, 128, 128);
          }

      line(x1, y1, x2, y2);
    }
  }
}
ParabolicCurve PC;

class LineCoord{
  float x1, y1, x2, y2;
  LineCoord(float x1, float y1, float x2, float y2){
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x2;
      this.y2 = y2;
  }
}

void setup(){
  size(768, 432);
  //background(128, 255, 255, 0.5);
  PC = new ParabolicCurve();
}

void draw(){
  background(128, 255, 255, 0.5);

  PVector pos = new PVector();
  pos.x = 0;
  pos.y = 0;
  int startX = 0;
  int startY = 0;
  int midX = startX;
  int endX = width;
  int endY = height;
  int nrOfLines = 20;

  LineCoord LC1 = new LineCoord(width, height, width, 0);
  LineCoord LC2 = new LineCoord(width, 0, 0, 0);

  PC.drawParabolicCurves(pos, LC1, LC2, nrOfLines, 2);

  LineCoord LC3 = new LineCoord(startX, startY, midX, endY);
  LineCoord LC4 = new LineCoord(midX, endY, endX, endY);

  PC.drawParabolicCurves(pos, LC3, LC4, nrOfLines, 2);

  pos.x = 0;
  pos.y = 0;
  startX = 200;
  startY = 100;
  endX = 500;
  endY = 300;

  LineCoord LC5 = new LineCoord(startX, startY, startX, endY);
  LineCoord LC6 = new LineCoord(startX, endY, endX, endY);
  PC.drawParabolicCurves(pos, LC5, LC6, 10, 2);
}
