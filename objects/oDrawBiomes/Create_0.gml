var lay_id = layer_get_id("BiomeTiles");
var map_id = layer_tilemap_get_id(lay_id);

hcells = room_width / 16;
vcells = room_height / 16;

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
