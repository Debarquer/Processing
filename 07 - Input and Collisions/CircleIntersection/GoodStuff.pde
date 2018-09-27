//Repetition av OOP
//  public, private, protected
//  class, interface
//  extends, implements
//  static, abstract, final

//Array och ArrayList<>

//Kollision
//  Real world, molecules push objects away 
//    from each other

//  Very basic geometry
//    Circle: radius
//    Rectangle: intersection of bounds
//    Line: intersection of lines
//    Line/Plane: intersection of line and plane

//  Vertice based geometry
//    Intersection of edges
//    3D Concave/Convex issue

//  Pixel collision
//    Per pixel check, Bitmap
//    Height Maps
//    Collision boxes

//  Optimization required
//    Bounding boxes, Quadtrees, Octrees

//1.Koda om linjekollisionen så att den returnerar positionen där de korsar varandra
//   http://processingjs.org/learning/custom/intersect/
//2.Förse multikollisionen objektet med rörelse och gravitation
//3.Låt in-kollision leda till att positionen korrigeras så att multikollisionsobjektet alltid
//    hamnar ovanpå "plattformarna" och fall stängs av
//4.Implementera att avsaknad av on-kollision leder till att multikollision börjar falla igen
//*5.Implementera möjlighet för multikollisionsobjetet att gå höger och vänster och "hoppa"
//*6.Implementera att kollision mellan multikollisionsobjektet och cirklar tar bort cirklarna