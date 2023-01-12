//if(keyboard_check_pressed(vk_f1)) { game_restart(); }
if(keyboard_check_pressed(vk_f8)) { game_end(); }
if(keyboard_check_pressed(vk_f12)) { debug = !debug; }



if(keyboard_check_pressed(vk_escape)) {
	if (!global.using_escape and pause_state_prev == global.using_escape) {
		global.game_pause = !global.game_pause;
	}
}



pause_state_prev = global.using_escape;