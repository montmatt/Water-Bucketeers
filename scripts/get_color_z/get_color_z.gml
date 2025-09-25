function get_color_z(zz) {
	var r = 0, g = 0, b = 0;
    var water_level = 85;
    var land_level = 132;

    if (zz < water_level) {
        // Water: deep blue to light blue
        b = 150 + (zz / water_level) * 105;
        g = 50 + (zz / water_level) * 30;
    } else if (zz < land_level) {
        // Land: green range
        g = 100 + ((zz - water_level) / (land_level - water_level)) * 155;
        r = 50 + ((zz - water_level) / (land_level - water_level)) * 30;
    } else {
        // Hills/mountains: gray/white
        r = 210 + ((zz - land_level) / (200 - land_level)) * 35;
        g = r;
        b = r;
    }

    // Clamp values
    r = clamp(r, 0, 255);
    g = clamp(g, 0, 255);
    b = clamp(b, 0, 255);

    return make_color_rgb(r, g, b);
}