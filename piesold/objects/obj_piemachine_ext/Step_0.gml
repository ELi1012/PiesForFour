if (global.game_pause) exit;




//shouldnt run if pie has been set to choosing in the same step
if (lower_mstate = mstate_choosing or upper_mstate = mstate_choosing) {
	
	//deselect machine if pressed escape
	if (keyboard_check_pressed(vk_escape)) {
		//show_debug_message("machine deselected");
		//mstate = mstate_checking;
		global.using_escape = false;
		show_debug_message("escape false");
		
		if (lower_mstate = mstate_choosing) {
			lower_mstate = mstate_checking;
			//show_debug_message("lower region deselected");
				
		}
		
		if (upper_mstate = mstate_choosing) {
			upper_mstate = mstate_checking;
			//show_debug_message("upper region deselected");
		}	
		
	}
	
	if (keyboard_check_pressed(pscroll_up)) {
		pie_scroll += 1;
		if (pie_scroll >= tiermaster.pielist_height) { pie_scroll = 0; }
		
	} else if (keyboard_check_pressed(pscroll_down)) {
		pie_scroll -= 1;
		if (pie_scroll < 0) { pie_scroll = tiermaster.pielist_height - 1; }
		
	}
}

//select machine according to which one is highlighted
if (place_meeting(x, y + machine_range, obj_player)) {
	
	
	//select which machine to use
	if (lower_mstate != mstate_baking or upper_mstate != mstate_baking) {
		var ms_max = machine_scroll_max; //2
		var ms_min = machine_scroll_min; //1
		
		//will not be true at the same time - set in previous if check
		if (lower_mstate == mstate_baking) ms_min = 2;
		else if (upper_mstate == mstate_baking) ms_max = 1;
		
		//if machines arent in use
		if (mouse_wheel_up()) {
			machine_scroll += 1;
			if (machine_scroll > ms_max) machine_scroll = ms_min;
				
		} else if (mouse_wheel_down()) {
			machine_scroll -= 1;
			if (machine_scroll < ms_min) machine_scroll = ms_max;
		}
	}
	
	
	//can only toggle choosing if in range of the machine
	if (keyboard_check_pressed(vk_space)) {
		
		//choose pie to bake
		if (lower_mstate == mstate_checking or upper_mstate == mstate_checking) {
			if (keyboard_check(vk_shift)) {
				//set both to true
			
				if (lower_mstate == mstate_checking) lower_mstate = mstate_choosing;
				if (upper_mstate == mstate_checking) upper_mstate = mstate_choosing;
				//show_debug_message("both regions making pie");
				exit;
				
			} else {
				
				//selecting which machine
				if (machine_scroll == 1 and lower_mstate == mstate_checking) {
					lower_mstate = mstate_choosing;
					//show_debug_message("selected lower machine");
					exit;
				
				} else if (machine_scroll == 2 and upper_mstate == mstate_checking) {
					upper_mstate = mstate_choosing;
					//show_debug_message("selected upper machine");
					exit;
					
				}
			}
			
			
			//prevents it from choosing first pie right after selecting choose
			//dont put exit statement here otherwise it wont work
			if (lower_mstate == mstate_choosing or upper_mstate == mstate_choosing) {
				global.using_escape = true;
				show_debug_message("escape true");
				
			}
			
		}
		
		//relies on exit function in previous state otherwise will always set the pie cooking to type 1
		if (lower_mstate == mstate_choosing or upper_mstate == mstate_choosing) {
		
			if (!keyboard_check(vk_shift)) {
				if (machine_scroll == 1 and lower_mstate == mstate_choosing) {
					lower_mstate = mstate_baking;
					lower_piemaking = pie_scroll;
					//mstate = mstate_checking;
					//show_debug_message("lower region making pie");
					exit;
				}
			
				else if (machine_scroll == 2 and upper_mstate == mstate_choosing) {
					upper_mstate = mstate_baking;
					upper_piemaking = pie_scroll;
					//show_debug_message("upper region making pie");
					exit;
				}
			} else {
				lower_mstate = mstate_baking;
				lower_piemaking = pie_scroll;
				upper_mstate = mstate_baking;
				upper_piemaking = pie_scroll;
				//show_debug_message("both regions making pie");
				exit;
			}
		}
		
		if (lower_mstate == mstate_done or upper_mstate == mstate_done) {
			//pick up lower pie
			if (machine_scroll == 1 and lower_mstate == mstate_done) {
				
				//show_debug_message("lower pie picked up");
				
				//check if pie is being held by player
				var opie = obj_player.pie_selected
				if (opie != -1) {
					opie.y = y - 2;
					opie.is_selected = false;
					obj_player.pie_selected = -1;
			
				}
		
		
				obj_pie.is_selected = false;
				lower_pie_inst.is_selected = true;
				lower_pie_inst.collideable = false;
				
				obj_player.pie_selected = lower_pie_inst;
				
		
				//mstate = mstate_checking;
				lower_mstate = mstate_checking;
				if (upper_mstate != mstate_choosing) pie_scroll = 0;
		
			} else if (machine_scroll == 2 and upper_mstate = mstate_done) {
				//pie is picked up only if nothing on the bottom
				//show_debug_message("upper pie picked up");
		
				//check if pie is being held by player
				var opie = obj_player.pie_selected
				if (opie != -1) {
					opie.y = y - 2;
					opie.is_selected = false;
					obj_player.pie_selected = -1;
			
				}
		
				obj_pie.is_selected = false;
				upper_pie_inst.is_selected = true;
				upper_pie_inst.collideable = false;
				
				obj_player.pie_selected = upper_pie_inst;
		
				//mstate = mstate_checking;
				upper_mstate = mstate_checking
				if (lower_mstate != mstate_choosing) pie_scroll = 0;
				
			}
			
			
		}
	}
}




if (lower_mstate = mstate_baking) {
	
	lower_making_timer += 1;
	
	if (lower_making_timer/room_speed >= making_done) {
		var piex = x + mmiddlex - pie_middle;
		var piey = y - machine_lower_y - mmiddley - pie_middle;
		
		//create pie
		lower_pie_inst = instance_create_layer(piex, piey, "Instances", obj_pie);
		lower_pie_inst.pie_type = lower_piemaking;
		lower_pie_inst.oven_tier = oven_tier;
		
		
		lower_mstate = mstate_done;
		lower_making_timer = 0;
		lower_pie_on_stove = true;
		//show_debug_message("lower pie done");
		
	}
}

if (upper_mstate = mstate_baking) {
	
	upper_making_timer += 1;
	
	if (upper_making_timer/room_speed >= making_done) {
		var piex = x + mmiddlex - pie_middle;
		var piey = y - machine_upper_y - mmiddley - pie_middle;
		
		//create pie
		upper_pie_inst = instance_create_layer(piex, piey, "Instances", obj_pie);
		upper_pie_inst.pie_type = lower_piemaking;
		upper_pie_inst.oven_tier = oven_tier;
		
		upper_mstate = mstate_done;
		upper_making_timer = 0;
		upper_pie_on_stove = true;
		//show_debug_message("upper pie done");
		
	}
}

