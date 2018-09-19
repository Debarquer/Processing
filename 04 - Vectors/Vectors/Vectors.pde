class QuickSort
{
    int partition(int arr[], int low, int high)
    {
        int pivot = arr[high];
        int i = (low-1); // index of smaller element
        for (int j=low; j<high; j++)
        {
            if (arr[j] >= pivot)
            {
                i++;

                int temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
        }

        int temp = arr[i+1];
        arr[i+1] = arr[high];
        arr[high] = temp;

        return i+1;
    }

    void sort(int arr[], int low, int high)
    {
        if (low < high)
        {
            int pi = partition(arr, low, high);

            sort(arr, low, pi-1);
            sort(arr, pi+1, high);
        }
    }

    /* A utility function to print array of size n */
    public void printArray(int arr[])
    {
        int n = arr.length;
        for (int i=0; i<n; ++i)
            System.out.print(arr[i]+" ");
        System.out.println();
    }
}
QuickSort QS;

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

Boolean gameOver = false;

void setup(){
  size(768, 432);

  QS = new QuickSort();

  ellipseAPosition = new PVector(width, height);
  ellipseBPosition = new PVector(width - 25, height - 25);
  ellipseBMovement = new PVector(random(0, 100)/100, random(1, 100)/100).normalize();
  //print("EllipseBMovement: " + ellipseBMovement + "\n");

  //String[] s = new String[]{"Hello World! \n This is very nice!"};
  //saveStrings("highscore.txt", s);
}

void draw(){
  if(!gameOver){
    background(255, 255, 255);

    PFont f;
    f = createFont("Arial", 16, true);
    textFont(f, 36);
    fill(0, 0, 0);

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
  else{
    GameOverScreen();
  }

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
    exitGame();
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
    exitGame();
  }
}

float GameOverYBuffer = 30;
float yMod = 0;
float scrollspeed = 3;
void GameOverScreen(){
   background(255, 255, 255);

   PFont f;
   f = createFont("Arial", 16, true);
   textFont(f, 96);
   fill(255, 0, 0);

  String s = "GAME       OVER!\n";
  text(s, width/2 - 380, height/2);

  f = createFont("Arial", 16, true);
  textFont(f, 24);
  fill(0, 0, 0);

  String[] highscores = loadStrings("highscore.txt");

  int[] highscoresI = new int[highscores.length];
  for(int i = 0; i < highscoresI.length; i++){
    highscoresI[i] = Integer.parseInt(highscores[i]);
  }

  QS.sort(highscoresI, 0, highscores.length - 1);

  for(int i = 0; i < highscores.length; i++){
    s = "Score: " + highscoresI[i] + "\n";

    text(s, width/2 - 50, height + GameOverYBuffer + GameOverYBuffer*i + yMod);
  }
  yMod-=scrollspeed;
  if(yMod < -highscores.length * GameOverYBuffer - height){
    yMod = 0;
  }
}

void exitGame(){
  if(score <= 0){
    print("Score <= 0, no highscore recorded\n");
  }
  else{
    String[] highscores = loadStrings("highscore.txt");
    String[] tmp = new String[highscores.length + 1];
    for(int i = 0; i < highscores.length; i++){

      tmp[i] = highscores[i];
    }
    tmp[tmp.length - 1] = ""+score;

    saveStrings(dataPath("highscore.txt"), tmp);
  }

  if(endGameOnDefeat){
    gameOver = true;
    score = 0;
    movementSpeed = 5;
  }
}

void mousePressed(){
  if(gameOver){
    gameOver = false;
  }
}
