/// @desc draw something in daycycle

// cant be the same as the obj_piemachine function for some reason
function draw_oven_pie_ext(_current_oven, _glow = false, _cx = 0, _cy = 0) {
	// state specific drawings are short enough that they can be contained within
	// the same function
	
	// glow = true if function is called from daycycle
	// punches a hole through dark lighting at night
	// if (!glow) draw_function		<-- sprite drawn by function does not need to be seen through darkness
	
	var section = section_array[_current_oven];		// refers to a struct
	var section_state = section.state;
	var bdist = 0;			// distance of top of section from bottom of oven
	
	if		(_current_oven == oven_section.upper_section) bdist = 2 * section_height;
	else if (_current_oven == oven_section.lower_section) bdist = 1 * section_height;
	
	var inside_width = sprite_get_width(spr_oven_open);
	var ymargin = 6;
	var oven_matching = false;
	if (_current_oven == current_oven) oven_matching = true;
	
	// middle of section relative to room coordinates (does not account for cx, cy)
	var mx = x + mmiddlex;
	var my = y - bdist + (section_height/2);
	
	var ix = mx - (inside_width/2) - _cx;
	var iy = y - bdist + ymargin - _cy;
	
	// y position of pie is relative to top of open oven sprite
	var piex = mx - pie_middle - _cx;
	var piey = my - pie_middle - _cy;
	
	var _ox = x - sprite_get_width(spr_oven_arrow) - 6 - _cx;
	var _oy =  y - bdist + 8 - _cy;
	
	
	switch (section_state) {
		case state_checking:
			oven_draw_arrow(true, _ox, _oy, oven_matching);
			break;
		
		case state_choosing:
			oven_draw_arrow(true, _ox, _oy, oven_matching);
			
			if (!_glow) draw_sprite(spr_oven_open, 0, ix, iy);
			oven_draw_pie(section.pie_scroll, piex, piey);
			break;
		
		case state_baking:
			oven_draw_arrow(false, _ox, _oy, oven_matching);
			
			if (!_glow) {
				draw_sprite(spr_oven_open, 0, ix, iy);
				oven_draw_pie(section.pie_baking, piex, piey);
				draw_sprite(spr_oven_glow, 0, ix, iy);
			} else {
				with (daycycle) draw_halo(spr_player_glow, 4, mx, my, _cx, _cy);
			}
			
			break;
		
		case state_done:
			oven_draw_arrow(true, _ox, _oy, oven_matching);
			
			if (!_glow) draw_sprite(spr_oven_open, 0, ix, iy);
			oven_draw_pie(section.pie_baking, piex, piey);
			break
	}
}

function draw_glow(cx, cy) {
	draw_oven_pie_ext(oven_section.upper_section, true, cx, cy);
	draw_oven_pie_ext(oven_section.lower_section, true, cx, cy);
}