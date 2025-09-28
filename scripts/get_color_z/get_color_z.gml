function get_color_z(zz) {
    var r = 0, g = 0, b = 0;
    var water_level = 60;
    var land_level = 140;
    var volcano_level = 150; // NEW: Threshold for volcanoes to appear

    if (zz < water_level) {
        // Water: deep blue to light blue (No change)
        b = 150 + (zz / water_level) * 105;
        g = 50 + (zz / water_level) * 30;
    } else if (zz < land_level) {
        // Land: green range (No change)
        g = 100 + ((zz - water_level) / (land_level - water_level)) * 155;
        r = 50 + ((zz - water_level) / (land_level - water_level)) * 30;
    } else if (zz < volcano_level) { // MODIFIED: This is now the mountain range
        // Hills/mountains: gray/white
        // The normalization now goes from land_level to volcano_level
        r = 210 + ((zz - land_level) / (volcano_level - land_level)) * 35;
        g = r;
        b = r;
    } else { // NEW: This block handles everything above volcano_level
        // Volcano: dark volcanic rock transitioning to red/orange lava
        var lava_point = 215; // The elevation for the brightest lava color
        
        // Calculate a 0-1 ratio of how far into the volcano zone we are
        var ratio = (zz - volcano_level) / (lava_point - volcano_level);
        
        // Let's create a gradient from dark rock to lava
        // Base color (dark gray volcanic rock)
        var base_r = 80, base_g = 75, base_b = 85;
        // Lava color (bright orange/red)
        var lava_r = 255, lava_g = 90, lava_b = 10;
        
        // Interpolate between the rock and lava colors based on the ratio
        r = base_r + (lava_r - base_r) * ratio;
        g = base_g + (lava_g - base_g) * ratio;
        b = base_b + (lava_b - base_b) * ratio;
    }

    // Clamp values (No change)
    r = clamp(r, 0, 255);
    g = clamp(g, 0, 255);
    b = clamp(b, 0, 255);

    return make_color_rgb(r, g, b);
}