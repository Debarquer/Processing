boolean moveLeft;
boolean moveRight;
boolean moveUp;
boolean moveDown;
boolean jump;

void keyPressed(){

  if(key == CODED){
    if(keyCode == RIGHT){
      moveRight = true;
    }
    else if(keyCode == LEFT){
      moveLeft = true;
    }
    else if(keyCode == UP){
      jump = true;
    }
    else if(keyCode == DOWN){
      moveDown = true;
    }
    else if(keyCode == CONTROL){
      //print("Pressed alt\n");
      jump = true;
    }
  }

  if(key == 'w' || key == 'W'){
    moveUp = true;
  }
  if(key == 's' || key == 'S'){
    moveDown = true;
  }
  if(key == 'd' || key == 'D'){
    moveRight = true;
  }
  if(key == 'a' || key == 'A'){
    moveLeft = true;
  }
}

void keyReleased(){
  if(key == CODED){
    if(keyCode == RIGHT){
      moveRight = false;
    }
    else if(keyCode == LEFT){
      moveLeft = false;
    }
    else if(keyCode == UP){
      jump = false;
    }
    else if(keyCode == DOWN){
      moveDown = false;
    }
    else if(keyCode == CONTROL){
      jump = false;
    }
  }

  if(key == 'w' || key == 'W'){
    moveUp = false;
  }
  if(key == 's' || key == 'S'){
    moveDown = false;
  }
  if(key == 'd' || key == 'D'){
    moveRight = false;
  }
  if(key == 'a' || key == 'A'){
    moveLeft = false;
  }
}

float getAxisRaw(String axis){

  if(axis == "Horizontal"){
    if(moveLeft && moveRight){
      return 0;
    }
    if(moveLeft){
      return -1;
    }
    if(moveRight){
      return 1;
    }
  }
  else if(axis == "Vertical"){
    if(moveUp && moveDown){
      return 0;
    }
    if(moveUp){
      return -1;
    }
    if(moveDown){
      return 1;
    }
  }
  else{
    print("Input error: Invalid axis\n");
  }

  return 0;
}
