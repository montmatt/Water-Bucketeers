function random_seed(range, index_x, index_y) {
	var num = 0;
	
	switch (argument_count) {
		case 2:
			num = index_x;
			break;
		case 3:
			num = index_x + index_y * 65536;
			break;
	}
	
	var seed = obj_generator.seed + num;
	random_set_seed(seed);
	rand = irandom_range(0, range);
	
	return round(rand);
}