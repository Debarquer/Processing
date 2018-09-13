class ParabolicCurve{
    void drawParabolicCurves(LineCoord LC, int numberOfLines, int PCDistanceX, int PCDistanceY, int PCWidth){
      stroke(128, 128, 128, 128);
      strokeWeight(PCWidth);

      for(int i = 0; i < numberOfLines; i++){
        if(i%3==0){
          stroke(0, 0, 0, 255);
        }
        else{
          stroke(128, 128, 128, 128);
        }
        line(LC.x1, LC.y1+(i*PCDistanceY), i*PCDistanceX, LC.y2);
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
  background(128, 255, 255, 0.5);
  PC = new ParabolicCurve();
}

void draw(){
  //PC.drawParabolicCurves(0, 0, width, height, 20, 20);

  LineCoord LC1 = new LineCoord(width, height, 0, height);
  LineCoord LC2 = new LineCoord(0, height, 0, 0);

  PC.drawParabolicCurves(LC1, width, 10, -10, 2);
  PC.drawParabolicCurves(LC2, width, 10, -10, 2);
}
