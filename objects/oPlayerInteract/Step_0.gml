// Inherit the parent event
event_inherited();

var foundFire = false;
var foundSnow = false;
var collisionList = []

array_push(collisionList, tilemap_get_at_pixel(map_id,x + ceil(h / 2), y + ceil(h / 2)));
array_push(collisionList, tilemap_get_at_pixel(map_id,x + floor(h / 2), y + floor(h / 2)));

for(var i = 0; i < array_length(collisionList); i++){
		if(collisionList[i] == 4){
			is_burning = true;
			foundFire = true;
		}
		if(collisionList[i] == 3){
			is_frozen = true;
			foundFire = false;
			foundSnow = true;
			break;
		}
}

if(!foundFire){
	is_burning = false;
	timerFire = initial_fire_timer * room_speed;
}

if(foundSnow){
	timerSnow = initial_snow_timer * room_speed;
	show_debug_message("InSnow!");
}

if(!foundSnow && is_frozen){
	timerSnow--;
	if(timerSnow <= 0){
			is_frozen = false;
			timerSnow = initial_snow_timer * room_speed;
			show_debug_message("OutSnow!");
	}
}

if (timerFire > 0 && is_burning) {
    timerFire--;
    if (timerFire <= 0) {
        //show_debug_message("Timer finished!");
		ChangeCharge(1);
		timerFire = initial_fire_timer * room_speed;
    }
}

show_debug_message(is_frozen);

if(GetCharge() <= 0){
	timerFire = initial_fire_timer * room_speed;
}