int frame = 0;
float multiplier = 0.04;
int numberOfPoints = 320;

Boolean descending = true;

void setup()
{
	size(640, 480);
	strokeWeight(5);
}

void draw()
{
	background(255);

	//Draw animated point
  for(int i = 0; i < 100; i++){
    stroke(255, 155, 155);

    point(i*5, 240 + sin((i+frame) * multiplier) * 200);
  }

  for(int i = 0; i < 100; i++){
    stroke(155, 155, 255);
    point(i*5, 240 + cos((i+frame) * multiplier) * 200);
  }

  frame++;
}
