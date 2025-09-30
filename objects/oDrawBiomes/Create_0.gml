var lay_id = layer_get_id("BiomeTiles");
var map_id = layer_tilemap_get_id(lay_id);

hcells = room_width / 16;
vcells = room_height / 16;

o_grid = array_create(hcells, 0);
house_spawn_list = []

var house_range = house_num / 5;

random_house_num = irandom_range(floor(house_num - house_range), ceil(house_num + house_range));
SetHouse(random_house_num);

for(var xx = 0; xx < hcells; xx++){
	o_grid[xx] = array_create(vcells, 0);
}

for(var yy = 0; yy < vcells; yy++){
	for(var xx = 0; xx < hcells; xx++){
		
		tile = tilemap_get(map_id, xx, yy);
		
		switch(tile){
			case 1:
				a_grid[xx,yy] = 0
				break;
			case 2:
				a_grid[xx,yy] = 1
				break;
			case 3:
				a_grid[xx,yy] = 2
				break;
			case 4:
				a_grid[xx,yy] = 3
				break;
		}
	}
}

totalValidHouse = 0;

for(var xx = 0; xx < array_length(a_grid); xx++){
	for(var yy = 0; yy < array_length(a_grid[xx]); yy++){
		if(o_grid[xx][yy] == 0 && a_grid[xx][yy] != 1){
			totalValidHouse++;
		}
	}
}

for(var i = 0; i < random_house_num; i++){
	array_push(house_spawn_list, irandom_range(0, totalValidHouse - 1));
}

array_sort(house_spawn_list,true);


for(var i = 0; i < random_house_num; i++){
	var currentValidHouse = 0;
	var found = false;
	for(var xx = 0; xx < array_length(a_grid) && !found; xx++){
		for(var yy = 0; yy < array_length(a_grid[xx]); yy++){
			if(o_grid[xx][yy] == 0 && a_grid[xx][yy] != 1){
				if(currentValidHouse == house_spawn_list[i]){
					instance_create_layer(xx * 16 ,yy * 16,"Instances", oHouse);
					found = true;
					break;
				}
				currentValidHouse++;
			}
		}
	}
}

