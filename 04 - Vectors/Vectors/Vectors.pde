PVector ellipseAPosition;
int ellipseAWidth = 20;
int ellipseAHeight = 20;
float movementSpeed = 5;

PVector ellipseBPosition;
int ellipseBWidth = 20;
int ellipseBHeight = 20;
PVector ellipseBMovement;

float loseThreshold = 5;
int score = -1;

float timerMax = 60;
float timerCurr = 60;

Boolean endGameOnDefeat = true;

void setup(){
  size(768, 432);

  ellipseAPosition = new PVector(width, height);
  ellipseBPosition = new PVector(width - 25, height - 25);
  ellipseBMovement = new PVector(random(0, 100)/100, random(1, 100)/100).normalize();
  //print("EllipseBMovement: " + ellipseBMovement + "\n");

  PFont f;
  f = createFont("Arial", 16, true);
  textFont(f, 36);
  fill(0, 0, 0);
}

void draw(){
  background(255, 255, 255);
  String s = "Score: " + score;
  text(s, 50, 50);

  timerCurr++;
  if(timerCurr >= timerMax){
    timerCurr = 0;
    score++;
  }

  fill(155, 155, 255);

  moveEllipseA();
  moveEllipseB();

  movementSpeed += 0.01;
}

void moveEllipseA(){
  PVector mousePosition = new PVector(mouseX, mouseY);
  PVector movement = mousePosition.sub(ellipseAPosition);//ellipsePosition.sub(mousePosition);
  PVector movementNormalized = movement;
  if(movement.mag() <= loseThreshold){
    movement.x = 0;
    movement.y = 0;
  }
  movementNormalized.normalize();
  movementNormalized.mult(movementSpeed);

  ellipseAPosition.add(movementNormalized);

  //print("Movement: " + movement + "ellipsePosition: " + ellipsePosition + "\n");

  ellipse(ellipseAPosition.x, ellipseAPosition.y, ellipseAWidth, ellipseAHeight);
  float diffXA = abs(ellipseAPosition.x - mouseX);
  float diffYA = abs(ellipseAPosition.y - mouseY);
  if(diffXA < loseThreshold + ellipseAWidth && diffYA < loseThreshold + ellipseAHeight){
    print("You lose! Final score: " + score);
    if(endGameOnDefeat)
      exit();
  }
}

void moveEllipseB(){
  if(ellipseBPosition.x >= width){
    ellipseBMovement.x = -ellipseBMovement.x;
  }
  else if(ellipseBPosition.x <= 0){
    ellipseBMovement.x = -ellipseBMovement.x;
  }

  if(ellipseBPosition.y >= height){
    ellipseBMovement.y = -ellipseBMovement.y;
  }
  else if(ellipseBPosition.y <= 0){
    ellipseBMovement.y = -ellipseBMovement.y;
  }

  PVector movement = ellipseBMovement;
  //print("Movement: " + movement + "\n");

  PVector movementNormalized = movement;

  movementNormalized.normalize();
  movementNormalized.mult(movementSpeed);

  ellipseBPosition.add(movementNormalized);

  //print("Movement: " + movement + "ellipsePosition: " + ellipsePosition + "\n");

  ellipse(ellipseBPosition.x, ellipseBPosition.y, ellipseBWidth, ellipseBHeight);
  float diffXB = abs(ellipseBPosition.x - mouseX);
  float diffYB = abs(ellipseBPosition.y - mouseY);
  if(diffXB < loseThreshold + ellipseBWidth && diffYB < loseThreshold + ellipseBHeight){
    print("You lose! Final score: " + score + "\n");
    String[] highscores = loadStrings("highscore.txt");
    String[] tmp = new String[highscores.length + 1];
    for(int i = 0; i < highscores.length; i++){
      //print(highscores[i] + "\n");
      //tmp[i] = highscores[i];

      tmp[i] = "This is text";
    }
    tmp[tmp.length - 1] = ""+score;
    saveStrings("highscore.txt", tmp);

    //String[] clear = new String[0];
    //saveStrings("highscore.txt", clear);

    if(endGameOnDefeat)
      exit();
  }
}
