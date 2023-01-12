/// @description state functions

function switch_phase(_next_phase) {
	switch (_next_phase) {
		case phase.sunrise:
			// between sunrise and daytime
				opacity_array	= [max_darkness, 0.2];
				colour_array	= [merge_color(c_black, c_navy, 0.5), c_orange];
				current_phase	= phase.sunrise;
				next_phase		= phase.daytime;
				//show_debug_message("phase switched to sunrise");
				break;
				
		case phase.daytime:
			// between daytime and sunset
				opacity_array	= [0.2, 0, 0, 0, 0.2];
				colour_array	= [c_orange, c_orange, c_white, c_orange, c_orange];
				current_phase		= phase.daytime;
				next_phase		= phase.sunset;
				//show_debug_message("phase switched to daytime");
				break;
				
		case phase.sunset:
			// between sunset and night
				opacity_array	= [0.2, max_darkness];
				colour_array = [c_orange, c_navy, merge_color(c_black, c_navy, 0.6)];
				current_phase = phase.sunset;
				next_phase = phase.nighttime;
				//show_debug_message("phase switched to sunset");
				break;
				
		case phase.nighttime:
			// between sunset and night
				opacity_array	= [max_darkness];
				colour_array = [merge_color(c_black, c_navy, 0.3)];
				current_phase = phase.nighttime;
				next_phase = phase.sunrise;
				//show_debug_message("phase switched to nighttime");
				break;
	}
}