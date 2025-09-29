if(keyboard_check_pressed(vk_space)){
	var hits = ds_list_create();
	    show_debug_message("SPACE handled by: " + string(object_get_name(object_index)) 
                       + " id=" + string(id));

	var count = instance_place_list(oPlayerInteract.x, oPlayerInteract.y,oHouse, hits, true);
	
	if(count > 0) instance_destroy(hits[| 0]);
	
	ds_list_destroy(hits);
	
}