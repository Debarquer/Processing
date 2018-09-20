class CharacterManager{
  Human[] characters;
  int nrOfCharacters;
  int nrOfZombies;

  public CharacterManager(int nrOfCharacters, int nrOfZombies){
    this.nrOfCharacters = nrOfCharacters;
    this.nrOfZombies = nrOfZombies;

    characters = new Human[nrOfCharacters];
    for(int i = 0; i < nrOfCharacters - nrOfZombies; i++){
      characters[i] = new Human();
    }
    for(int i = nrOfCharacters - nrOfZombies; i < nrOfCharacters; i++){
      characters[i] = new Zombie();
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
    PVector closestHuman = new PVector(0, 0);
    float shortestDist = 0;
    for(int i = 0; i < characters.length; i++){
      float dist = dist(pos.x, pos.y, characters[i].pos.x, characters[i].pos.y);
      if(dist < shortestDist){
        closestHuman.x = characters[i].pos.x;
        closestHuman.y = characters[i].pos.y;

        shortestDist = dist;
      }
    }

    return closestHuman;
  }
}
