class Ball{
  PVector myPos, v, a;
  float myWidth, myHeight;
  float[] myColor;

  public Ball(float posX, float posY, float myWidth, float myHeight, float vX, float vY, float aX, float aY, float[] myColor){
    this.myPos = new PVector(posX, posY);
    this.myWidth = myWidth;
    this.myHeight = myHeight;
    this.v = new PVector(vX, vY);
    this.a = new PVector(aX, aY);
    this.myColor = myColor;
  }
}

float lastFrameTime;
float currentFrameTime;
float deltaTime;

Ball[] balls;
int nrOfBalls = 20;

void setup(){
  size(600, 600);

  float lastFrameTime = 1f / 60;

  balls = new Ball[nrOfBalls];
  for(int i = 0; i < nrOfBalls; i++){
    float[] c = new float[]{random(255), random(255), random(255)};
    //float myPos.y.x, float myPos.y, float myWidth, float myHeight, float v.x, float v.y, float aX, float aY, float[] myColor
    balls[i] = new Ball(20 + 20 * i, random(height), 10, 10, 0, 0, 0, 0, c);
  }
}

void draw(){
  background(255, 255, 255);

  currentFrameTime = millis();

  deltaTime = (currentFrameTime - lastFrameTime)/1000;

  for(int i = 0; i < nrOfBalls; i++){
    //CalculateTeleportMovement(balls[i]);
    CalculateMouseGravity(balls[i]);
    //CalculateGravityDown(balls[i]);

    fill(balls[i].myColor[0], balls[i].myColor[1], balls[i].myColor[2]);
    ellipse(balls[i].myPos.x, balls[i].myPos.y, balls[i].myWidth, balls[i].myHeight);
  }

  fill(255, 255, 0);
  ellipse(mouseX, mouseY, 10, 10);

  lastFrameTime = millis();
}

void CalculateTeleportMovement(Ball ball){
  ball.myPos.x += ball.v.x * deltaTime;
  ball.v.x += ball.a.x * deltaTime;

  if(ball.myPos.x >= width){
    ball.myPos.x = 0;
  }
  else if(ball.myPos.x <= 0){
    ball.v.x = -ball.v.x;
    ball.myPos.x = 0;
  }

  ball.myPos.y += ball.v.y * deltaTime;
  ball.v.y += ball.a.y * deltaTime;

  if(ball.myPos.y >= height){
    ball.v.y = -ball.v.y * 0.9;
    ball.myPos.y = height;
  }
  else if(ball.myPos.y <= 0){
    ball.v.y = -ball.v.y;
    ball.myPos.y = 0;
  }
}

void CalculateMouseGravity(Ball ball){
  PVector pointToGravitateTowards = new PVector(mouseX, mouseY);

  PVector myPos = new PVector(ball.myPos.x, ball.myPos.y);
  PVector otherPos = new PVector(pointToGravitateTowards.x, pointToGravitateTowards.y);
  PVector direction = otherPos.sub(myPos);
  float distanceSquared = direction.mag() * direction.mag();
  float distanceMod = 1/distanceSquared;
  direction.normalize();

  Boolean doneY = false;
  Boolean doneX = false;
  if(abs(ball.myPos.y - pointToGravitateTowards.y) < 3){
    ball.a.y = 0;
    ball.v.y = 0;

    doneY = true;
  }
  if(abs(ball.myPos.x - pointToGravitateTowards.x) < 3){
    ball.a.x = 0;
    ball.v.x = 0;

    doneX = true;
  }

  if(doneY && doneX){
    ball.myColor = new float[]{random(255), random(255), random(255)};
    ball.myPos.x = random(width);
    ball.myPos.y = random(height);
  }

  ball.a.x += 600 * deltaTime * distanceMod;
  ball.v.x += ball.a.x * deltaTime;
  ball.myPos.x += direction.x * ball.v.x * deltaTime;


  ball.a.y += 600 * deltaTime * distanceMod;
  ball.v.y += ball.a.y * deltaTime;
  ball.myPos.y += direction.y * ball.v.y * deltaTime;
}

void CalculateGravityDown(Ball ball){

  // ball.myPos.x += ball.v.x * deltaTime;
  // ball.v.x += ball.a.x * deltaTime;
  //
  // if(ball.myPos.x >= width){
  //   ball.v.x = -ball.v.x * 0.9;
  //   ball.myPos.x = width;
  // }
  // else if(ball.myPos.x <= 0){
  //   ball.v.x = -ball.v.x;
  //   ball.myPos.x = 0;
  // }

  ball.myPos.y += ball.v.y * deltaTime;
  ball.v.y += ball.a.y * deltaTime;

  if(ball.myPos.y >= height){
    ball.v.y = -ball.v.y * 0.9;
    ball.myPos.y = height;
  }
  else if(ball.myPos.y <= 0){
    ball.v.y = -ball.v.y;
    ball.myPos.y = 0;
  }
}
