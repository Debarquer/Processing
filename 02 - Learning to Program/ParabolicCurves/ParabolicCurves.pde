class ParabolicCurve{
    void drawParabolicCurves(int PCStartX, int PCStartY, int numberOfLines, int PCEndY, int PCDistanceX, int PCDistanceY, int PCWidth){
      stroke(128, 128, 128, 128);
      strokeWeight(PCWidth);

      for(int i = 0; i < numberOfLines; i++){
        if(i%3==0){
          stroke(0, 0, 0, 255);
        }
        else{
          stroke(128, 128, 128, 128);
        }
        line(PCStartX, PCStartY+(i*PCDistanceY), i*PCDistanceX, PCEndY);
      }
    }
}
ParabolicCurve PC;

void setup(){
  size(768, 432);
  background(128, 255, 255, 0.5);
  PC = new ParabolicCurve();
}

void draw(){
  //PC.drawParabolicCurves(0, 0, width, height, 20, 20);
  PC.drawParabolicCurves(width, height, width, height, 10, -10, 2);
  PC.drawParabolicCurves(0, height, width, 0, 10, -10, 2);
}
