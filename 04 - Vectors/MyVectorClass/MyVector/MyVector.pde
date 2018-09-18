class MyVectorClass{
  float x, y, z;

  public MyVectorClass(){
    x = 0;
    y = 0;
    z = 0;
  }

  public MyVectorClass(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }

  public MyVectorClass(float angle){
    float length = getLength();
    //float length = 10;
    x = cos(angle) * length;
    y = sin(angle) * length;
  }

  public String toString(){
    return "[x: " + x + ", y: " + y + ", z: " + z + "]\n";
  }

  public void add(int a){
    x += a;
    y += a;
    z += a;
  }

  public void add(int x, int y, int z){
    this.x += x;
    this.y += y;
    this.z += z;
  }

  public void add(MyVectorClass v){
    this.x += v.x;
    this.y += v.y;
    this.z += v.z;
  }

  public void sub(int a){
    x -= a;
    y -= a;
    z -= a;
  }

  public void sub(int x, int y, int z){
    this.x -= x;
    this.y -= y;
    this.z -= z;
  }

  public void sub(MyVectorClass v){
    this.x -= v.x;
    this.y -= v.y;
    this.z -= v.z;
  }

  public void mult(int a){
    x *= a;
    y *= a;
    z *= a;
  }

  public void mult(int x, int y, int z){
    this.x *= x;
    this.y *= y;
    this.z *= z;
  }

  public void mult(MyVectorClass v){
    this.x *= v.x;
    this.y *= v.y;
    this.z *= v.z;
  }

  public void div(int a){
    if(a != 0){
      x /= a;
      y /= a;
      z /= a;
    }
    else{
      print("MyVectorClass error: Division by 0 - a cannot be 0\n");
    }
  }

  public void div(int x, int y, int z){
    if(x != 0 && y != 0 && z != 0){
      this.x /= x;
      this.y /= y;
      this.z /= z;
    }
    else{
      print("MyVectorClass error: Divison by 0 - x, y, z cannot be 0\n");
    }

  }

  public void div(MyVectorClass v){
    if(v.x != 0 && v.y != 0 && v.z != 0){
      this.x /= v.x;
      this.y /= v.y;
      this.z /= v.z;
    }
    else{
      print("MyVectorClass error: Divison by 0 - v cannot have member variables with a value of 0\n");
    }
  }

  void setAngle(float angle){
    float length = getLength();
    //float length = 10;
    x = cos(angle) * length;
    y = sin(angle) * length;
  }

  float getAngle(){
    return atan2(y, x);
  }

  void setLength(float length){
    float angle = getAngle();
    x = cos(angle) * length;
    y = sin(angle) * length;
  }

  float getLength(){
    return sqrt(x * x + y * y);
  }

  void normalize(){
    //print("getLength(): " + getLength() + " [x1, y1]:["+x+","+y+"]");
    x /= getLength();
    y /= getLength();
    //print(",[x2,y2]:["+x+","+y+"]\n");
  }
}
MyVectorClass myVectorSecond;
MyVectorClass myVectorMinute;
MyVectorClass myVectorHour;

float startAngle = -90;

float angleHour;
float angleMinute;
float angleSecond;

float speedSecond = 6;
float speedMinute = 6;
float speedHour = 6;

float timerSecondMax = 60;
float timersecondCurr = 0;
float timerMinuteMax = 60;
float timerMinuteCurr = 0;
float timerHourMax = 12;
float timerHourCurr = 0;

float timerSpeedMod = 1;

float timerSpeedSecond = 1 * timerSpeedMod;
float timerSpeedMinute = 1 * timerSpeedMod;
float timerSpeedHour = 1 * timerSpeedMod;

void setup(){
  size(600, 600);

  PFont f;
  f = createFont("Arial", 16, true);
  textFont(f, 16);
  fill(0, 0, 0);

  //print("Current time: " + hour()%12+":"+minute()+":"+second()+"\n");

  float hourQuota = ((hour()%12) / (float)12);
  float minuteQuota = ((minute()) / (float)60);
  float secondQuota = ((second()) / (float)60);

  //print("Percentages: " + hourQuota+":"+minuteQuota+":"+secondQuota+"\n");

  timerHourCurr = timerMinuteMax * minuteQuota;
  timerMinuteCurr = timerSecondMax * secondQuota;
  timersecondCurr = 0;

  angleHour = 360 * hourQuota - 90;
  angleMinute = 360 * minuteQuota - 90;
  angleSecond = 360 * secondQuota - 90;

  //print("Angles: " + angleHour+":"+angleMinute+":"+angleSecond+"\n");
}

void draw(){
  timersecondCurr+=timerSpeedSecond;
  timerSpeedMod = 1;
  timerSpeedSecond = 1 * timerSpeedMod;
  timerSpeedMinute = 1 * timerSpeedMod;
  timerSpeedHour = 1 * timerSpeedMod;

  //once per second on base speed
  if(timersecondCurr >= timerSecondMax){
    timersecondCurr = -0;

    background(255, 255, 255);

    drawDots();
    drawNumbers();

    angleSecond+=speedSecond;

    //once per minute on base speed
    timerMinuteCurr+=timerSpeedMinute;
    if(timerMinuteCurr >= timerMinuteMax){
      timerMinuteCurr = 0;

      angleMinute+=speedMinute/timerSpeedMod;

      timerHourCurr+=timerSpeedHour;

      print("["+timerHourCurr+":"+timerMinuteCurr+":"+timersecondCurr+"]\n");

      //once per hour on base speed
      if(timerHourCurr >= timerHourMax){
        timerHourCurr = 0;

        angleHour+=speedHour/timerSpeedMod/timerSpeedMod;
      }
    }

    drawHands();
  }
}

void drawDots(){
  int nrOfDots = 60;
  for(int i = 0; i < 360; i+=(360/nrOfDots)){
    strokeWeight(1);
    if(i%5==0)
      strokeWeight(3);

    float x = cos(radians(-90+i)) * 200.0;
    float y = sin(radians(-90+i)) * 200.0;

    ellipse(width/2 + x, height/2 + y, 2, 2);
  }
}

void drawNumbers(){
  int nrOfNumbers = 12;
  for(int i = 0; i < 360; i+=(360/nrOfNumbers)){
    strokeWeight(1);
    if(i%5==0)
      strokeWeight(3);

    float x = cos(radians(-90+i)) * 220.0;
    float y = sin(radians(-90+i)) * 220.0;

    //ellipse(width/2 + x, height/2 + y, 2, 2);
    int myHour = i*nrOfNumbers/360;
    if(myHour == hour()%12){
      fill(255, 0, 0);
    }
    else{
      fill(0, 0, 0);
    }

    if(myHour == 0){
      myHour = 12;
    }

    String s = ""+myHour;
    text(s, width/2 + x, height/2 + y);
  }
}

void drawHands(){
  myVectorSecond = new MyVectorClass(100, 0, 100);
  myVectorSecond.normalize();

  myVectorSecond.setAngle(radians(angleSecond));
  line(width/2, height/2, width/2+(myVectorSecond.x*200), height/2+(myVectorSecond.y*200));

  myVectorMinute = new MyVectorClass(100, 0, 100);
  myVectorMinute.normalize();

  myVectorMinute.setAngle(radians(angleMinute));
  line(width/2, height/2, width/2+(myVectorMinute.x*150), height/2+(myVectorMinute.y*150));

  myVectorHour = new MyVectorClass(100, 0, 100);
  myVectorHour.normalize();

  myVectorHour.setAngle(radians(angleHour));
  line(width/2, height/2, width/2+(myVectorHour.x*100), height/2+(myVectorHour.y*100));
}
