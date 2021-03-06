int frameCircle = 0;
int frameParabolic = 0;
float multiplier = 0.04;
int numberOfPoints = 320;

Boolean descending = true;

Float[][] circleDotPos;
int nrOfDots = 0;

int circleMaxMinTimerMax = 120;
int circleMaxMInTimerCurr = 0;

int parabolicAnimState = 0;

void setup()
{
	size(640, 480);
	strokeWeight(5);
  frameRate(60);

  circleDotPos = new Float[360][];

	for(int i = 0; i < 360; i++){
		circleDotPos[i] = new Float[5];
		circleDotPos[i][0] = 0.5;
		circleDotPos[i][1] = 0.5;
		circleDotPos[i][2] = random(255);
		circleDotPos[i][3] = random(255);
		circleDotPos[i][4] = random(255);
	}
}

void draw()
{
	background(255, 255, 255);

	DrawCircle();
  ParabolicCurves();

  //frame++;
  if(descending){
    frameCircle += 1;
		frameParabolic += 1;
    if(frameCircle >= 250){
			circleMaxMInTimerCurr++;
			if(circleMaxMInTimerCurr >= circleMaxMinTimerMax){
					descending = false;
					circleMaxMInTimerCurr = 0;
					parabolicAnimState = (int)random(0, 4);
			}
			else{
				frameCircle -= 1;
			}
      return;
    }
  }
  else{
		frameCircle -= 1;
		frameParabolic -= 1;
    if(frameCircle <= 0){
			circleMaxMInTimerCurr++;
			if(circleMaxMInTimerCurr >= circleMaxMinTimerMax){
					descending = true;
					circleMaxMInTimerCurr = 0;
					parabolicAnimState = (int)random(0, 4);
			}
			else{
				frameCircle += 1;
			}
      return;
    }
  }
}

float PCDistA = 10;
float PCDistB = 10;
//TODO: Animate these
void ParabolicCurves(){

	switch(parabolicAnimState){
		case 0:
		PCDistA = 10 + 1*sin(frameParabolic/15)*2;
		PCDistB = 10  + 1*sin(frameParabolic/15)*2;
		break;
		case 1:
		PCDistA = 10 + 1*sin(frameParabolic/15)*2;
		PCDistB = 10  + 1*cos(frameParabolic/15)*2;
		break;
		case 2:
		PCDistA = 10 + 1*cos(frameParabolic/15)*2;
		PCDistB = 10  + 1*sin(frameParabolic/15)*2;
		break;
		case 3:
		PCDistA = 10 + 1*cos(frameParabolic/15)*2;
		PCDistB = 10  + 1*cos(frameParabolic/15)*2;
		break;
	}


  drawParabolicCurves(width, height, width, height, PCDistA, -PCDistB, 2);
  drawParabolicCurves(0, height, width, 0, PCDistA, -PCDistB, 2);
}
void drawParabolicCurves(int PCStartX, int PCStartY, int numberOfLines, int PCEndY, float PCDistanceX, float PCDistanceY, int PCWidth){
  stroke(128, 128, 128, 128);
  strokeWeight(PCWidth);

  for(int i = 0; i < numberOfLines; i++){
    if(i%3==0){
      stroke(0, 0, 0, 255);
    }
    else{
      stroke(128, 128, 128, 128);
    }
    line(PCStartX, PCStartY+(i*PCDistanceY), (i*PCDistanceX), PCEndY);
  }
}

void DrawCircle(){
  nrOfDots = 0;

  int arrayId = 0;
  for(int i = 0; i < 360; i++){
    if(i >= 360){
      break;
    }

    stroke(255, 155, 155); //<>// //<>//

    float rads = radians(i);

    //frame = 200;
    float x = (width/2)+cos(rads+frameCircle)*(frameCircle/2);
    float y = (height/2)+sin(rads+frameCircle)*(frameCircle/2);

		//Change every frame?
    //circleDotPos[arrayId] = new Float[5];
    circleDotPos[arrayId][0] = x;
    circleDotPos[arrayId][1] = y;
    //circleDotPos[arrayId][2] = random(255);
    //circleDotPos[arrayId][3] = random(255);
    //circleDotPos[arrayId][4] = random(255);
    arrayId++;
    nrOfDots++;

    //Draws the points
    //strokeWeight(5);
    //stroke(random(255),random(255),random(255));
    point(x, y);
  }

  for(int i = 0; i < (nrOfDots/2); i++){
    strokeWeight(2);
    stroke(circleDotPos[i][2], circleDotPos[i][2], circleDotPos[i][2], 155);

    float x1 = circleDotPos[(i + 0)%nrOfDots][0];
    float y1 = circleDotPos[(i + 0)%nrOfDots][1];
    float x2 = circleDotPos[(nrOfDots-1-i + 0)%nrOfDots][0];
    float y2 = circleDotPos[(nrOfDots-1-i + 0)%nrOfDots][1];

    line(x1, y1, x2, y2);
  }

  for(int i = 0; i < nrOfDots; i++){
    float x1 = circleDotPos[(i + 0)%nrOfDots][0];
    float y1 = circleDotPos[(i + 0)%nrOfDots][1];
    float x2 = circleDotPos[(i+1 + 0)%nrOfDots][0];
    float y2 = circleDotPos[(i+1 + 0)%nrOfDots][1];

    line(x1, y1, x2, y2);
  }
}
