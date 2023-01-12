/// @desc add state functions here

state_checking = function() {
	//select machine
	if (place_meeting(x, y + machine_range, obj_player) and keyboard_check_pressed(vk_space)) {
		
		//check if other machines are making pie
		
		var others_making = false;
		
		with (obj_piemachine) {
			if (state == state_choosing) others_making = true;
		}
		
		if (others_making = false) {
			state = state_choosing;
			global.using_escape = true;
			//show_debug_message("machine switched to making pie");
			exit; //for this step - prevents it from skipping over next state
		}
	
	}
}

state_choosing = function() {
	if (place_meeting(x, y + machine_range, obj_player)) {
		// make player transparent if state hasnt changed and player is near
		obj_player.alpha = p_alpha;
		
		//deselect machine if pressed escape
		if (keyboard_check_pressed(vk_escape)) {	
			//show_debug_message("machine deselected");
			state = state_checking;
			global.using_escape = false;
		}
	
		if (mouse_wheel_up() or keyboard_check_pressed(vk_up)) {
			pie_scroll += 1;
			if (pie_scroll >= tiermaster.pielist_height) { pie_scroll = 0; }
		
		} else if (mouse_wheel_down() or keyboard_check_pressed(vk_down)) {
			pie_scroll -= 1;
			if (pie_scroll < 0) { pie_scroll = tiermaster.pielist_height - 1; }
		
		}
	
		if (keyboard_check_pressed(vk_space) or mouse_check_button_pressed(mb_left)) {
			baking_done = base_cooking_time + ((base_cooking_time/tiermaster.max_tier) * (oven_tier - 1));
			state = state_baking;
			pie_baking = pie_scroll;
		
			//show_debug_message("pie chosen");
		
		}
	
		
	
	}
}
	
state_baking = function() {
	
	timer += 1;
	
	if (timer/room_speed >= baking_done) {
		
		state = state_done;
		timer = 0;
		//show_debug_message("pie done");
		
	}
	
}

state_done = function() {
	
	//pie is picked up
	if (place_meeting(x, y + machine_range, obj_player) and keyboard_check_pressed(vk_space)) {
		
		//check if pie is being held by player
		var dd = obj_player.ds_pie_carry;
		var len = ds_list_size(dd);
		
		// player is holding pie
		if (len < obj_player.max_pie_carry) {
		
			//create pie
			var pie_inst = instance_create_depth(obj_player.x, obj_player.y, -200, obj_pie);
			
			// assign variables to pie
			with (pie_inst) {
				picked_up = true;
				pie_type = other.pie_baking;
				draw_using_depth = false;
				visible = true;
			}
			
			// add pie to list
			ds_list_add(dd, pie_inst);
			
			// reset state and variables for oven
			state = state_checking;
			pie_scroll = 0;
			
		} else {
			// replace topmost pie with one on stove
			// do nothing for now
			
			//var old_pie = dd[| len - 1];
			//ds_list_replace(dd, len - 1, pie_inst);
			
			//// reset variables for old pie
			//with (old_pie) {
				
				
			//}
		}
		
		

		
	}
}
	
	