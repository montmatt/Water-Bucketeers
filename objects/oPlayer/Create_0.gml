is_parent = true;
SetCharge("3");

function switchSprite(){
	switch(GetCharge()){
		case 0:
			sprite_index = sPlayer;
			break;
		case 1:
			sprite_index = sLow;
			break;
		case 2:
			sprite_index = sMedium;
			break;
		case 3:
			sprite_index = sFull;
			break;
	}
}