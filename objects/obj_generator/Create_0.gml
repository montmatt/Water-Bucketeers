// =================================================================
// CREATE EVENT for obj_generator
// =================================================================

// -----------------------------------------------------------------
// 1. INITIALIZE VARIABLES & DATA STRUCTURES
// -----------------------------------------------------------------
show_debug_message("Generator starting...");

width = 40;
height = 40;
seed = get_timer(); 

// Data Grids
grid = ds_grid_create(width, height);          // Stores raw Perlin noise values
terrain_grid = ds_grid_create(width, height);   // Stores the final BASE terrain type (Water, Grass, Snow)

// Tilemap
var layer_id = layer_get_id("TerrainTiles");
var tilemap_id = layer_tilemap_get_id(layer_id);

// Base Tile Macros (Full, non-transition tiles)
#macro TILE_WATER 1
#macro TILE_GRASS 14
#macro TILE_SNOW 27

// Data Maps for Autotiling
grass_water_map = ds_map_create();
grass_snow_map = ds_map_create();


// -----------------------------------------------------------------
// 2. DEFINE HELPER FUNCTIONS (The Generator's "Brain")
// -----------------------------------------------------------------

// --- Noise Generation Functions ---
function random_seed(range, index_x, index_y) {
    var num = 0;
    switch (argument_count) {
        case 2: num = index_x; break;
        case 3: num = index_x + index_y * 65536; break;
    }
    var _seed = obj_generator.seed + num;
    random_set_seed(_seed);
    return round(irandom_range(0, range));
}

function get_perlin_noise_2D(xx, yy, range) {
    var chunk_size = 24;
    var noise = 0;
    while (chunk_size > 0) {
        var index_x = xx div chunk_size;
        var index_y = yy div chunk_size;
        var t_x = (xx % chunk_size) / chunk_size;
        var t_y = (yy % chunk_size) / chunk_size;
        
        var r_00 = random_seed(range, index_x,     index_y);
        var r_01 = random_seed(range, index_x,     index_y + 1);
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

// --- Terrain Population Functions ---
function generate_noise_grid() {
    for (var i = 0; i < width; i++) {
        for (var j = 0; j < height; j++) {
            var zz = get_perlin_noise_2D(i, j, 100);
            grid[# i, j] = zz;
        }
    }
}

function populate_base_terrain_grid() {
    var water_level = 85;
    var land_level = 132;
    for (var i = 0; i < width; i++) {
        for (var j = 0; j < height; j++) {
            var zz = grid[# i, j];
            var tile_type = TILE_GRASS; // Default
            if (zz < water_level) {
                tile_type = TILE_WATER;
            } else if (zz >= land_level) {
                tile_type = TILE_SNOW;
            }
            terrain_grid[# i, j] = tile_type;
        }
    }
}

// --- Autotiling Functions ---
function calculate_tile_mask(xx, yy, a_type, b_type) {
    var mask = 0;
    // N, E, S, W
    if (yy > 0 && terrain_grid[# xx, yy - 1] == b_type) mask |= 1;
    if (xx < width - 1 && terrain_grid[# xx + 1, yy] == b_type) mask |= 2;
    if (yy < height - 1 && terrain_grid[# xx, yy + 1] == b_type) mask |= 4;
    if (xx > 0 && terrain_grid[# xx - 1, yy] == b_type) mask |= 8;
    return mask;
}


// -----------------------------------------------------------------
// 3. EXECUTE THE GENERATION PROCESS
// -----------------------------------------------------------------

// Step A: Populate the Autotile Maps with your specific tile indices
#region "Populate Tile Maps"
grass_water_map[? 0]  = TILE_GRASS;
grass_water_map[? 1]  = 12; // Top grass, bottom water
grass_water_map[? 2]  = 10; // Left grass, right water
grass_water_map[? 3]  = 6;  // Grass with bottom-right water
grass_water_map[? 4]  = 13; // Bottom grass, top water
grass_water_map[? 5]  = 1;  // Special case, becomes full water
grass_water_map[? 6]  = 7;  // Grass with bottom-left water
grass_water_map[? 7]  = 3;  // Water with top-left grass
grass_water_map[? 8]  = 11; // Right grass, left water
grass_water_map[? 9]  = 8;  // Grass with top-left water
grass_water_map[? 10] = 1;  // Special case, becomes full water
grass_water_map[? 11] = 4;  // Water with top-right grass
grass_water_map[? 12] = 9;  // Grass with top-right water
grass_water_map[? 13] = 5;  // Water with bottom-right grass
grass_water_map[? 14] = 2;  // Water with bottom-left grass
grass_water_map[? 15] = TILE_WATER;

grass_snow_map[? 0]  = TILE_GRASS;
grass_snow_map[? 1]  = 18; // Top snow, bottom grass
grass_snow_map[? 2]  = 16; // Left grass, right snow
grass_snow_map[? 3]  = 19; // Grass with bottom-right snow
grass_snow_map[? 4]  = 17; // Top grass, bottom snow
grass_snow_map[? 5]  = 27; // Special case, becomes full snow
grass_snow_map[? 6]  = 20; // Grass with bottom-left snow
grass_snow_map[? 7]  = 24; // Snow with bottom-left grass
grass_snow_map[? 8]  = 15; // Left snow, right grass
grass_snow_map[? 9]  = 21; // Grass with top-left snow
grass_snow_map[? 10] = 27; // Special case, becomes full snow
grass_snow_map[? 11] = 25; // Snow with top-left grass
grass_snow_map[? 12] = 22; // Grass with top-right snow
grass_snow_map[? 13] = 26; // Snow with top-right grass
grass_snow_map[? 14] = 23; // Snow with bottom-right grass
grass_snow_map[? 15] = TILE_SNOW;
#endregion

// Step B: Generate the raw noise data
generate_noise_grid();

// Step C: Convert noise data into simple terrain types
populate_base_terrain_grid();

// Step D: Loop through the terrain grid, calculate masks, and place the final tiles
for (var i = 0; i < width; i++) {
    for (var j = 0; j < height; j++) {
        
        var my_type = terrain_grid[# i, j];
        var final_tile = my_type;

        switch (my_type) {
            case TILE_GRASS:
                var mask_w = calculate_tile_mask(i, j, TILE_GRASS, TILE_WATER);
                if (mask_w > 0) {
                    final_tile = grass_water_map[? mask_w];
                } else {
                    var mask_s = calculate_tile_mask(i, j, TILE_GRASS, TILE_SNOW);
                    if (mask_s > 0) {
                        final_tile = grass_snow_map[? mask_s];
                    }
                }
                break;
            // You can add cases for TILE_WATER and TILE_SNOW to handle their transitions too
            // For now, they will just place their base tile.
        }

        tilemap_set(tilemap_id, final_tile, i, j);
    }
}

show_debug_message("Generator finished.");