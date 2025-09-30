// Inherit the parent event
event_inherited();

var found = false;
var collisionList = []

array_push(collisionList, tilemap_get_at_pixel(map_id,x + ceil(h / 2), y + ceil(h / 2)));
array_push(collisionList, tilemap_get_at_pixel(map_id,x + floor(h / 2), y + floor(h / 2)));

for(var i = 0; i < array_length(collisionList); i++){
		if(collisionList[i] == 4){
			is_burning = true;
			found = true;
			break;
		}
}

if(!found){
	is_burning = false;
	timer = 3 * room_speed;
}


if (timer > 0 && is_burning) {
    timer--;
    if (timer <= 0) {
        show_debug_message("Timer finished!");
		ChangeCharge(1);
		timer = 3 * room_speed;
    }
}

if(GetCharge() <= 0){
	timer = 3 * room_speed;
}