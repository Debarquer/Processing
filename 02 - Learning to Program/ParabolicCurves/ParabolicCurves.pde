class ParabolicCurve{
    void drawParabolicCurves(int PCStartX, int PCStartY, int PCEndX, int PCEndY, int PCDistanceX, int PCDistanceY){
      stroke(128, 128, 128, 128);
      strokeWeight(5);
    
      for(int i = 0; i < PCEndX; i++){
        //int yPos = i+scanLinesYDiff - height;
        
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
  PC = new ParabolicCurve();
}

void draw(){
  //PC.drawParabolicCurves(0, 0, width, height, 20, 20);
  PC.drawParabolicCurves(width, height, width, height, 20, -20);
  PC.drawParabolicCurves(0, height, width, 0, 20, -20);
}
