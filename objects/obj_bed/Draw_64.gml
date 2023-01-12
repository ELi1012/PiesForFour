if (might_sleep) {
	
	
	draw_text(300, gui_height - 300, "sleep?");
	draw_text(500, gui_height - 200, "yes");
	draw_text(500, gui_height - 100, "no");
	
	var liney = gui_height - 200 + (100 * sleep_option);
	
	draw_line(450, liney, 470, liney);
	
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



