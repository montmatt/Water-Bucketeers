randomize();
seed = round(random_range(1000000, 10000000));
	
block_size = 40; // do not go below 4 (very slow)
	
width = floor(room_width / block_size);
height = floor(room_height / block_size);
	
grid = ds_grid_create(width, height);

generate();