if(GetCharge() > 0){
	var hits = ds_list_create();

	var count = instance_place_list(oPlayerInteract.x, oPlayerInteract.y,oHouse, hits, true);
	
	if(count > 0) {
		instance_destroy(hits[| 0]);
		ChangeHouse("1");
		ChangeCharge("1");
	} else{
		checkWater();
	}
	
	ds_list_destroy(hits);

} else{
	checkWater();
}


function checkWater(){
	var collisionList = []
	
	array_push(collisionList, tilemap_get_at_pixel(map_id,x ,y));
	array_push(collisionList, tilemap_get_at_pixel(map_id, x + floor(h / 2) ,y));
	array_push(collisionList, tilemap_get_at_pixel(map_id,x + ceil(h / 2) ,y));
	array_push(collisionList, tilemap_get_at_pixel(map_id,x + w ,y));
	array_push(collisionList, tilemap_get_at_pixel(map_id,x,y + floor(h / 2)));
	array_push(collisionList, tilemap_get_at_pixel(map_id,x,y + ceil(h / 2)));
	array_push(collisionList, tilemap_get_at_pixel(map_id,x,y + h));
	array_push(collisionList, tilemap_get_at_pixel(map_id,x + floor(h /2),y + h));
	array_push(collisionList, tilemap_get_at_pixel(map_id,x + ceil(h /2),y + h));
	array_push(collisionList, tilemap_get_at_pixel(map_id,x + h,y + h));
	array_push(collisionList, tilemap_get_at_pixel(map_id,x + h, y + floor(h / 2)));
	array_push(collisionList, tilemap_get_at_pixel(map_id,x + h, y + ceil(h / 2)));
	array_push(collisionList, tilemap_get_at_pixel(map_id,x + ceil(h / 2), y + ceil(h / 2)));
	array_push(collisionList, tilemap_get_at_pixel(map_id,x + floor(h / 2), y + floor(h / 2)));

	for(var i = 0; i < array_length(collisionList); i++){
		if(collisionList[i] == 2){
			SetCharge("3");
			break;
		}
	}
}
