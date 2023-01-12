if (global.game_pause) {
	
	var pressede = true;
	var view_t = true;
	
	if (pressed_exit) {
		if (mouse_check_button_pressed(mb_left) or keyboard_check_pressed(vk_escape)) pressede = false;
		else if (keyboard_check_pressed(vk_enter)) game_end();
		
	} else if (view_tutorial) {
		var mx = device_mouse_x_to_gui(0);
		var my = device_mouse_y_to_gui(0);
		
		if (mouse_check_button_pressed(mb_left)) {
			if (point_in_rectangle(mx, my, vt_backx, vt_backy, vt_backx + vt_backwidth, vt_backy + vt_backheight)) {
				vt_inc += 1;
				if (vt_inc >= vt_length) vt_inc = 0;
				
			} else view_t = false;
			
		} else if (keyboard_check_pressed(vk_escape)) view_t = false;
	}
	
	
	if (mouse_check_button_pressed(mb_left)) {
		var mx = device_mouse_x_to_gui(0);
		var my = device_mouse_y_to_gui(0);
		
		//exit game
		if (point_in_rectangle(mx, my, press_exitx, press_exity, press_exitx + press_exit_width, 
			press_exity + press_exit_height) and !pressed_exit and !view_tutorial) {
			pressed_exit = true;
			global.using_escape = true;
		} else if (point_in_rectangle(mx, my, vt_x, vt_y, vt_x + vt_width, vt_y + vt_height) and !view_tutorial) {
			view_tutorial = true;
			pause_overlay = true;
			global.using_escape = true;
		}
	}
	
	
	if (!pressede or !view_t) {
		global.using_escape = false;
		pressed_exit = false;
		view_tutorial = false;
		pause_overlay = false;
	}
	
	
}