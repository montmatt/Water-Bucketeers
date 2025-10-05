width = 40;
height = 40;
seed = get_timer(); 

// Data Grids
grid = ds_grid_create(width, height);         
terrain_grid = ds_grid_create(width, height);

// Tilemap
var layer_id = layer_get_id("TerrainTiles");
var tilemap_id = layer_tilemap_get_id(layer_id);

// Base Tile Macros
#macro TILE_WATER 1
#macro TILE_GRASS 14
#macro TILE_SNOW 27

// Data Maps for Autotiling
grass_water_map = ds_map_create();
grass_snow_map = ds_map_create();


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




// Step A: Populate the Autotile Maps with your specific tile indices
#region "Populate Tile Maps"

// --- Grass to Water Transitions ---
// Mask value represents which neighbors are WATER
grass_water_map[? 0]  = TILE_GRASS;     // No water neighbors
grass_water_map[? 1]  = 13;             // N is water -> needs top edge water (bottom grass top water)
grass_water_map[? 2]  = 11;             // E is water -> needs right edge water (left water right grass)
grass_water_map[? 3]  = 8;              // N+E is water -> needs top-left grass island (grass with top-left water)
grass_water_map[? 4]  = 12;             // S is water -> needs bottom edge water (top grass bottom water)
grass_water_map[? 5]  = TILE_WATER;     // N+S is water -> pillar of grass becomes full water
grass_water_map[? 6]  = 9;              // E+S is water -> needs top-right grass island (grass with top-right water)
grass_water_map[? 7]  = 4;              // N+E+S is water -> needs top-right grass corner (water with top-right grass)
grass_water_map[? 8]  = 10;             // W is water -> needs left edge water (left side grass right water)
grass_water_map[? 9]  = 7;              // N+W is water -> needs bottom-left grass island (grass with bottom-left water)
grass_water_map[? 10] = TILE_WATER;     // E+W is water -> pillar of grass becomes full water
grass_water_map[? 11] = 2;              // N+E+W is water -> needs bottom-left grass corner (water with bottom-left grass)
grass_water_map[? 12] = 6;              // S+W is water -> needs bottom-right grass island (grass with bottom-right water)
grass_water_map[? 13] = 5;              // N+S+W is water -> needs bottom-right grass corner (water with bottom-right grass)
grass_water_map[? 14] = 3;              // E+S+W is water -> needs top-left grass corner (water with top-left grass)
grass_water_map[? 15] = TILE_WATER;     // All neighbors are water

// --- Grass to Snow Transitions ---
// Mask value represents which neighbors are SNOW
grass_snow_map[? 0]  = TILE_GRASS;      // No snow neighbors
grass_snow_map[? 1]  = 17;              // N is snow -> needs top edge snow (top grass bottom snow)
grass_snow_map[? 2]  = 15;              // E is snow -> needs right edge snow (left snow right grass)
grass_snow_map[? 3]  = 21;              // N+E is snow -> needs top-left grass island (grass with top-left snow)
grass_snow_map[? 4]  = 18;              // S is snow -> needs bottom edge snow (top snow bottom grass)
grass_snow_map[? 5]  = TILE_SNOW;       // N+S is snow -> becomes full snow
grass_snow_map[? 6]  = 22;              // E+S is snow -> needs top-right grass island (grass with top-right snow)
grass_snow_map[? 7]  = 26;              // N+E+S is snow -> needs top-right grass corner (snow with top-right grass)
grass_snow_map[? 8]  = 16;              // W is snow -> needs left edge snow (left grass right snow)
grass_snow_map[? 9]  = 20;              // N+W is snow -> needs bottom-left grass island (grass with bottom-left snow)
grass_snow_map[? 10] = TILE_SNOW;       // E+W is snow -> becomes full snow
grass_snow_map[? 11] = 23;              // N+E+W is snow -> needs bottom-right grass corner (snow with bottom-right grass)
grass_snow_map[? 12] = 19;              // S+W is snow -> needs bottom-right grass island (grass with bottom-right snow)
grass_snow_map[? 13] = 25;              // N+S+W is snow -> needs top-left grass corner (snow with top-left grass)
grass_snow_map[? 14] = 24;              // E+S+W is snow -> needs bottom-left grass corner (snow with bottom-left grass)
grass_snow_map[? 15] = TILE_SNOW;      // All neighbors are snow
#endregion


generate_noise_grid();


populate_base_terrain_grid();

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
        
        }

        tilemap_set(tilemap_id, final_tile, i, j);
    }
}

show_debug_message("Generator finished.");