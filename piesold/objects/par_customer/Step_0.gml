/*
show_debug_message(" ");
show_debug_message(string(cluster) + " = cluster id /// with " + string(cluster_number) + " in the cluster");
show_debug_message(string(customer_id) + " is customer id with " + string(table_spot) + " as table_spot");
show_debug_message(string(leftmost_bbox) + " is leftmost bbox");
show_debug_message(string(spawn_x) + " is spawn x");
show_debug_message(" ");
*/

if (global.game_pause) exit;

if (leftmost_bbox != -1 and is_leader) {
	bbox_set = true;
	//show_debug_message(string(leftmost_bbox));
}

#region LINING

if (state = c_states.lining) {
	
	bigman = cluster_id.ds_clustomers[# 0, 0];
	
	//variables for BASIC MOVEMENT
	dir = 1;
	destination_x = obj_spawner.lineline + spawn_x;
	destination_y = y;
	goal_x = destination_x - x; //positive if table_left_x to the right of x
	goal_y = 0; //positive if table_left_y lower than y
	bound = spd * 2;
	
	//TIMER
	c_timer += 1;
	if (c_timer/room_speed > time_given) {
		angered = true;
		
		cluster_selected = false; //draw function does not draw arrow once variables have been assigned
					
		//show_debug_message("customer angered");
		
	}
	
	//show_debug_message(string(goal_x) + " goal x");
	//show_debug_message(string(goal_y) + " goal y");
	
	if (goal_x = 0 and goal_y = 0) {
		dir = -1;
	}
	
	//CHANGE LINEUP GOAL IF SOMEONE MOVES OR YOU MOVE
	
	#region CHOOSE TABLE
	
	if (dir = -1) {
		//check if player has clicked on customer
		var mx, my, xx, yy;
		mx = mouse_x;
		my = mouse_y;
		xx = x - x_offset;
		yy = y - y_offset;
		
		//customer has been clicked
		if (point_in_rectangle(mx, my, xx, yy, xx + frame_size, yy + frame_size)
			and mouse_check_button_pressed(mb_left) and line_up_id = 1) {
			
			with (bigman) { //leader sets cluster selected to true
				cluster_selected = true;
				global.using_escape = true;
			}
		}
	
		//deselect customer
		if (cluster_selected and keyboard_check_pressed(vk_escape)) {
			with (bigman) {
				cluster_selected = false;
				global.using_escape = false;
			}
		}
		
		//leader checks for table click
		if (cluster_selected) { //cluster_selected only set to true for leader
			
			if (place_meeting(mx, my, obj_table) and mouse_check_button_pressed(mb_left)) {
				table_inst = instance_place(mx, my, obj_table);
				
				//ASSIGNED TABLE TO CLUSTER ----- STATE CHANGE
				if (!table_inst.claimed) { //check if table has been claimed - if not claim it
					
					alarm[0] = 1;
					
					if (is_leader) {
						table_inst.leader_inst = id;
						table_inst.claimed_number = cluster;
					}
					
					table_inst.claimed = true;
					
					//show_debug_message("table is not claimed");
					var dd = 0;
			
					repeat(cluster_number) { //table inst is set for every customer not just leader
						with (cluster_id.ds_clustomers[# 0, dd]) {
							man_selected = false;
							table_occupied = true;
							dir = 1;
							move_to_table = true;
							set_table = other.table_inst;
						}
					dd += 1;
					}
					
					
					cluster_selected = false; //draw function does not draw arrow once variables have been assigned
					
				}
			}
		}
		
		if (table_occupied) {
			//SWITCH ACCORDING TO TABLE POSITION
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
			
			//obj_spawner.lineline -= leftmost_bbox - lineup_range;
			with (obj_table) { 
				counted = false; 
			}
			
			state = c_states.arriving;
			//show_debug_message("table clicked and state changed to arriving");
			}
		
		//cease movement if have not been given table
		if (!man_selected and !table_occupied) {
			moveX = 0;
			moveY = 0;
		}
	}
	
	
	#endregion
}


#endregion


#region ARRIVING

if (state = c_states.arriving) {
	
	#region SEATING
	
	//table variables
	
	if (!seated and table_occupied) { //start moving towards table
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
	
	} //if !seated and table_occupied
	
	//------------ IF CUSTOMER IS SEATED
	if (table_x == cx and table_y == cy) { //reset variables when customer is seated
		seated = true;
		man_selected = false;
		move_to_table = false;
		table_occupied = false;
		dir = -1;
		disable_collision = false;
		//cluster_id.ds_clustomers[# 3, customer_id - 1] = true; same thing as seated variable
		
		if (is_leader) { //leader checks if all in cluster are seated
			//show_debug_message("leader checking for seated");
			var dd = 0; repeat (cluster_number) {
				with (cluster_id.ds_clustomers[# 0, dd]) {
					if (!seated) {
						//show_debug_message("one not seated");
						other.all_seated = false;
					
					} else if (seated) {
						other.all_seated = true;
						//show_debug_message("this one seated");
					}
					
				}
				
				if (other.all_seated = false) break;
				dd += 1;
			}
			//show_debug_message("cluster " + string(cluster) + "all seated is " + string(all_seated));
			
			if (all_seated) { //seats all in cluster
				var dd = 0; repeat (cluster_number) {
					if (set_table.dirty) {
						with (cluster_id.ds_clustomers[# 0, dd]) {
							angered = true;
						}
					} else {
						with (cluster_id.ds_clustomers[# 0, dd]) {
							//rotate customer to right position
							if (table_spot == table_pos.table_left) y_frame = 0;
							else if (table_spot == table_pos.table_right) y_frame = 1;
							
							
							state = c_states.ordering;
						}
					}
					dd += 1;
				}
			}
			
		} //leader checks if all in cluster are seated
		
		
	} else { seated = false; }
	
	#endregion

}

#endregion


#region ORDERING

if (state = c_states.ordering) {
	
	dir = -1;
	moveX = 0;
	moveY = 0;
	
	c_timer += 1;

	//COUNTING DOWN UNTIL CUSTOMER STORMS OUT
	if (c_timer/room_speed > (time_given * 60)) {
		angered = true;
		//show_debug_message("customer angered");
		//c_timer = 0;
		
	}
	
	if (is_leader) { //leader checks for pie
		//will throw error message if pie wanted wasnt set in the seating block
		//show_debug_message(string(pie_wanted + 1) + " pie requested");
		
		
		if (instance_place(mouse_x, mouse_y, set_table) and mouse_check_button_pressed(mb_left)) {
			table_clicked = true;
			//show_debug_message("table clicked");
			
		}
		
		//if player clicks on table while order hasnt been taken
		if (table_clicked and !order_taken) { //only run once
			table_clicked = false;
			order_taken = true;
			
			var dd = 0; repeat (cluster_number) {
				with (cluster_id.ds_clustomers[# 0, dd]) state = c_states.waiting;
				dd += 1;
			}
			
			state = c_states.waiting;
			
			//show_debug_message(" ");
			//show_debug_message("order taken");
			
			//0: cluster number
			//1: pie type
			//2: slices array
			
			with (obj_checklist) {
				other.checklist_assigned = true;
				tables_ordered += 1;
				var o = ds_orders;
				var h = ds_grid_height(o);
				//show_debug_message(" ");
				//show_debug_message("checklist height " + string(h));
				
				
				//checks if ds height is greater than 1
				if (tables_ordered > 1) {
					ds_grid_resize(ds_orders, 4, h + 1);
					
					//show_debug_message("grid resized when more than one tables ordered");// + string(h));
					
				} else {
					//show_debug_message("only 1 tables ordered - set variables starting from o[# 0, 0]");
					// set column to 0 - o[# 0, 0]
					h = 0;
				}
				
				o[# 0, h] = other.cluster; //stores cluster group number
				o[# 1, h] = other.pie_wanted;
				o[# 2, h] = other.c_slices_array;
				o[# 3, h] = slice_to_note(other.c_slices_array); //converts slice array into note array
				//show_debug_message("ds grid resized height to " + string(h + 1));
				//show_debug_message("o[# 0, h] where h is " + string(h));
			}
			//show_debug_message("order taken");
		}
		
		//check if pie on mouse = pie wanted
		//=========================waiting goes here
	}
}

#endregion


#region WAITING

if (state = c_states.waiting) {
	
	//TIMER
	c_timer += 1;
	if (c_timer/room_speed >= time_given) {
		angered = true;
		//show_debug_message("customer angered");
	}
	
	dir = -1;
	
	//if (order_taken and pie_given != -1) { //order taken is set in previous state
	//check if pie on mouse = pie wanted
	if (pie_given != -1) {
		var given_right = false;
		//show_debug_message("pie given " + string(pie_given));
			
			
		if (!is_array(pie_given.slices_array)) { //set array[0] to 240
			pie_given.slices_array[0] = 240;
			//show_debug_message("set empty array to 240");
				
		}
			
			
		var c_wanted = sort_array(c_slices_array, true);
		var c_given = sort_array(pie_given.slices_array, true);
			
		var c_wanted_len = array_length_1d(c_wanted);
		var c_given_len = array_length_1d(c_given);
			
		/*
		show_debug_message(string(c_wanted_len) + " c wanted length");
		show_debug_message(string(c_given_len) + " c given length");
			
		var ii = 0; repeat (c_given_len) {
			show_debug_message(string(c_given[ii]) + " " + string(ii) + " given slice");
			ii += 1;
		}
			
		show_debug_message(" ");
			
		var ii = 0; repeat (c_wanted_len) {
			show_debug_message(string(c_wanted[ii]) + " " + string(ii) + " wanted slice");
			ii += 1;
		}
		*/
			
		if (c_wanted_len = c_given_len) {
			var dd = 0; repeat (c_wanted_len) {
				given_right = true;
				//show_debug_message(string(c_given[dd]) + " c given, " + string(c_wanted[dd]) + " c wanted");
					
				if (c_given[dd] != c_wanted[dd]) {
					//show_debug_message("c given array did not match c wanted");
					given_right = false;
					break;
				}
				dd += 1;
			}
				
		} else if (c_wanted_len != c_given_len) {
			given_right = false;
			//show_debug_message("c array heights did not match");
		}
			
		if (pie_given.pie_type != pie_wanted) {
			given_right = false;
			//show_debug_message("not given right pie type");
		}
			
		//-------------------GIVEN RIGHT OR WRONG PIE
		if (!given_right) { //customer given wrong pie
			var dd = 0; repeat(cluster_number) {
				with (cluster_id.ds_clustomers[# 0, dd]) angered = true;
				dd += 1;
			}
				
		} else { //given right pie
				
			   ////////////////////////////////////////////
			  ///////---------FINAL RATING---------///////
			 ////////////////////////////////////////////
			//calculate in percentage first then add 1
			var wait_time = c_timer/room_speed;
			var wait_bonus_max = 3/4;
			var wait_time_avg = time_given * wait_bonus_max; //starts subtracting rating if customer waits into 3/4 of given time
			var wait_divider = time_given * 2;
			
			if (sign(wait_time_avg - wait_time) == -1) wait_divider = time_given;
			
			
			var wait_rating = (wait_time_avg - wait_time)/wait_divider;
			//show_debug_message("wait rating is 1 + " + string(wait_time_avg) + " - " + string(wait_time) + " / (" + string(time_given)
			//	+ " * 2)");
			show_debug_message(" ");
			show_debug_message("wait rating calculated is 1 + " + string(wait_rating));
				
				
			//gold given
				var tts = tiermaster.tier_ds;
				var initial_gold = tts[# 1, pie_wanted]
				var wait_mgold = clamp(wait_rating, -0.9, 0.5);
				//dont leave less than 0.1 of initial gold
				//give no more than half of initial gold
					
				show_debug_message(" ");
				show_debug_message("wait multipler for gold " + string(1 + wait_mgold));
				show_debug_message("initial gold " + string(initial_gold));
				show_debug_message("final gold " + string(ceil(initial_gold * (1 + wait_mgold))));
					
					
				obj_stats.gold += ceil(initial_gold * (1 + wait_mgold));
					
				
			//rating given
					
				//reduce rating by up to half according to tier
				var rating_limit = tiermaster.max_rating/4; //will reduce rating when current rating hits a certain number
				var current_rating = obj_stats.rating;
				var current_ratingx = 0;
				
				//gives value between 0 and 0.5
				if (current_rating >= rating_limit) {
					current_ratingx = ((current_rating - rating_limit)/(tiermaster.max_rating - rating_limit)) * 0.5;
					show_debug_message("rating penalty before adjusting " + string(current_ratingx));
					
					//will never go into the negatives - avoids giving positive rating
					current_ratingx = clamp(current_ratingx, 0, 0.5); 
				}
				
				var impatience_rating = impatience * 0.2;
				
				
				var wait_mrating = max(wait_rating, -tiermaster.base_rating);
					
				show_debug_message(" ");
				show_debug_message("rating penalty according to current rating " + string(current_ratingx));
				show_debug_message("wait multiplier for rating " + string(wait_mrating));
				show_debug_message(" ");
					
				obj_stats.day_rating += tiermaster.base_rating * (1 - current_ratingx + wait_mrating - impatience_rating);
					
				show_debug_message("final day rating " + string(tiermaster.base_rating * 
					(1 - current_ratingx + wait_mrating - impatience_rating)));
				show_debug_message(" ");
				show_debug_message(" ");
				
				
			//set all variables of customers in cluster
			var dd = 0; repeat(cluster_number) {
				with (cluster_id.ds_clustomers[# 0, dd]) {
					served = true;
				}
				dd += 1;
			}
			
			set_table.pie_todraw = pie_wanted;
				
				
		} //given right pie
			
		//pie has been given - resize grid for checklist
		instance_destroy(pie_given);
			
			
		pie_wanted = -1;
			
	}
}

#endregion

//check if angered
if (state != c_states.leaving and state != c_states.eating) { //only run once
	if (angered) {
		state = c_states.leaving;
		remove_from_checklist = true;
		character_sprite = spr_customer_angry;
		if (is_leader) {
			with (obj_stats) { //DO NOT FORGET OTHER
				
				
				var rating_limit = tiermaster.max_rating/4; //will reduce rating when current rating hits a certain number
				var bad_rating_multiplier = 0;
				
				//gives value between 0 and 0.5
				if (rating >= rating_limit) {
					var bad_rating_percentage = ((rating - rating_limit)/(tiermaster.max_rating - rating_limit)) * 0.5;
					//show_debug_message("bad rating percentage before adjusting " + string(bad_rating_percentage));
					
					bad_rating_multiplier = 0.2 * bad_rating_percentage;
					
					//will never go into the negatives - avoids giving positive rating
				}
				
				
				var impatience_rating = other.impatience * 0.2;
				
				//show_debug_message("bad rating multiplier " + string(bad_rating_multiplier));
				//show_debug_message("impatience rating " + string(impatience_rating));
				//show_debug_message(" ");
				
				
				day_rating -= tiermaster.base_rating * (1 + bad_rating_multiplier + impatience_rating);
				
			}
			set_table.claimed = false;
			set_table.pie_todraw = -1;
		}
		
	} else if (served) {
		state = c_states.eating;
		remove_from_checklist = true;
	}
}


#region EATING

if (state == c_states.eating) {
	eating_timer += 1;
	
	if (eating_timer/room_speed >= eating_max) {
		state = c_states.leaving;
		set_table.claimed = false;
		set_table.pie_todraw = -1;
		
		//set table to dirty
		with (set_table) {
			dirty = true;
			table_index = irandom_range(1, sprite_get_number(spr_dirtytable) - 1);
		}
	}
}




#endregion EATING




#region LEAVING
if (state = c_states.leaving) {
	
	//variables for BASIC MOVEMENT
	dir = point_direction(x, y, obj_spawn.x, obj_spawn.y);
	destination_x = obj_spawn.x;
	destination_y = obj_near_spawn.y;
	goal_x = destination_x - x; //positive if table_left_x to the right of x
	goal_y = destination_y - y; //positive if table_left_y lower than y
	bound = spd * 2;
	
	
	if (place_meeting(x, y, obj_near_spawn) and state = c_states.leaving) { 
		
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
			with (cluster_id) {
				if (ds_exists(ds_clustomers, ds_type_grid)) {
					ds_grid_destroy(ds_clustomers);
					//show_debug_message("grid destroyed");
				}
				instance_destroy();
			}
		}
		instance_destroy();
	}
}

#endregion



if (dir != -1) { //goal x and y have been set if dir != -1
	#region basic movement
	
	/////////////////////////////////
	//USES GOAL X AND GOAL Y TO DETERMINE WHERE TO MOVE
	/////////////////////////////////
	
	//MOVES TO X IF NOT WITHIN X BOUNDS
	//IF WITHIN X BOUNDS MOVE Y = TRUE AND !MOVE X 
	
	//DISABLE MOVE Y IF MOVE X IS NOT WITHIN BOUNDS
	//IF Y IS IN BOUNDS BUT X IS NOT GO HORIZONTALLY
	
	if (abs(goal_x) > bound and move_to_x) { //not in bound x 
		//show_debug_message("not in bounds x");
		moveX = spd * sign(goal_x);
		moveY = 0;
		
		//show_debug_message(string(moveX) + "X");
		
	} else if (abs(goal_x) < bound and move_to_x) { //repeat movement until goal x = 0
		//show_debug_message("in bound x true");
		
		repeat(abs(goal_x)) {
				x += sign(goal_x);
			}
		moveX = 0;
		move_to_x = false;
	}
	
	if (abs(goal_y) > bound and !move_to_x) { //not in bound y
		//show_debug_message("not in bounds y");
		
		moveY = spd * sign(goal_y);
		moveX = 0;
		
		//show_debug_message(string(moveY) + "Y");
		
	} else if (abs(goal_y) < bound and !move_to_x) { //in bound y
		//show_debug_message("in bounds y");
		repeat (abs(goal_y)) {
				y += sign(goal_y);
			}
		
		moveY = 0;
		move_to_x = true;
		
		//show_debug_message(string(moveY) + "Y");
	}
	
	
	#endregion
	
	#region COLLISION CHECK
	
	if (!disable_collision) {
		
		// HORIZONTAL
		if (move_to_x) { //moving to x in basic movement
			var collisionH = instance_place(x + moveX, y, obj_collision);
			if(collisionH != noone and collisionH.collideable) {
				//WHILE COLLIDING IN X MOVE X AND Y ARE DISABLED
				//COLLISION CHECKING TAKES OVER FOR VERTICAL MOVEMENT INSTEAD OF BASIC MOVEMENT
				 
				repeat(abs(moveX)){
					if(!place_meeting(x + sign(moveX), y, obj_collision)) {
						x += sign(moveX);
					} else {
						break;
					}
				}
				
				
				if (goal_y = 0) moveY = spd;
				else moveY = spd * sign(goal_y); //until no x collision
				
				//does not include whether collision object is collideable
				if (place_meeting(x, y + moveY, obj_collision)) {
					var collisionV = instance_place(x, y + moveY, obj_collision);
					if(collisionV.collideable) moveY = 0;
					
				}
				
				moveX = 0;
				
				//show_debug_message("normal collision x");
					
			} 
		}

		// VERTICAL
		if(!move_to_x) {
			var collisionV = instance_place(x, y + moveY, obj_collision);
			if(collisionV != noone and collisionV.collideable) {
				
				repeat(abs(moveY)){
					if(!place_meeting(x, y + sign(moveY), obj_collision)) {
						y += sign(moveY);
						//show_debug_message("repeated y movement");
					} else {
						break;
					}
				}
				
				if (state = c_states.arriving and top_of_table) { //prevents oscillation if seated at table top
					moveX = spd;
				} else moveX = spd * sign(goal_x);//table_spot_left;  //until no y collision
				
				if (place_meeting(x + moveX, y, obj_collision)) moveX = 0;
				
				moveY = 0;
				
				//show_debug_message("normal collision y");
					
			} 
		}
		
		
		
	} else if (disable_collision and !instance_place(x, y, obj_collision)) {
		//and state != c_states.leaving) { //sets collision back to false if not colliding - runs at start of creation
		disable_collision = false;
		//show_debug_message("not colliding anymore");
	}
	
	#endregion
	
	#region APPLY MOVEMENT
	
	//show_debug_message(string(moveX) + " move x");
	//show_debug_message(string(moveY) + " move y");
	
	x += moveX;
	y += moveY;
	
	//-----------COLLISION FAILSAFE
	//check if customer hasnt reached goal in 10 seconds
	if (dir != -1) {
		collision_timer += 1;
		goal_timer += 1;
		
		if (goal_timer/room_speed >= goal_max) {
			//teleport customer to destination
			x = destination_x;
			y = destination_y;
			goal_timer = 0;
		}
		
		var collision_count = collision_timer/room_speed;
		if (collision_count >= collision_max) {
			disable_collision = true;
			collision_timer = 0;
			//show_debug_message("collision disabled");
		} else if (collision_count <= recent_collision_max) disable_collision = true;
		
		
	} else { 
		collision_timer = 0;
		goal_timer = 0;
	}
	
	#endregion
}

#region remove order from checklist
//if angered/eating and checklist has taken their order


if (remove_from_checklist and checklist_assigned) {
	if (is_leader) {
		with (obj_checklist) {
			other.remove_from_checklist = false;
			tables_ordered -= 1;
				
			//ONLY DECREASE LIST INC IF ORDER HEIGHT IS NOT 1
			if (orderheight != 1) list_inc -= 1;
				
			//loop through grid until cluster number matches current number
			var hh = ds_grid_height(ds_orders);
				
			if (hh > 1) { //grid height is not one
				var i = 0; repeat (hh) {
					
					if (ds_orders[# 0, i] = other.cluster) {
						//show_debug_message("found cluster number" + string(i));
						//reset variables of all columns below current i
						i += 1;
						var leftofgrid = hh - i;
						repeat (leftofgrid) {
							
							//show_debug_message("replaced " + string(ds_orders[# 0, i - 1]) + " with "
								//+ string(ds_orders[# 0, i]));
							
							ds_orders[# 0, i - 1] = ds_orders[# 0, i];
							ds_orders[# 1, i - 1] = ds_orders[# 1, i];
							ds_orders[# 2, i - 1] = ds_orders[# 2, i];
							ds_orders[# 3, i - 1] = ds_orders[# 3, i];
								
							i += 1;
							
						}
							
						ds_grid_resize(ds_orders, 4, hh - 1);
						//show_debug_message("resized grid to " + string(ds_grid_height(ds_orders)));
						break;
							
					}
					
					i += 1;
				}
					
			} else { //grid height = 1
				ds_grid_resize(ds_orders, 4, 1);
				ds_grid_clear(ds_orders, -1)
				//show_debug_message("grid height one - resized to 3, 1 and cleared -1");
				show_debug_message(" ");
					
			}
		}
	}
}
	
#endregion remove order from checklist

//customer is slightly angered
if (c_timer/room_speed >= impatience_limit and !angered) character_sprite = spr_customer_i1;


if (previous_state != state) { //run once upon state change
	if (previous_state == c_states.lining or previous_state == c_states.ordering or previous_state == c_states.waiting) {
		if (c_timer/room_speed >= impatience_limit and !angered) {
			show_debug_message("impatience limit reached - " + string((c_timer/room_speed)/60) + " minutes have passed");
			impatience += 1;
			time_given -= impatience_penalty * impatience;
			impatience_limit = (2/3) * time_given;
			show_debug_message("time given is now " + string(time_given/60) + " minutes");
		}
		
		
	}
	
	if (previous_state == c_states.lining and is_leader) {
		obj_spawner.lined_up -= 1;
		
		if (instance_exists(par_customer)) {
			with (par_customer) {
				if (state == c_states.lining and line_up_id != 1) line_up_id -= 1;
			}
		}
		
	}
	
	if (state != c_states.leaving) character_sprite = spr_customer;
	if (previous_state != c_states.ordering) c_timer = 0;
	collision_timer = 0;
	goal_timer = 0;
}

previous_state = state;











