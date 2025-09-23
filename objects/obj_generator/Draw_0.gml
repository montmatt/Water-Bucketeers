for (var i = 0; i < width; i++) {
	for (var j = 0; j < height; j++) {
		draw_set_color(get_color_z(ds_grid_get(grid, i, j)));
		draw_rectangle(i * block_size, j * block_size, (i + 1) * block_size, (j + 1) * block_size, false);
	}
}