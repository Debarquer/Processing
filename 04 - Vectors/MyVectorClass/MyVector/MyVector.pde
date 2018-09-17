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
}
MyVectorClass myVector;

void setup(){
  size(768, 432);

  myVector = new MyVectorClass(10, 10, 10);
  print(myVector);

  myVector.div(1);
  print(myVector);

  myVector.div(1, 2, 3);
  print(myVector);

  myVector.div(new MyVectorClass(-1, -2, -3));
  print(myVector);

  myVector.div(0);
  print(myVector);

  myVector.div(1, 0, 3);
  print(myVector);

  myVector.div(new MyVectorClass(-1, -2, 0));
  print(myVector);
}

void draw(){

}
