if (global.game_pause) exit;

if (might_sleep) {
	var cursor_position = 0;
	if (!sleep_option) cursor_position = 1;
	
	var _margin = 50;
	var _height = 200;
	var _top = gui_height - _height - _margin;
	
	draw_set_alpha(0.5);
	draw_rectangle(_margin, _top, gui_width - _margin, _top + _height, false);
	draw_set_alpha(1);
	
	var text_margin = _margin + 20;
	draw_text(text_margin, _top + 20, "sleep?");
	draw_text(text_margin + 60, _top + 100, "yes");
	draw_text(text_margin + 60, _top + 150, "no");
	
	var liney = _top + 100 + (50 * cursor_position);
	
	draw_line(_margin + 30, liney, _margin + 50, liney);
	
}

if (sleeping) {
	var slp_ss = sleep_counter/room_speed;
	var cb = c_black;
	
	
	//draw black screen
	if (slp_ss >= 2 and slp_ss < 6) {
		draw_rectangle_color(0, 0, gui_width, gui_height, cb, cb, cb, cb, false);
	}
	
	//fade in
	else if (slp_ss >= 6 and slp_ss < 6 + sleep_duration) {
		is_morning = true;
		
		draw_set_alpha(sleep_alpha);
		draw_rectangle_color(0, 0, gui_width, gui_height, cb, cb, cb, cb, false);
		draw_set_alpha(1);
		
		sleep_alpha -= alpha_inc;
		
	}
}



