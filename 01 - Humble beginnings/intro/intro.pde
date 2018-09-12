//Assignmnet print my name.
int origStartX = 10;
float startY = 0;
Boolean descending = true;

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
  PC = new ParabolicCurve();
}

void draw(){
  //rect(x, 10, 2, 80);

  background(128, 255, 255, 0.5);
  int myWidth = 120;
  int startX = origStartX;

  drawName(myWidth, startX);
  DrawParabolicCurves();

  origStartX += 2;
  if(origStartX >= 760){
    origStartX = -760;
  }
}

void DrawParabolicCurves(){
  //PC.drawParabolicCurves(0, 0, width, height, 20, 20);
  PC.drawParabolicCurves(width, height, width, height, 10, -10, 2);
  PC.drawParabolicCurves(0, height, width, 0, 10, -10, 2);
}

void drawName(int myWidth, int startX){
  float red = abs(startX/760 * 255);
  float green = abs(startY/760 * 255);
  float blue = abs((startX + startY)/760 * 255);
  fill(red, green, blue);
  stroke(red, green, blue);

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
