
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(f_debug); // Make sure you have a small font named f_debug, or use another font
draw_set_color(c_white);

// Loop through each cell of the grid
for (var i = 0; i < width; i++) {
    for (var j = 0; j < height; j++) {
        
        // We only care about grass tiles for this debug
        if (terrain_grid[# i, j] == TILE_GRASS) {
        
            // Calculate the mask for this tile, just like in the Create Event
            var mask_w = calculate_tile_mask(i, j, TILE_GRASS, TILE_WATER);
            var mask_s = calculate_tile_mask(i, j, TILE_GRASS, TILE_SNOW);
            
            var text_to_draw = "";
            
            if (mask_w > 0) {
                text_to_draw = "W:" + string(mask_w); // e.g., "W:3"
            } else if (mask_s > 0) {
                text_to_draw = "S:" + string(mask_s); // e.g., "S:12"
            }
            
            if (text_to_draw != "") {
                // Draw the text on the screen at the tile's position
                // Note: Assumes your tile size is 40x40
                var draw_x = i * 40 + 20;
                var draw_y = j * 40 + 20;
                draw_text(draw_x, draw_y, text_to_draw);
            }
        }
    }
}