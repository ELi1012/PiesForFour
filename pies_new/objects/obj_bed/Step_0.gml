

if (daycycle.seconds >= 6.5 * 3600) exit;


if (keyboard_check_pressed(vk_space) and !sleeping and !might_sleep) {
	if (place_meeting(x + bed_range, y, obj_player) or place_meeting(x - bed_range, y, obj_player)) {
		might_sleep = true;
		visible = true;
		exit;
	}
}

if (might_sleep) {
	
	if (mouse_wheel_up() or keyboard_check_pressed(vk_up)) sleep_option = !sleep_option;
	else if (mouse_wheel_down() or keyboard_check_pressed(vk_down)) sleep_option = !sleep_option;
	
	
	if (keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_enter)) {
		might_sleep = false;
		
		if (sleep_option = true) {
			sleeping = true; 
			global.no_moving = true;
			
		} else visible = false;
	}
}





if (sleeping) {
	sleep_counter += 1;
	
	//done sleeping - is morning
	//if (sleep_counter/room_speed >= 6 + sleep_duration) 
	
	if (is_morning) {
		is_morning = false;
		global.no_moving = false;
		
		with (daycycle) {
			seconds = begin_day * 3600;
			minutes = seconds/60;
			hours	= minutes/60;
			day += 1;
			
		}
		
		//update appearance if using pill
		if (obj_stats.player_pill != spr_player) {
			obj_player.spr_pill = obj_stats.player_pill;
			var oops = irandom_range(1, 250);
			if (oops == 250) {
				obj_player.spr_pill = spr_sprike;
				obj_stats.player_pill = spr_sprike;
			}
			
		}
		
		with (obj_tilesetter) {
			bg_tier = obj_stats.dining_bg;
			bg_tier_kitchen = obj_stats.kitchen_bg;
		}
		
		with (saver) {
			if (saving_on) save_data();
		}
		
		sleep_alpha = 1;
		sleep_counter = 0;
		
		sleeping = false;
		visible = false;
		
		
	}
}













