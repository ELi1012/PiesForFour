
// run states for upper and lower sections of oven

//show_debug_message("------upper section step event");
upper_section.state(oven_section.upper_section);

//show_debug_message("------lower section step event");
lower_section.state(oven_section.lower_section);

// change oven section if holding shift
if (place_meeting(x, y + machine_range, obj_player) and keyboard_check(vk_shift)) {
	// don't change oven if current choosing pie
	if (upper_section.state != state_choosing and lower_section.state != state_choosing) {
		var max_scroll = 1;
		var upp = oven_section.upper_section;
		var downn = oven_section.lower_section;
	
		if (mouse_wheel_up() or keyboard_check_pressed(vk_up)) {
			section_scroll += 1;
			if (section_scroll > max_scroll) { section_scroll = 0; }
		
		} else if (mouse_wheel_down() or keyboard_check_pressed(vk_down)) {
			section_scroll -= 1;
			if (section_scroll < 0) { section_scroll = max_scroll; }
		}
	
		if		(section_scroll == upp) current_oven = upp;
		else if (section_scroll == downn) current_oven = downn;
	}
}