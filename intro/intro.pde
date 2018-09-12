//Assignmnet print my name.
int origStartX = 10;
float startY = 0;
Boolean descending = true;

void setup(){ 
  size(768, 432);
}

void draw(){
  //rect(x, 10, 2, 80);
  
  background(128, 255, 255, 0.5);
  
  int width = 120;
  int startX = origStartX;
  
  float red = abs(startX/760 * 255);
  float green = abs(startY/760 * 255);
  float blue = abs((startX + startY)/760 * 255);
  fill(red, green, blue);
  stroke(red, green, blue);
  
  //S
  rect(startX, startY+20, width, 30);
  rect(startX, startY+20, 30, 150);
  rect(startX, startY+150, width, 30);
  rect(startX + 90, startY+150, 30, 150);
  rect(startX, startY+290, width, 30);
  
  startX += width + 30;
  width = 30;
  
  //I
  rect(startX, startY+20, width, 300);
  
  startX += width + 30;
  width = 30;
  //M
  pushMatrix();
  translate(startX, startY+20);
  rotate(radians(-30));
  rect(220 - 225, 15, width, 175);
  popMatrix();
  pushMatrix();
  translate(startX, startY+20);
  rotate(radians(30));
  rect(220 -75, -80, width, 175);
  popMatrix();
  rect(startX, startY+20, width, 300);
  rect(startX + (width * 3) + 70, startY+20, width, 300);

  startX += (width * 4) + 100;
  width = 30;
  
  //O
  rect(startX, startY+20, 150, width);
  rect(startX, startY+290, 150, width);
  rect(startX, startY+20, width, 300);
  rect(startX + 120, startY+20, width, 300);
  
  startX += 180;
  width = 30;
  
  //N
  pushMatrix();
  translate(startX, startY+20);
  rotate(radians(-20));
  rect(-2, 12, width, 306);
  popMatrix();

  rect(startX, startY+20, width, 300);
  rect(startX + 106, startY+20, width, 300);
  
  origStartX += 2;
  if(origStartX >= 760){
    origStartX = -760;
  }
  
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
