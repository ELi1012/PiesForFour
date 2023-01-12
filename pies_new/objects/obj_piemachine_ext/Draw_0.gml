// draw base oven
// DO NOT PUT IN DRAW_OVEN_PIE_EXT; WILL DRAW OVER UPPER SECTION
draw_sprite(spr_piemachine_ext, type_index, x, y);


// draw section specific parts
draw_oven_pie_ext(oven_section.upper_section);
draw_oven_pie_ext(oven_section.lower_section);

