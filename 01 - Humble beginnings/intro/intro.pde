//Assignmnet print my name.
int origStartX = 10;
float startY = 0;
Boolean descending = true;

float PCDistA = 10;
float PCDistB = 10;
float PCMod = 1;
int PCTimeCurr = 0;
int PCTimeMax = 1;

int frame = 0;
float[][] lineColors;
ParabolicCurve PC;

class ParabolicCurve{
  void drawParabolicCurves(int PCStartX, int PCStartY, int numberOfLines, int PCEndY, float PCDistanceX, float PCDistanceY, int PCWidth){
    stroke(128, 128, 128, 128);
    strokeWeight(PCWidth);

    for(int i = 0; i < numberOfLines; i++){
      if(i%3==0){
        stroke(0, 0, 0, 255);
      }
      else{
        //wrong color but more visible
        stroke(128, frame, 128, 128);
      }
      line(PCStartX, PCStartY+(i*PCDistanceY), (i+1)*PCDistanceX, PCEndY);
    }
  }
}

void setup(){
  size(768, 432);
  //size(1920, 1080);
  PC = new ParabolicCurve();

  lineColors = new float[height][];
  for(int i = 0; i < height; i++){
    lineColors[i] = new float[3];
    lineColors[i][0] = random(255);
    lineColors[i][1] = random(255);
    lineColors[i][2] = random(255);
  }
}

void draw(){
  //rect(x, 10, 2, 80);

  background(128, 255, 255, 255);
  int myWidth = 120;
  int startX = origStartX;

  drawScanLines();
  drawName(myWidth, startX);
  DrawParabolicCurves();

  origStartX += 2;
  if(origStartX >= 760){
    origStartX = -760;
  }
}

void drawScanLines(){
  strokeWeight(2);

  for(int i = 0; i < height; i+=1){
    int yPos = i + frame;
    if(yPos >= height){
      // lineColors[i][0] = random(255);
      // lineColors[i][1] = random(255);
      // lineColors[i][2] = random(255);

      yPos -= height;
    }

    float r = lineColors[i][0];
    float g = lineColors[i][1];
    float b = lineColors[i][2];
    stroke(r, g, b);

    line(0, yPos, width, yPos);
  }

  frame++;
  if(frame >= height){
    frame = 0;
  }
}

void DrawParabolicCurves(){
  //PC.drawParabolicCurves(0, 0, width, height, 20, 20);
  PC.drawParabolicCurves(width, height, width, height, PCDistA, -PCDistA, 2);
  PC.drawParabolicCurves(0, height, width, 0, PCDistB, -PCDistB, 2);

  PCTimeCurr++;
  if(PCTimeCurr >= PCTimeMax){
    PCTimeCurr = 0;

    PCDistA += PCMod*(PCDistA/50)/4;
    PCDistB += PCMod*(PCDistB/50)/4;
    if(PCDistA > 20){
      PCMod = -1;
    }
    else if(PCDistA <= 4){
      PCMod = 1;
    }
  }
}

void drawName(int myWidth, int startX){
  float red = abs(startX/760 * 255);
  float green = abs(startY/760 * 255);
  float blue = abs((startX + startY)/760 * 255);
  fill(red, green, blue, 255);
  stroke(red, green, blue, 255);

  //S
  rect(startX, startY+20, myWidth, 30);
  rect(startX, startY+20, 30, 150);
  rect(startX, startY+150, myWidth, 30);
  rect(startX + 90, startY+150, 30, 150);
  rect(startX, startY+290, myWidth, 30);

  startX += myWidth + 30;
  myWidth = 30;

  //I
  rect(startX, startY+20, myWidth, 300);

  startX += myWidth + 30;
  myWidth = 30;
  //M
  pushMatrix();
  translate(startX, startY+20);
  rotate(radians(-30));
  rect(220 - 225, 15, myWidth, 175);
  popMatrix();
  pushMatrix();
  translate(startX, startY+20);
  rotate(radians(30));
  rect(220 -75, -80, myWidth, 175);
  popMatrix();
  rect(startX, startY+20, myWidth, 300);
  rect(startX + (myWidth * 3) + 70, startY+20, myWidth, 300);

  startX += (myWidth * 4) + 100;
  myWidth = 30;

  //O
  rect(startX, startY+20, 150, myWidth);
  rect(startX, startY+290, 150, myWidth);
  rect(startX, startY+20, myWidth, 300);
  rect(startX + 120, startY+20, myWidth, 300);

  startX += 180;
  myWidth = 30;

  //N
  pushMatrix();
  translate(startX, startY+20);
  rotate(radians(-20));
  rect(-2, 12, myWidth, 306);
  popMatrix();

  rect(startX, startY+20,myWidth, 300);
  rect(startX + 106, startY+20, myWidth, 300);


  if(descending){
   startY += 0.5;
   if(startY > 100){
      descending = false;
    }
    else{
     float r = random(100);
     if(r < 2){
       descending = !descending;
      }
    }

    return;
  }
  else{
    startY -= 0.5;
    if(startY <= 0){
      descending = true;
    }
    else{
     float r = random(100);
     if(r < 2){
       descending = !descending;
      }
    }

    return;
  }
}
