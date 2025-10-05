// =================================================================
// CLEAN UP EVENT for obj_generator
// =================================================================
// Destroy all data structures to prevent memory leaks

ds_grid_destroy(grid);
ds_grid_destroy(terrain_grid);
ds_map_destroy(grass_water_map);
ds_map_destroy(grass_snow_map);

show_debug_message("Generator data structures destroyed.");