CharacterManager cm;

boolean gameOver = false;
float gameOverSeconds = 0;

void setup(){

  size(900, 900);

  cm = new CharacterManager(40, 1);
}

void draw(){
  background(255, 255, 255);

  cm.checkCollision();
  cm.updateCharacters();
  cm.drawCharacters();

  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);

  if(gameOver){
    gameOver();
  }
}

void gameOver(){
  PFont f;
  f = createFont("Arial", 16, true);
  textFont(f, 96);
  fill(0, 0, 0);

  String s = "GAME OVER";
  int x = 160;
  int y = 300;
  text(s, x, y);

  f = createFont("Arial", 16, true);
  textFont(f, 48);
  fill(0, 0, 0);

  s = "Humanity survived for: " + (int)gameOverSeconds + " time";
  x = 150;
  y = 450;
  text(s, x, y);
}

void endGame(){
  if(!gameOver){
    gameOver = true;
    gameOverSeconds = millis()/1000;
  }
}
