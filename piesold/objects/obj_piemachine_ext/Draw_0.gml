

var spr_pp = tiermaster.pie_sprite;
var spr_pplen = 4;


draw_sprite(spr_piemachine_ext, oven_tier - 1, x, y);

if (lower_mstate = mstate_choosing) {
	var piex = x + mmiddlex - pie_middle;
	var piey = y - machine_lower_y - mmiddley - pie_middle;
	
	var pie_xx = pie_scroll mod spr_pplen;
	var pie_yy = pie_scroll div spr_pplen;
	
	
	draw_sprite_part(spr_pp, 0, pie_xx*pie_size, pie_yy*pie_size, pie_size, pie_size, 
		piex, piey);
		
	//draw_sprite_part_ext(spr_pies, 0, pie_scroll*pie_size, 0, pie_size, pie_size, piex, piey, 
	//	pie_scale, pie_scale, c_white, 1);
	
	
} else if (lower_mstate = mstate_baking) {
	
	var piex = x + mmiddlex - pie_middle;
	var piey = y - machine_lower_y - mmiddley - pie_middle;
	
	var pie_xx = lower_piemaking mod spr_pplen;
	var pie_yy = lower_piemaking div spr_pplen;
	
	draw_sprite_part(spr_pp, 0, pie_xx*pie_size, pie_yy*pie_size, pie_size, pie_size, 
		piex, piey);
	
	draw_sprite(spr_glow, 0, piex, piey + 20);
	
	
}

if (upper_mstate = mstate_choosing) {
	
	var piex = x + mmiddlex - pie_middle;
	var piey = y - machine_upper_y - mmiddley - pie_middle;
	
	var pie_xx = pie_scroll mod spr_pplen;
	var pie_yy = pie_scroll div spr_pplen;
	
	
	draw_sprite_part(spr_pp, 0, pie_xx*pie_size, pie_yy*pie_size, pie_size, pie_size, 
		piex, piey);
		
	//draw_sprite_part_ext(spr_pies, 0, pie_scroll*pie_size, 0, pie_size, pie_size, piex, piey, 
	//	pie_scale, pie_scale, c_white, 1);
	
	
} else if (upper_mstate = mstate_baking) {
	
	var piex = x + mmiddlex - pie_middle;
	var piey = y - machine_upper_y - mmiddley - pie_middle;
	
	var pie_xx = upper_piemaking mod spr_pplen;
	var pie_yy = upper_piemaking div spr_pplen;
	
	draw_sprite_part(spr_pp, 0, pie_xx*pie_size, pie_yy*pie_size, pie_size, pie_size, 
		piex, piey);
	
	draw_sprite(spr_glow, 0, piex, piey + 20);
}

if (lower_mstate == mstate_done) {
	if (instance_exists(lower_pie_inst)) with (lower_pie_inst) event_perform(ev_draw, 0);
}

if (upper_mstate == mstate_done) {
	if (instance_exists(upper_pie_inst)) with (upper_pie_inst) event_perform(ev_draw, 0);
}

if (place_meeting(x, y + machine_range, obj_player)) {
	
	if (lower_mstate != mstate_baking or upper_mstate != mstate_baking) {
		draw_set_color(c_white);
		draw_set_alpha(0.4);
		
		var rect_upper = m_height * machine_scroll;
		var rect_lower = rect_upper - m_height;
		
		if (keyboard_check(vk_shift)) {
			rect_upper = m_height * 2;
			rect_lower = 0;
		}
		
		
		draw_rectangle(x, y - rect_upper, x + m_width, y - rect_lower, false);
		
		draw_set_alpha(1);
		
	}
	
	
	
}






