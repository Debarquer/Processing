class CharacterManager{
  //public GameManager gameManager;

  Human[] characters;
  int nrOfCharacters;
  int nrOfZombies;

  public CharacterManager(int nrOfCharacters, int nrOfZombies){
    this.nrOfCharacters = nrOfCharacters;
    this.nrOfZombies = nrOfZombies;

    characters = new Human[nrOfCharacters];
    for(int i = 0; i < nrOfCharacters - nrOfZombies; i++){
      characters[i] = new Human();
      characters[i].characterManager = this;
    }
    for(int i = nrOfCharacters - nrOfZombies; i < nrOfCharacters; i++){
      characters[i] = new Zombie();
      characters[i].characterManager = this;
    }
  }

  public void checkCollision(){
    for(int i = 0; i < characters.length; i++){
      for(int j = i + 1; j < characters.length; j++){
        if(!(characters[i].isEnabled && characters[j].isEnabled))
          continue;

        boolean collided = characters[i].roundCollision(characters[j].pos.x, characters[j].pos.y, characters[j].size.x);

        if(collided){
          //print("Collided\n");
          if(characters[i].isZombie && !characters[j].isZombie){
            //character j dies
            //characters[j].isEnabled = false;

            Human tmp = characters[j];
            characters[j] = new Zombie(tmp.pos, tmp.size, tmp.speed, tmp.target);
            characters[j].characterManager = this;

            nrOfZombies++;
            if(nrOfZombies >= nrOfCharacters){
              //game over
              endGame();
            }
          }
          if(characters[j].isZombie && !characters[i].isZombie){
            //character i dies
            //characters[i].isEnabled = false;

            //characters[i].isZombie = true;
            //characters[i].col = new PVector(0, 255, 0);

            Human tmp = characters[i];
            characters[i] = new Zombie(tmp.pos, tmp.size, tmp.speed, tmp.target);
            characters[i].characterManager = this;

            nrOfZombies++;
            if(nrOfZombies >= nrOfCharacters){
              //game over
              endGame();
            }
          }
        }
      }
    }
  }

  public void updateCharacters(){
    for(int i = 0; i < characters.length; i++){
      if(!characters[i].isEnabled)
        continue;

      characters[i].update();
    }
  }

  public void drawCharacters(){
    for(int i = 0; i < characters.length; i++){
      if(!characters[i].isEnabled)
        continue;

      characters[i].draw();
    }
  }

  public PVector findClosestHuman(PVector pos){

    Human closestHuman = null;// = new Human();
    float shortestDist = -1;

    for(int i = 0; i < characters.length; i++){
      if(characters[i].isZombie){
        continue;
      }

      float distance = dist(pos.x, pos.y, characters[i].pos.x, characters[i].pos.y);
      //print(distance + ":" + shortestDist + "\n");
      if(distance < shortestDist || shortestDist < 0){
        closestHuman = characters[i]; //<>//

        shortestDist = distance;
      }
    }

    //Failed to find a human
    if(closestHuman == null){
       print("Failed to find human\n");
       return new PVector(0, 0); 
       //return new PVector(random(width), random(height)); 
    }
    else if(closestHuman.pos == null){
      print("Found human, but pos is null\n");
      return new PVector(0, 0); 
    }
      
    if(closestHuman.pos.x == 0 && closestHuman.pos.y == 0){
      print("Closest human is at [0,0]?\n");
      return new PVector(0, 0);
    }
    if(shortestDist <= 0){
      print("Shortest distance <= 0?}\n");
      return new PVector(pos.x, pos.y);
    }
    
    return closestHuman.pos;
  }
}
