var hits = ds_list_create();

var count = instance_place_list(oPlayerInteract.x, oPlayerInteract.y,oHouse, hits, true);
	
if(count > 0) instance_destroy(hits[| 0]);
	
ds_list_destroy(hits);
	
