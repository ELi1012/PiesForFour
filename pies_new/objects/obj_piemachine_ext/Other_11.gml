/// @desc add state functions here

state_checking = function(_current_oven) {
	// bake a pie in current section of the oven
	// if near the oven and currently highlighting specified oven
	if (keyboard_check_pressed(vk_space) and place_meeting(x, y + machine_range, obj_player) and 
		current_oven == _current_oven) {
		
		//check if other machines are making pie
		var others_making = false;
		
		with (obj_piemachine_ext) {
			var upper_struct = section_array[oven_section.upper_section];
			var lower_struct = section_array[oven_section.lower_section];
			
			if (upper_struct.state == state_choosing or lower_struct.state == state_choosing) {
				others_making = true;
				//show_debug_message("others making");
			}
		}
		
		if (others_making = false and !just_chose) {
			section_array[_current_oven].state = state_choosing;
			global.using_escape = true;
			just_chose = true;
			alarm[0] = 1;
			//show_debug_message("pie chosen; state = state_choosing");
		}
	}
}

state_choosing = function(_current_oven) {
	
	if (place_meeting(x, y + machine_range, obj_player)) {
		// make player transparent if player is near
		obj_player.alpha = p_alpha;
		
		var section = section_array[_current_oven];
		var t = tiermaster.pielist_height
	
		if (current_oven == _current_oven) {
			
			// change pie to bake
			if (!keyboard_check(vk_shift)) {
				with (section) {
					if (mouse_wheel_up() or keyboard_check_pressed(vk_up)) {
						pie_scroll += 1;
						if (pie_scroll >= t) { pie_scroll = 0; }
		
					} else if (mouse_wheel_down() or keyboard_check_pressed(vk_down)) {
						pie_scroll -= 1;
						if (pie_scroll < 0) { pie_scroll = t - 1; }
		
					}
				}
			}
				//deselect machine if pressed escape
			if (keyboard_check_pressed(vk_escape)) {	
				show_debug_message("machine deselected");
				section.state = state_checking;
				global.using_escape = false;
			} 
		
			else if (keyboard_check_pressed(vk_space)) {// or mouse_check_button_pressed(mb_left)) {
				//if (_current_oven == oven_section.upper_section) show_debug_message("baking for upper");
				
				baking_done = base_cooking_time + ((base_cooking_time/4) * (oven_tier - 1));
		
				with (section) {
					state = other.state_baking;
					pie_baking = pie_scroll;
				}
		
				//show_debug_message("pie baking");
		
			}
	

		}
	}
}
	
state_baking = function(_current_oven) {
	var section = section_array[_current_oven];
	
		section.timer += 1;
	
		if (section.timer/room_speed >= baking_done) {
			
			// reset variables
			section.state = state_done;
			section.timer = 0;
			
			//show_debug_message("pie finished baking");
		
		}
}

state_done = function(_current_oven) {
	var section = section_array[_current_oven];
	
	// pick up pie if pie is from current oven
	if (_current_oven == current_oven and keyboard_check_pressed(vk_space) and
		place_meeting(x, y + machine_range, obj_player)) {
		
		#region player interacts with pie
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
					pie_type = section.pie_baking;
					draw_using_depth = false;
					visible = true;
				}
				
				// add pie to list
				ds_list_add(dd, pie_inst);
				
				// reset variables for struct
				with (section) {
					state = other.state_checking;
					pie_scroll = 0;
				}
			
			} else {
				// replace topmost pie with one on stove
				// do nothing for now
				
				
				
				//var old_pie = dd[| len - 1];
				//ds_list_replace(dd, len - 1, pie_inst);
			
				//// reset variables for old pie
				//with (old_pie) {
				
				
				//}
			}
			
					
		#endregion
		
		
	}
}
	
