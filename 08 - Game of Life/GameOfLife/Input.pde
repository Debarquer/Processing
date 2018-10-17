
boolean moveUp;
boolean moveDown;
boolean moveLeft;
boolean moveRight;
int scrollWheel = 0;

PVector oldMousePos = null;

void keyPressed(){

	//keyCodes
	boolean shift = false;

	if(key == CODED){
		if(keyCode == UP)
		{
			moveUp = true;
		}
		if(keyCode == DOWN)
		{
			moveDown = true;
		}
		if(keyCode == LEFT)
		{
			moveLeft = true;
		}
		if(keyCode == RIGHT)
		{
			moveRight = true;
		}
		else if(keyCode == SHIFT){
			shift = true;
		}
	}

	//letters
	if(key == '1'){
		speed = (shift ? 1 : 1) * speedIncreaseIncrement;
	}
	if(key == '2'){
		speed = (shift ? 2 : 2) * speedIncreaseIncrement;
	}
	if(key == '3'){
		speed = (shift ? 3 : 3) * speedIncreaseIncrement;
	}
	if(key == '4'){
		speed = (shift ? 4 : 4) * speedIncreaseIncrement;
	}
	if(key == '5'){
		speed = (shift ? 5 : 5) * speedIncreaseIncrement;
	}
	if(key == '6'){
		speed = (shift ? 6 : 6) * speedIncreaseIncrement;
	}
	if(key == '7'){
		speed = (shift ? 7 : 7) * speedIncreaseIncrement;
	}
	if(key == '8'){
		speed = (shift ? 8 : 8) * speedIncreaseIncrement;
	}
	if(key == '9'){
		speed = (shift ? 9 : 9) * speedIncreaseIncrement;
	}
	if(key == '0'){
		speed = (shift ? 10 : 10) * speedIncreaseIncrement;
	}
	if(key == 'm'){
		speed = (shift ? 20 : 20) * speedIncreaseIncrement;
	}

	// Space bar
	if(key == 32){
		pauseSimulation = !pauseSimulation;
	}
}

void keyReleased(){
	if(key == CODED){
		if(keyCode == UP)
		{
			moveUp = false;
		}
		if(keyCode == DOWN)
		{
			moveDown = false;
		}
		if(keyCode == LEFT)
		{
			moveLeft = false;
		}
		if(keyCode == RIGHT)
		{
			moveRight = false;
		}
	}
}

void mousePressed(){
	oldMousePos = new PVector(mouseX, mouseY);
}

void mouseReleased(){
	print("Clicked " + mouseX + ":" + mouseY + " -- "+(mouseX/cellSize)+":"+mouseY/cellSize+"\n");
	try{
		if(!cells[mouseX/cellSize][mouseY/cellSize]._isAlive){
			cells[mouseX/cellSize][mouseY/cellSize].die();
		}
		else{
			cells[mouseX/cellSize][mouseY/cellSize].resurrect();
		}
	}
	catch(Exception e){
		print(e + " at ["+mouseX/cellSize+","+mouseY/cellSize+"]\n");
	}

	if(oldMousePos != null){
		oldMousePos = null;
	}
}

void mouseWheel(MouseEvent event) {
  scrollWheel = event.getCount();
  //println(e + "\n");
}
