
boolean moveUpP2;
boolean moveDownP2;

void keyReleased(){

	//keyCodes
	boolean shift = false;

	if(key == CODED){
		if(keyCode == UP)
		{
			moveUpP2 = true;
		}
		else if(keyCode == DOWN)
		{
			moveDownP2 = true;
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


	if(key == 32){
		pauseSimulation = !pauseSimulation;
	}
}

void mouseReleased(){
	try{
		if(!cells[mouseX/cellSize][mouseY/cellSize]._isAlive){
			cells[mouseX/cellSize][mouseY/cellSize]._resurrecting = true;
		}
		else{
			cells[mouseX/cellSize][mouseY/cellSize]._dying = true;
		}
	}
	catch(Exception e){
		print(e + " at ["+mouseX/cellSize+","+mouseY/cellSize+"]\n");
	}
}
