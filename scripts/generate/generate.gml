function generate() {
	for (var i = 0; i < width; i++) {
		for (var j = 0; j < height; j++) {
			var zz = get_perlin_noise_2D(i, j, 100);
			grid[# i, j] = zz;
		}
	}
}