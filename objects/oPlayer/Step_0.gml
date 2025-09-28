var mx = 0;
var my = 0;

if(keyboard_check(vk_right)) mx += 1;
if(keyboard_check(vk_left)) mx -= 1;
if(keyboard_check(vk_up)) my -= 1;
if(keyboard_check(vk_down)) my += 1;

if(mx != 0 || my != 0){
	var len = point_distance(0, 0, mx, my);
	mx /= len;
	my /= len;
	
	//Apply movement at constant speed
	x += mx * move_speed;
	y += my * move_speed;
}
//show_debug_message(string(mx) + ", " + string(my));