function get_perlin_noise_2D(xx, yy, range) {
	var chunk_size = 9;
	var noise = 0;
	
	while (chunk_size > 0) {
		var index_x = xx div chunk_size;
		var index_y = yy div chunk_size;
		var t_x = (xx % chunk_size) / chunk_size;
		var t_y = (yy % chunk_size) / chunk_size;
		
		var r_00 = random_seed(range, index_x, index_y);
		var r_01 = random_seed(range, index_x, index_y + 1);
		var r_10 = random_seed(range, index_x + 1, index_y);
		var r_11 = random_seed(range, index_x + 1, index_y + 1);
		
		var r_0 = lerp(r_00, r_01, t_y);
		var r_1 = lerp(r_10, r_11, t_y);
		noise += lerp(r_0, r_1, t_x);
		
		chunk_size = chunk_size div 2;
		range = max(1, range div 2);
	}
	
	return round(noise);
}