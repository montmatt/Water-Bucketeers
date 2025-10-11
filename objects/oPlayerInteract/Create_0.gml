var lay_id = layer_get_id("BiomeTiles");
map_id = layer_tilemap_get_id(lay_id);
h = sprite_height
w = sprite_width
is_parent = false; 
is_burning = false;
is_frozen = false;
timerFire = initial_fire_timer * room_speed;
timerSnow = initial_snow_timer * room_speed;

