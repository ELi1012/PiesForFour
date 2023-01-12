if (global.game_pause) exit;



if (mstate = mstate_checking) {
	
	//select machine
	if (place_meeting(x, y + machine_range, obj_player) and keyboard_check_pressed(vk_space)) {
		
		//check if other machines are making pie
		
		others_making = false;
		
		with (obj_piemachine) {
			if (mstate = mstate_choosing) other.others_making = true;
			
		}
		
		if (others_making = false) {
			mstate = mstate_choosing;
			//show_debug_message("machine switched to making pie");
			exit; //for this step - prevents it from skipping over next state
		}// else show_debug_message("other machine making pie");
	
	}
}

if (mstate = mstate_choosing) { //only one machine in this state at a time
	
	//deselect machine if pressed escape
	if (keyboard_check_pressed(vk_escape)) {	
		//show_debug_message("machine deselected");
		
		mstate = mstate_checking;
		
	}
	
	if (mouse_wheel_up()) {
		pie_scroll += 1;
		if (pie_scroll >= tiermaster.pielist_height) { pie_scroll = 0; }
		
	} else if (mouse_wheel_down()) {
		pie_scroll -= 1;
		if (pie_scroll < 0) { pie_scroll = tiermaster.pielist_height - 1; }
		
	}
	
	if (keyboard_check_pressed(vk_space)) {
		making_done = base_cooking_time + ((base_cooking_time/tiermaster.max_tier) * (oven_tier - 1));
		mstate = mstate_baking
		pie_making = pie_scroll;
		
		//show_debug_message("pie chosen");
		
	}
}

if (mstate = mstate_baking) {
	
	making_timer += 1;
	
	if (making_timer/room_speed >= making_done) {
		var piex = x + mmiddlex - pie_middle;
		var piey = y - mmiddley - pie_middle;
		
		//create pie
		pie_inst = instance_create_depth(piex, piey, -200, obj_pie);
		pie_inst.pie_type = pie_making;
		pie_inst.oven_tier = oven_tier;
		
		mstate = mstate_done;
		making_timer = 0;
		pie_on_stove = true;
		//show_debug_message("pie done");
		
	}
	
}

if (mstate = mstate_done) {
	
	//pie is picked up
	if (place_meeting(x, y + machine_range, obj_player) and keyboard_check_pressed(vk_space)) {
		
		//check if pie is being held by player
		var opie = obj_player.pie_selected
		if (opie != -1) {
			opie.y = y - 2;
			//show_debug_message("selected pie moved");
			opie.is_selected = false;
			obj_player.pie_selected = -1;
			
		}
		
		obj_pie.is_selected = false;
		pie_inst.is_selected = true;
		obj_player.pie_selected = pie_inst;
		
		mstate = mstate_checking;
		pie_scroll = 0;
		
	}
}









