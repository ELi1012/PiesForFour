/// @desc state functions

state_lining = function() {
	
	//variables for BASIC MOVEMENT
	dir = 1;
	destination_x = obj_spawner.lineline + spawn_x;
	destination_y = y;
	goal_x = destination_x - x; //positive if table_left_x to the right of x
	goal_y = 0; //positive if table_left_y lower than y
	bound = spd * 2;
	
	//TIMER
	c_timer += timer_add;
	if (c_timer/room_speed > time_given) {
		
		// time runs out
		customer_angered();
		cluster_selected = false; //draw function does not draw arrow once variables have been assigned
		
		//show_debug_message("customer angered");
		
	}
	
	//show_debug_message(string(goal_x) + " goal x");
	//show_debug_message(string(goal_y) + " goal y");
	
	// reached goal
	if (goal_x = 0 and goal_y = 0) dir = -1;
	
	
	//CHANGE LINEUP GOAL IF SOMEONE MOVES OR YOU MOVE
	
	#region CHOOSE TABLE
	
	if (dir = -1) {
		
		
		//cease movement if have not been given table
		moveX = 0;
		moveY = 0;
		
		//leader checks if player has clicked on customer
		var mx, my, xx, yy, cluster_set;
		cluster_set = false;			// whether cluster_selected has been set to true in this step
		mx = mouse_x;
		my = mouse_y;
		xx = x - x_offset;
		yy = y - y_offset;
		
		
		// mouse is hovering over customer in front of line
		// check is performed by every customer
		// will not run if one cluster member has already set cluster_selected = true
		if (line_up_id == 1 and !cluster_selected and is_leader) {
				
			// with all cluster members: check for collision with mouse
			// have to run this code inside leader to make outline work properly
			
			mouse_above = false;
			for (var i = 0; i < cluster_number; i++) {
				var inst = ds_cluster[# 0, i];
				with (inst) {
					if (point_in_rectangle(mx, my, xx, yy, xx + frame_size, yy + frame_size)) {
						other.mouse_above = true;
					}
				}
				
				// break after getting out of with statement
				// otherwise it will not break out of the for loop
				if (mouse_above) break;
			}
			
			
			if (mouse_above) {
			
				//customer has been clicked
				// cluster selected
				if (mouse_check_button_pressed(mb_left)) {
				
					// cluster selected variable is only needed for leader
					// #problem when cluster_selected = true not all members are necessarily selected
					
					//var i = 0; repeat (cluster_number) {
					//	show_debug_message("i: " + string(i));
					//	var inst = ds_cluster[# 0, i];
					//	inst.cluster_selected = true;
					//	i++;
					//}
				
					// only leader has access to ds_cluster
					var dd = ds_cluster;
					for (var i = 0; i < cluster_number; i++) {
						dd[# 0, i].cluster_selected = true;
					}
				
					global.using_escape = true;
					cluster_set = true;
				
				}
			}
		}
			

	
		//deselect customer
		if (cluster_selected and keyboard_check_pressed(vk_escape)) {
			cluster_selected = false;
			global.using_escape = false;
			
		}
			
		//leader checks for table click
		if (cluster_selected and is_leader and !cluster_set) {
			
			// check if clicked table
			if (place_meeting(mx, my, obj_table) and mouse_check_button_pressed(mb_left)) {
				var table_inst = instance_place(mx, my, obj_table);
				
				// ASSIGNED TABLE TO CLUSTER ----- STATE CHANGE
				if (!table_inst.claimed) { //check if table has been claimed - if not claim it
					
					// set global.using_escape = false after one frame
					alarm[0] = 1;		
					
					
					with (table_inst) {
						leader_inst = other.id;
						claimed_number = other.cluster;
						claimed = true;
					}
					
					
					// set table inst for everyone in cluster
					// change state to arriving
					for (var dd = 0; dd < cluster_number; dd++) {
						var inst = ds_cluster[# 0, dd];
						with (inst) {
							cluster_selected = false;
							dir = 1;
							set_table = table_inst;
							
							state_change(state, state_findseat);
							state = state_findseat;
							
							// switch position according to table position
							switch (table_spot) {
								case table_pos.table_left:
									table_x = set_table.bbox_left;
									table_y = set_table.y;
									break;
					
								case table_pos.table_right:
									table_x = set_table.table_right_x;
									table_y = set_table.y;
									break;
						
								case table_pos.table_middle:
									table_x = set_table.table_middle_x;
									table_y = set_table.table_middle_y;
									top_of_table = true;
									break;
						
								case table_pos.table_topleft:
									table_x = set_table.table_topleft_x;
									table_y = set_table.table_topleft_y;
									top_of_table = true;
									break;
						
								case table_pos.table_topright:
									table_x = set_table.table_topright_x;
									table_y = set_table.table_topright_y;
									top_of_table = true;
									break;
					
							}
						}
					}
				}
			}
		}
	}
	#endregion
}
	
state_findseat = function() {
	
	//table variables
	if (!seated) { //start moving towards table
		//SWITCH ACCORDING TO TABLE POSITION
		switch (table_spot) {
			case table_pos.table_left:
				cx = bbox_right + 1;
				cy = bbox_top + (c_box_height/2); //SET TO MIDDLE OF BOUNDING BOX
				break;
					
			case table_pos.table_right:
				cx = bbox_left - 1;
				cy = bbox_top + (c_box_height/2); //SET TO MIDDLE OF BOUNDING BOX
				break;
						
			case table_pos.table_middle:
				cx = x;
				cy = bbox_bottom + 1;
				break;
						
			case table_pos.table_topleft:
				cx = x;
				cy = bbox_bottom + 1;
				break;
						
			case table_pos.table_topright:
				cx = x;
				cy = bbox_bottom + 1;
				break;
			
		}
	
		//variables for BASIC MOVEMENT
		dir = point_direction(cx, cy, table_x, table_y);
		destination_x = table_x;
		destination_y = table_y;
		goal_x = table_x - cx; //positive if table_left_x to the right of x
		goal_y = table_y - cy; //positive if table_left_y lower than y
		bound = spd * 2;
		
		//show_debug_message(" ");
		//show_debug_message("initial " + string(cx) + "x" + string(cy) + "y");
		
	
	//show_debug_message("goal " + string(goal_x) + "x" + string(goal_y) + "y");
	
	}
	
	//------------ IF CUSTOMER IS SEATED
	if (table_x == cx and table_y == cy) { //reset variables when customer is seated
		seated = true;
		dir = -1;
		disable_collision = false;
		//bigman.ds_cluster[# 3, customer_id - 1] = true; same thing as seated variable
		
		// leader checks if all in cluster are seated
		if (is_leader) {
			//show_debug_message("leader checking for seated");
			
			all_seated = false;
			
			//for (var dd = 0; dd < cluster_number; dd++) {
			var dd = 0; repeat (cluster_number) {
				var inst = ds_cluster[# 0, dd];
				with (inst) {
					
					if (!seated) {
						//show_debug_message("one not seated; break");
						other.all_seated = false;
						//break;
						
					} else if (seated) {
						//show_debug_message("this one seated");
						other.all_seated = true;
					}
				}
				
				if (!all_seated) break;
				dd += 1;
			}
			
			if (all_seated) { //seats all in cluster
				var dd = 0; repeat (cluster_number) {
					var inst = ds_cluster[# 0, dd];
					
					if (set_table.dirty) {
						// small chance they will not mind
						var t = obj_stats.tier;
						var maxt = tiermaster.max_tier;
						
						// if randomly chosen number from 1 to maxt is less than t
						// customer is angered by dirty table
						if (irandom_range(1, maxt) <= t)  {
							// customers angered
							// #problem last customer in group of 3 doesnt leave
							with (inst) {
								customer_angered();
							}
						} else {
							// customer tolerates dirty table
							// decrease customer patience/rating
							character_sprite = spr_customer_i1;
							given_dirtytable = true;
						}
						
					}
					
					// start ordering
					if (!angered) {
						with (inst) {
							//rotate customer to right position
							if (table_spot == table_pos.table_left) y_frame = 0;
							else if (table_spot == table_pos.table_right) y_frame = 1;
							
							state_change(state, state_ordering);
							state = state_ordering;
						}
					}
					
					dd += 1;
				}
			}
			
		} //leader checks if all in cluster are seated
		
		
	} else { seated = false; }
}
	
state_ordering = function() {
		
	dir = -1;
	moveX = 0;
	moveY = 0;
	
	c_timer += timer_add;

	//COUNTING DOWN UNTIL CUSTOMER STORMS OUT
	if (c_timer/room_speed > (time_given * 60)) {
		customer_angered();
		//show_debug_message("customer angered");
	}
	
	//leader checks for pie
	if (is_leader) {
		//will throw error message if pie wanted wasnt set in the seating block
		//show_debug_message(string(pie_wanted + 1) + " pie requested");
		var bubble_size = sprite_get_height(spr_piebubble);
		var bb_xx = set_table.table_middle_x - (bubble_size/2);		// x coordinate of bubble
		var bb_yy = set_table.table_middle_y - bubble_size - 10;		// y coordinate of bubble
			
		// check if clicked pie bubble
		if (point_in_rectangle(mouse_x, mouse_y, bb_xx, bb_yy, bb_xx + bubble_size, bb_yy + bubble_size)
			and mouse_check_button_pressed(mb_left) and !order_taken) {
				
			order_taken = true;
			
			// change all cluster state to waiting
			for (var dd = 0; dd < cluster_number; dd++) {
				with (ds_cluster[# 0, dd]) {
					state_change(state, state_waiting);
					state = state_waiting;
				}
			}
			
			
			//show_debug_message(" ");
			//show_debug_message("order taken");
			
			//0: cluster number
			//1: pie type
			//2: slices array
			
			// add order to checklist
			with (obj_checklist) {
				new_order = true;
				tables_ordered += 1;
				var o = ds_orders;
				var h = ds_grid_height(o);	// height of grid before resizing; gives correct index
				
				
				//checks if ds height is greater than 1
				// resize ds grid as necessary
				if (tables_ordered > 1) ds_grid_resize(ds_orders, 4, h + 1);
				else					h = 0;
				
				o[# 0, h] = other.cluster; //stores cluster group number
				o[# 1, h] = other.pie_wanted;
				o[# 2, h] = other.c_slices_array;
				o[# 3, h] = slice_to_note(other.c_slices_array); //converts slice array into note array

			}
		}
	}
}
	
state_waiting = function() {
	//TIMER
	c_timer += timer_add;
	if (c_timer/room_speed >= time_given) {
		customer_angered();
	}
	
	dir = -1;
	

	//check if pie on mouse = pie wanted
	// pie_given is changed in obj_pie
	
	if (is_leader) {
		var pie_given = set_table.table_pie;
		
		if (pie_given != -1) {
			 var given_right = check_pie_accuracy(pie_given);
			
			//-------------------GIVEN RIGHT OR WRONG PIE
			if (!given_right) {
				//customer given wrong pie
				for (var dd = 0; dd < cluster_number; dd++) {
					with (ds_cluster[# 0, dd]) {
						customer_angered();	// rating given by leader in function
					}
				}
				
			} else if (given_right) {
				
				// final rating and money given
				customer_rating(false);
			
				//set all variables of customers in cluster
				for (var dd = 0; dd < cluster_number; dd++) {
					with (ds_cluster[# 0, dd]) {
						state_change(state, state_eating);
						state = state_eating;
					}
				}
			
				// resize checklist
				remove_from_checklist = true;
				set_table.pie_todraw = pie_wanted;
			
			}
			
		
			// reset variables
			set_table.table_pie = -1;
			// pie_wanted = -1;	causes issues when since customer_rating is run after pie_wanted = -1
		
			instance_destroy(pie_given);	
		}
	}
}
	
state_eating = function() {
	// table is set to not dirty when state changes to state_eating
	
	eating_timer += 1;
	
	if (eating_timer/room_speed >= eating_max) {
		state_change(state, state_leaving);
		state = state_leaving;
		
		// reset table variables if leader
		if (is_leader) {
			set_table.claimed = false;
			set_table.pie_todraw = -1;
		
			//set table to dirty if not already dirty
			with (set_table) {
				dirty = true;
				if (other.given_dirtytable == false) {
					// pick a dirty sprite if not already dirty
					table_index = irandom_range(1, sprite_get_number(spr_dirtytable) - 1);
				}
			}
		}
	}
}
	
state_leaving = function () {
		
	//variables for BASIC MOVEMENT
	dir = point_direction(x, y, obj_spawn.x, obj_spawn.y);
	destination_x = obj_spawn.x;
	destination_y = obj_near_spawn.y;
	goal_x = destination_x - x; //positive if table_left_x to the right of x
	goal_y = destination_y - y; //positive if table_left_y lower than y
	bound = spd * 2;
	
	
	if (place_meeting(x, y, obj_near_spawn) and state == state_leaving) { 
		
		//disable collision if customer is near spawn point	
		disable_collision = true;
		near_spawn = true;
	}
	
	if (!near_spawn) disable_collision = false;
	
	
	if (place_meeting(x, y, obj_spawn)) {
		//show_debug_message("////////////////");
		//show_debug_message("instance destroyed");
		//show_debug_message("////////////////");
		
		if (is_leader) {
			if (ds_exists(ds_cluster, ds_type_grid)) ds_grid_destroy(ds_cluster);
		}
		
		// destroy self
		instance_destroy();
	}
}
