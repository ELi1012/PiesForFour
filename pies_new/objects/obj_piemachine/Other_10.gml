/// @desc draw something in daycycle


function draw_oven_pie(_glow = false, cx = 0, cy = 0) {
	
	// state specific drawings are short enough that they can be contained within
	// the same function
	
	// glow = true if function is called from daycycle
	// punches a hole through dark lighting at night
	// if (!glow) draw_function		<-- sprite drawn by function does not need to be seen through darkness
	
	// draw oven base
	draw_sprite(spr_piemachine, type_index, x, y);
	
	var inside_width = sprite_get_width(spr_oven_open);
	var ymargin = 6;
	
	// middle of section relative to room coordinates (does not account for cx, cy)
	var mx = x + mmiddlex;
	var my = y - (m_height/2);
	
	var ix = mx - (inside_width/2) - cx;
	var iy = y - m_height + ymargin - cy;
	
	var piex = mx - pie_middle - cx;
	var piey = my - pie_middle - cy;
	
	var _ox = x - sprite_get_width(spr_oven_arrow) - 6 - cx;
	var _oy =  y - m_height + 8 - cy;
	
	switch (state) {
		case state_checking:
			oven_draw_arrow(true, _ox, _oy);
			break;
		
		case state_choosing:
			oven_draw_arrow(true, _ox, _oy);
			draw_sprite(spr_oven_open, 0, ix, iy);
			if (!_glow) oven_draw_pie(pie_scroll, piex, piey);
			break;
		
		case state_baking:
			oven_draw_arrow(false, _ox, _oy);
			
			if (!_glow) {
				draw_sprite(spr_oven_open, 0, ix, iy);
				oven_draw_pie(pie_baking, piex, piey);
				draw_sprite(spr_oven_glow, 0, ix, iy);
			} else {
				with (daycycle) draw_halo(spr_player_glow, 4, mx, my, cx, cy);
			}
			
			break;
		
		case state_done:
			oven_draw_arrow(true, _ox, _oy);
			draw_sprite(spr_oven_open, 0, ix, iy);
			if (!_glow) oven_draw_pie(pie_baking, piex, piey);
			break
	}
}

function draw_glow(cx, cy) {
	// cx, cy are position of camera in room
	// necessary if drawing to the surface
	// drawing coordinates are given relative to position of surface in room
	
	draw_oven_pie(true, cx, cy);
}