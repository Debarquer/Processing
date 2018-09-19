class Ball{
  float xPos, yPos, myWidth, myHeight, vX, vY, aX, aY;
  float[] myColor;

  public Ball(float xPos, float yPos, float myWidth, float myHeight, float vX, float vY, float aX, float aY, float[] myColor){
    this.xPos = xPos;
    this.yPos = yPos;
    this.myWidth = myWidth;
    this.myHeight = myHeight;
    this.vX = vX;
    this.vY = vY;
    this.aX = aX;
    this.aY = aY;
    this.myColor = myColor;
  }
}


float xPos;
float yPos;

float vX;
float vY;

float a;

float lastFrameTime;
float currentFrameTime;
float deltaTime;

Ball[] balls;
int nrOfBalls = 20;

void setup(){
  size(600, 600);

  xPos = width/2;
  yPos = height/2;

  vY = 60;
  a = 60*9;

  float lastFrameTime = 1f / 60;

  balls = new Ball[nrOfBalls];
  for(int i = 0; i < nrOfBalls; i++){
    float[] c = new float[]{random(255), random(255), random(255)};
    //                  float xPos,  float yPos,     float myWidth, float myHeight, float vX,           float vY,    float aX, float aY, float[] myColor
    balls[i] = new Ball(20 + 20 * i, random(height), 10,            10,             0,        0, 60,        60,        c);

    //balls[i] = new Ball(0, 0, 10,            10,             random(120),        random(120), 0,        a,        c);
  }
}

void draw(){
  background(255, 255, 255);

  currentFrameTime = millis();

  deltaTime = (currentFrameTime - lastFrameTime)/1000;

  for(int i = 0; i < nrOfBalls; i++){
    CalculateMouseGravity(balls[i]);
    //CalculateGravityDown(balls[i]);

    fill(balls[i].myColor[0], balls[i].myColor[1], balls[i].myColor[2]);
    ellipse(balls[i].xPos, balls[i].yPos, balls[i].myWidth, balls[i].myHeight);
  }

  ellipse(mouseX, mouseY, 100, 100);

  lastFrameTime = millis();
}

void CalculateMouseGravity(Ball ball){
  PVector pointToGravitateTowards = new PVector(mouseX, mouseY);
  //print(pointToGravitateTowards+"\n");

  // balls[i].xPos += balls[i].vX * deltaTime;
  // balls[i].vX += balls[i].aX * deltaTime;
  // if(ball.xPos >= width){
  //   ball.vX = -ball.vX * 0.9;
  //   ball.xPos = width;
  // }
  // else if(ball.xPos <= 0){
  //   ball.vX = -ball.vX;
  //   ball.xPos = 0;
  // }

  //ball.yPos += ball.vY * deltaTime;
  //ball.vY += ball.aY * deltaTime;

  PVector myPos = new PVector(ball.xPos, ball.yPos);
  PVector otherPos = new PVector(pointToGravitateTowards.x, pointToGravitateTowards.y);
  PVector direction = otherPos.sub(myPos);
  direction.normalize();

  //ball.xPos = ball.xPos + direction.x * ball.vX * deltaTime;
  //ball.yPos = ball.yPos + direction.y * ball.vY * deltaTime;

  // float a = pointToGravitateTowards.x - myPos.x;
  // float b = pointToGravitateTowards.y - myPos.y;
  // float c = sqrt(a*a + b*b);

  //PVector direction = new PVector();
  // float dX = cos();
  // float dY = sin();

  //print(ball.xPos + ":" + pointToGravitateTowards.x + " - " + "["+ball.aX+"]["+ball.xPos+"]["+ball.vX+"] : [deltatime:"+deltaTime+"]\n");

  Boolean doneY = false;
  Boolean doneX = false;
  if(abs(ball.yPos - pointToGravitateTowards.y) < 20){
    ball.aY = 0;
    ball.vY = 0;

    doneY = true;
  }
  if(abs(ball.xPos - pointToGravitateTowards.x) < 20){
    //print("Stopping ball!\n");
    ball.aX = 0;
    ball.vX = 0;

    doneX = true;
  }

  if(doneY && doneX){
    ball.xPos = random(width);
    ball.yPos = random(height);
  }

  //print(ball.xPos + ":" + pointToGravitateTowards.x + " - " + "["+ball.aX+"]["+ball.xPos+"]["+ball.vX+"]["+direction.x*vX*deltaTime+"] : [deltatime:"+deltaTime+"]\n");

  ball.aX += 60 * deltaTime;
  ball.vX += ball.aX * deltaTime;
  ball.xPos += direction.x * ball.vX * deltaTime;


  ball.aY += 60 * deltaTime;
  ball.vY += ball.aY * deltaTime;
  ball.yPos += direction.y * ball.vY * deltaTime;


  //print(ball.vX + ":" + ball.aX + "\n");
}

void CalculateGravityDown(Ball ball){

  // ball.xPos += ball.vX * deltaTime;
  // ball.vX += ball.aX * deltaTime;
  //
  // if(ball.xPos >= width){
  //   ball.vX = -ball.vX * 0.9;
  //   ball.xPos = width;
  // }
  // else if(ball.xPos <= 0){
  //   ball.vX = -ball.vX;
  //   ball.xPos = 0;
  // }

  ball.yPos += ball.vY * deltaTime;
  ball.vY += ball.aY * deltaTime;

  if(ball.yPos >= height){
    ball.vY = -ball.vY * 0.9;
    ball.yPos = height;
  }
  else if(ball.yPos <= 0){
    ball.vY = -ball.vY;
    ball.yPos = 0;
  }
}
