///@desc archived code


#region wardrobe cell drawer
/*
//CREATE EVENT
wd_grid_height_spr = sprite_get_height(spr_wd_grid);
wd_grid_height_ui = wd_bg_height - grid_y;
wd_grid_height_page = grid_vblocks * (cell_size + cell_ybuff); //total height of cell blocks
wd_grid_height_blocks = 3; //dependent on the sprite itself


//STEP EVENT
//adjust mouse scroll
if (wd_grid_height_page >= wd_grid_height_ui) { //if page is large enough to warrant scrolling
	if (mouse_wheel_up()) mouse_scroll -= scroll_speed;
	else if (mouse_wheel_down()) mouse_scroll += scroll_speed;
		
	//consider repeat statement until mouse scroll reaches bottom of page
	var mouse_scroll_max = wd_grid_height_page - wd_grid_height_ui + (cell_ybuff * 4);// 
	if (mouse_scroll > mouse_scroll_max) mouse_scroll = mouse_scroll_max;
	else if (mouse_scroll < 0) mouse_scroll = 0;
}



//DRAW GUI EVENT
var full_sprites = grid_vblocks div wd_grid_height_blocks;
var ii = 0; repeat (full_sprites) {
	draw_sprite(spr_wd_grid, 0, grid_x, grid_y + (ii * (wd_grid_height_spr - cell_ybuff)) - mouse_scroll);
	ii += 1;
}

var separated_sprite = grid_vblocks mod wd_grid_height_blocks;
if (separated_sprite != 0) {
	var spspy = grid_y + ((full_sprites * (wd_grid_height_spr - cell_ybuff))) - mouse_scroll;
	
	draw_sprite_part(spr_wd_grid, 0, 0, (separated_sprite - 1) * cell_withbuffy, wd_grid_width, cell_withbuffy * separated_sprite,
		grid_x, spspy);
	
	//draw the little bit at the end
	draw_sprite_part(spr_wd_grid, 0, 0, 0, wd_grid_width, cell_ybuff,
		grid_x, spspy + (cell_withbuffx * separated_sprite));
}
*/
#endregion wardrobe cell drawer


#region collision avoiding
		/*
		right_arm = bbox_right + c_range;
		left_arm = bbox_left - c_range;
		top_arm = bbox_top - c_range;
		bottom_arm = bbox_bottom + c_range;
	
		//show_debug_message(string(right_arm) + " right arm");
		//show_debug_message(string(left_arm) + " left arm");
		//show_debug_message(string(top_arm) + " top arm");
		//show_debug_message(string(bottom_arm) + " bottom arm");
	
		right_collision = place_meeting(right_arm, y, obj_collision);
		left_collision = place_meeting(left_arm, y, obj_collision);
		top_collision = place_meeting(x, top_arm, obj_collision);
		bottom_collision = place_meeting(x, bottom_arm, obj_collision);
		
		var run_check = false;
	
		if (right_collision or left_collision or top_collision or bottom_collision) {
			//show_debug_message(" ");
			//show_debug_message("collidedsomewhere");
		
			if (state = c_states.waiting) { //CHECK IF COLLIDED WITH TABLE SIDE
				if (collision_rectangle(table_left_x - 32, set_table.bbox_top -1, table_left_x, 
					set_table.bbox_bottom +1, id, false, false)) {
					//show_debug_message("near left table side");
					 // and !seated and inst == set_table and (box_left - bbox_right) > 0
					//only run if customer is not on the side of the table
					//show_debug_message("is table");
					run_check = false;
					
				} else { run_check = true; }
				
			} 
			
			if (run_check) { //only avoid if colliding instance is not table
				//show_debug_message("running check");
				var nearest_inst = instance_nearest(x, y, obj_collision);
				var x_dir = sign(nearest_inst.x - x); //xDir positive = inst.x to the right of x
				var y_dir = sign(nearest_inst.y - y);
				var h_dir = -3;
				var v_dir = -3;
			
				//set h dir and v dir
				if (right_collision or left_collision) {
					h_dir = right_collision - left_collision;
					//show_debug_message("h dir " + string(h_dir));
				}
			
				if (top_collision or bottom_collision) {
					v_dir = top_collision - bottom_collision;
					//show_debug_message("v dir " + string(v_dir));
				}
			
				//set movement according to h dir and v dir
				if (h_dir != -3 and v_dir != -3) { //collisions for both left/right or up/down
					//disable collision until clear again
					disable_collision = true;
				
				} else if (h_dir = -3 and moveX = 0) { //no left/right collision `` or __
					//top/bottom collision is ignored if customer is moving horizontally
					//move in direction furthest away from nearest collision
					show_debug_message("top or bottom collision while moving Y");
				
					moveX = spd;
					moveY = 0;
				
				} else if (v_dir = -3 and moveY = 0) { //no up/down collision |x or x|
					show_debug_message("right or left collision while moving X");
					
					moveX = 0;
					moveY = spd;
					
					
					//if (sign(h_dir) = sign(goal_x)) { //direction of collision and horizontal movement are the same
					//	moveY = spd;//spd * yDir;
					//	moveX = 0;
					//} else { moveX = spd * sign(goal_x) }
					

				}
			}
			
		}
		
		*/
		#endregion

#region old old collision avoiding
/*

if (h_dir != -3 and v_dir != -3) { //collisions for both left/right or up/down
	//OLD CODE
	//IF BOXED IN EVERYWHERE BUT ONE DIRECTION TEMPORARILY DISABLE COLLISION
				
	if (h_dir = 0 or v_dir = 0) {
		// |_| OR |''| if h_dir = 0
		//|;; OR ;;| if v_dir = 0
		//FULLY BOXED IN IF BOTH
		disable_collision = true;
		//moveX = 0;
		//moveY = 0;
		show_debug_message("boxed in");
					
	} else { // |_ or _| or ''| or |''
		show_debug_message("L");
		if (moveX != 0) { //moving in horizontal direction
			//move in opposite y direction of obstacle
			moveY = spd * v_dir;
			moveX = 0;
		} else if (moveY != 0) { //moving in vertical direction
			//move in opposite x direction of obstacle
			moveX = -spd * h_dir;
			moveY = 0;
		}
					
	}
					
	//OLD CODE end region	
	//disable collision until clear again
	disable_collision = true;
				
}

//-----------------------------------------------

#region right/left collision
			if (right_collision or left_collision and abs(inst.bbox_right - bbox_right) < 1) { //go up or down
				show_debug_message("right/left collision");
				moveX = 0;
				if (top_collision) { //go down until you can go in original left/right direction
					//show_debug_message("top collision");
					moveY = spd; //MY CAT IS SNEEZING
					
				} else if (bottom_collision) { //go up until space available
					//show_debug_message("bottom collision");
					moveY = -spd;
			
				} else if (!top_collision and !bottom_collision) { //there is no up/down collision
					//show_debug_message("up and down clear");

						switch (yDir) {
							case 1: //go down - inst.y above y
								moveY = spd;
								break;
					
							case -1: //go up - inst.y below y
								moveY = -spd;
								break;
					
							default:
								moveY = -spd;
								break;
						}
			
				} else if (top_collision and bottom_collision) {
					
					moveY = 0;
					//show_debug_message("nope");
				}
			}
		#endregion

			#region up/down collision
			if (top_collision or bottom_collision) { //go left or right
				moveY = 0;
				
				if (right_collision) { //go left until you can go in original up/down direction
					//show_debug_message("right collision");
					moveX = -spd;
					
				} else if (left_collision) { //go right until space available
					//show_debug_message("left collision");
					moveX = spd;
			
				} else if (!right_collision and !left_collision) { //there is no right/left collision
					//show_debug_message("right and left clear");
					
						switch (xDir) { //evaluate to boolean
							case 1: //go left - inst.x to the right of x
								moveX = spd;
								break;
					
							case -1: //go right - inst.x to the left of x
								moveX = -spd;
								break;
					
							default:
								moveX = spd;
								break;
						}
			
				} else if (right_collision and left_collision) {  //left AND right collision
					moveX = 0;
					//show_debug_message("nope");
				}
				
			}
		#endregion 

//-------------------------------------------------------

*/

#endregion

#region pie cutting
/*

function draw_cut_line(rotation_degree, rotating_by) {
	
	var degree_gone = 0;
	var is_between = false;
	var weird_slice = false;
	var between_point = -1;

	var lines = ds_lines;
	var dsheight = ds_grid_height(lines);
	var dswidth = ds_grid_width(lines);


	//0: pie slice number
	//1: pie degrees
	//2: pie degree boundary (lesser)
	//3: boundary (greater)
	//4: abs(closest_cut.rotate_degree - rotation_degree) > 180

	//offset from center
	var radiusx = lengthdir_x(pie_rad, rotation_degree); //pie rad is 320
	var radiusy = lengthdir_y(pie_rad, rotation_degree);

	//no line at current instance

	// check if line has already been cut here
	if (place_meeting(gui_middlex + radiusx, gui_middley + radiusy, obj_cutline)) {
		//show_debug_message("line already here");
		//if not working check cutline collision mask
		return -1;
		exit;
	}

	var closest_cut = instance_nearest(gui_middlex + radiusx, gui_middley + radiusy, obj_cutline); //put this before creating the instance
	var line_inst = instance_create_layer(gui_middlex + radiusx, gui_middley + radiusy, "Instances", obj_cutline);

	//stores these variables in line inst
	with (line_inst) {
		rotate_degree = rotation_degree;
		rotate_by = rotating_by;
	}


	if (first_degree = -1) { //first degree not set
		//show_debug_message("first cut made");
		first_degree = rotation_degree;
		is_first = true;
		//show_debug_message(" ");
	
		return 0;
	
	} else { //first cut already made
	
		slices_cut += 1;
	
	#region check if current line is between an existing slice
		var j = 0; repeat (dsheight) {
			var greater_arm = lines[# 3, j];
			var lesser_arm = lines[# 2, j];
			///show_debug_message(string(j) + " j");
		
			if (slices_cut = 2) { //slice does not exist yet
				//show_debug_message("one pie slice");
				break; 
			}
		
			if (lines[# 4, j] = true) { //slice is weird
				if (rotation_degree < lesser_arm or rotation_degree > greater_arm) { //current degree within bounds of existing slice boundary
					//show_debug_message("within bounds of pie slice with weird pie");
					//show_debug_message(string(j) + " j");
					var greater_arm = lines[# 3, j];
					var lesser_arm = lines[# 2, j];
					between_point = j;
					is_between = true;
					break;
				}
			
			
			} else { //slice is normal
				if (rotation_degree > lesser_arm and rotation_degree < greater_arm) { //current degree within bounds of existing slice boundary
					//show_debug_message("within bounds of pie slice with normal pie");
					//show_debug_message(string(j) + " j");
					var greater_arm = lines[# 3, j];
					var lesser_arm = lines[# 2, j];
					between_point = j;
					is_between = true;
					break;
				
				}
			}
			j += 1;
		}
	#endregion check if current line is between an existing slice
	
		ds_grid_resize(lines, dswidth, dsheight + 1); //do this before using data grid with column dsheight
	
	
		if (is_between) {
		#region if cut is between boundaries of existing silce
			var old_degrees = -1;
			var new_degrees = -1;
		
			if (lines[# 4, between_point] = true) { //slice is weird
			
				if (rotation_degree > greater_arm and rotation_degree != 0) { //current arm in quadrant 3 or 4
					//show_debug_message("cut between weird slice and arm is in quadrant 3/4");
					old_degrees = rotation_degree - greater_arm;
					new_degrees = (360 - rotation_degree) + lesser_arm;
				
					//show_debug_message("old degrees = " + string(rotation_degree) + "(rotation degree) - " + string(greater_arm) + "(greater arm)");
					//show_debug_message("new degrees =  (360 - " + string(rotation_degree) + ") + " + string(lesser_arm) + "(lesser arm)");
				
					//old slot variables
					lines[# 1, between_point] = old_degrees;
					lines[# 2, between_point] = greater_arm; //new lesser arm
					lines[# 3, between_point] = rotation_degree; //new greater arm
					lines[# 4, between_point] = false; //slice is no longer weird
				
					//new slot variables
					//degree_gone = new_degrees; //always the top slice
					lines[# 1, dsheight] = new_degrees;
					lines[# 2, dsheight] = lesser_arm; //new lesser arm
					lines[# 3, dsheight] = rotation_degree; //new greater arm
					lines[# 4, dsheight] = true;
					
				}
			
				if (rotation_degree < lesser_arm and rotation_degree != 0) { //current arm is in quadrant 1 or 2
					//show_debug_message("cut between weird slice and arm is in quadrant 1/2");
					new_degrees = lesser_arm - rotation_degree;
					old_degrees = (360 - greater_arm) + rotation_degree;
				
					//show_debug_message("new degrees = " + string(lesser_arm) + "(lesser arm) - " + string(rotation_degree) + "(rotation degree)");
					//show_debug_message("old degrees =  (360 - " + string(greater_arm) + "(greater arm)) + " + string(rotation_degree) + "(rotation degree)");
				
					//old slot variables
					lines[# 1, between_point] = old_degrees;
					lines[# 2, between_point] = rotation_degree; //new lesser arm
					lines[# 3, between_point] = greater_arm; //new greater arm
					lines[# 4, between_point] = true; //slice is still weird
				
					//new slot variables
					//degree_gone = new_degrees; //always the top slice
					lines[# 1, dsheight] = new_degrees;
					lines[# 2, dsheight] = rotation_degree; //new lesser arm
					lines[# 3, dsheight] = lesser_arm; //new greater arm
					lines[# 4, dsheight] = false;
				
				}
			
				if (rotation_degree = 0) { //cut at degree 0
					//show_debug_message("cut between weird slice and arm is 0");
					new_degrees = lesser_arm;
					old_degrees = 360 - greater_arm;
				
					//show_debug_message("new degrees = " + string(lesser_arm) + "(lesser arm)");
					//show_debug_message("old degrees =  (360 - " + string(greater_arm) + "(greater arm))");
				
					//old slot variables
					lines[# 1, between_point] = old_degrees;
					lines[# 2, between_point] = 0; //new lesser arm //---CONDITION CANNOT BE LESSER THAN 0
					lines[# 3, between_point] = greater_arm; //new greater arm
					lines[# 4, between_point] = true; //slice is weird and lesser = 0
				
					//new slot variables
					degree_gone = new_degrees; //always the top slice
					lines[# 1, dsheight] = new_degrees;
					lines[# 2, dsheight] = 0; //new lesser arm
					lines[# 3, dsheight] = lesser_arm; //new greater arm
					lines[# 4, dsheight] = false;
				
				}
			
		
			} else { //slice is normal
				//show_debug_message("cut between normal slice");
				new_degrees = greater_arm - rotation_degree;
				old_degrees = rotation_degree - lesser_arm;
			
				//show_debug_message(string(new_degrees) + " new pie slice");
				//show_debug_message(string(old_degrees) + " old pie slice");
			
				
				//old slot variables
				lines[# 1, between_point] = old_degrees;
				lines[# 2, between_point] = lesser_arm; //new lesser arm
				lines[# 3, between_point] = rotation_degree; //new greater arm
				lines[# 4, between_point] = false;
				
				//new slot variables
				lines[# 1, dsheight] = new_degrees;
				lines[# 2, dsheight] = rotation_degree; //new lesser arm
				lines[# 3, dsheight] = greater_arm; //new greater arm
				lines[# 4, dsheight] = false;
			
			}
		#endregion //is between two slices
		
		} else { //is not between two arms
			//save degree of smallest slice
			//show_debug_message("is not between an existing slice");
			degree_gone = abs(closest_cut.rotate_degree - rotation_degree);
			//show_debug_message(string(closest_cut.rotate_degree) + " closest degree");
			//show_debug_message(string(rotation_degree) + " current degree");
	
			if (degree_gone > 180) { //chooses smaller slice
				degree_gone = min(closest_cut.rotate_degree, rotation_degree) + (360 - max(closest_cut.rotate_degree, rotation_degree))
				weird_slice = true;
			} else weird_slice = false;
		
		
		
		
			lines[# 1, dsheight] = degree_gone;
			lines[# 2, dsheight] = min(closest_cut.rotate_degree, rotation_degree);
			lines[# 3, dsheight] = max(closest_cut.rotate_degree, rotation_degree);
			lines[# 4, dsheight] = weird_slice;
			//show_debug_message(string(weird_slice) + " weird slice for slice not between something");
		
		}
	
		lines[# 0, dsheight] = slices_cut;
		var current_degrees_left = 360;
		var current_taken_away = 0;
	
		var dd = 1; repeat (dsheight) {
			current_degrees_left -= lines[# 1, dd]
			current_taken_away += lines[# 1, dd];
			//show_debug_message("took away " + string(current_taken_away));
		
		
			dd += 1;
		}
	
		//show_debug_message("degrees left " + string(current_degrees_left));
		degrees_left = current_degrees_left;
	
		//topmost column stores pie left
		lines[# 0, 0] = slices_cut;
		lines[# 1, 0] = degrees_left;
		lines[# 2, 0] = -1;
		lines[# 3, 0] = -1;
		lines[# 4, 0] = false;
	
	
		//show_debug_message(string(weird_slice) + " weird slice");
	
		//show_debug_message(string(closest_cut.rotate_degree) + " closest degree");
	
	
	
		
		show_debug_message("/////////////---TOP SLICE");
		show_debug_message(string(lines[# 1, dsheight]) + " size of pie in degrees");
		show_debug_message(string(lines[# 2, dsheight]) + " smallest boundary");
		show_debug_message(string(lines[# 3, dsheight]) + " largest boundary");
		show_debug_message(string(lines[# 4, dsheight]) + " is weird slice");
	
		show_debug_message(" ");
	
		if (is_between) {
			show_debug_message("/////////////---BOTTOM SLICE");
			show_debug_message(string(lines[# 1, between_point]) + " size of pie in degrees");
			show_debug_message(string(lines[# 2, between_point]) + " smallest boundary");
			show_debug_message(string(lines[# 3, between_point]) + " largest boundary");
			show_debug_message(string(lines[# 4, between_point]) + " is weird slice");
		
			show_debug_message(" ");
		}
		
	
		return 1;
	
	}

}

*/
#endregion


#region room editing
/*

function draw_edit_room_old() {
	
	if (reroom_confirm_purchase) {
		if (show_icon_table) {
			var reno_confirm_icon = spr_table;
			var rrc_cost = table_upgrade[rrc_icon_tier - 1];
			
		} else if (show_icon_oven) {
			var reno_confirm_icon = spr_piemachine;
			var rrc_cost = oven_upgrade[rrc_icon_tier - 1];
			
		} else {
			var reno_confirm_icon = spr_piemachine;
			var rrc_cost = "your soul";
		}
		
		draw_sprite(spr_reno_confirm, 0, reroom_confirmx, reroom_confirmy);
		
		draw_sprite_ext(reno_confirm_icon, rrc_icon_tier, rrc_icon_x, rrc_icon_y, 2, 2, 0, c_white, 1)
		
		draw_set_font(fnt_beeg);
		draw_set_color(c_black);
		
		draw_text(rrc_text_x, rrc_text_y, "Cost: " + string(rrc_cost));
		draw_set_font(fnt_default);
		draw_set_color(c_white);
		
		
	}
	
}


	// old version
function edit_room_old() {
		//check for clicking
	var mx = mouse_x;
	var my = mouse_y;
	
		// player wants to purchase table
	if (place_meeting(mx, my, obj_table) and mouse_check_button_pressed(mb_left) and !reroom_confirm_purchase) {
		reroom_confirm_purchase = true;
		table_can_upgrade = true;
		show_icon_table = true;
		
		
		var table_inst = instance_place(mx, my, obj_table);
		var inst_tier = table_inst.table_tier;
		var current_tier = obj_stats.tier;
		
		//drawing variables
		rrc_icon_tier = inst_tier;
		rrc_icon_tier = clamp(rrc_icon_tier, 1, array_length(table_upgrade));
		//show_debug_message("table rrc icon tier " + string(rrc_icon_tier));
		
		if (inst_tier = tiermaster.max_tier) {
			table_can_upgrade = false;
			reno_notif_string = "Reached maximum upgrade";
			exit;
		}
		
		// maybe debug upgrades will crash if the next tier is above current tier
		if (inst_tier > current_tier) {
			table_can_upgrade = false;
			reno_notif_string = "Upgrade to next tier to unlock this upgrade";
		} else if (obj_stats.piebucks < table_upgrade[current_tier - 1]) {
			table_can_upgrade = false;
			reno_notif_string = "Not enough piebucks - you need " + string(table_upgrade[current_tier - 1]) + " piebucks";
		}
		
		
		
		oven_can_upgrade = false;
		show_icon_oven = false;
		table_to_upgrade = table_inst;
		
	}
	
	if (place_meeting(mx, my, par_oven) and mouse_check_button_pressed(mb_left) 
		and !reroom_confirm_purchase) {
			
			reroom_confirm_purchase = true;
			oven_can_upgrade = true;
			show_icon_oven = true;
		
			//if (place_meeting(mx, my, obj_piemachine)) var oven_inst = instance_place(mx, my, obj_piemachine);
			//else if (place_meeting(mx, my, obj_piemachine_ext)) var oven_inst = instance_place(mx, my, obj_piemachine_ext);
			
			var oven_inst = instance_place(mx, my, par_oven);
		
			var inst_tier = oven_inst.oven_tier;
			var current_tier = obj_stats.tier;
			
			//drawing variables
			rrc_icon_tier = inst_tier;
			rrc_icon_tier = clamp(rrc_icon_tier, 1, array_length(oven_upgrade));
			
			if (inst_tier = tiermaster.max_tier) {
				oven_can_upgrade = false;
				reno_notif_string = "Reached maximum upgrade";
				exit;
			}
			
			if (inst_tier > current_tier) {
				oven_can_upgrade = false;
				reno_notif_string = "Upgrade to next tier to unlock this upgrade";
			}
		
			else if (obj_stats.piebucks < oven_upgrade[current_tier - 1]) {
				oven_can_upgrade = false;
				reno_notif_string = "Not enough piebucks - you need " + string(oven_upgrade[current_tier - 1]) + " piebucks"
			}
			
		
			table_can_upgrade = false;
			show_icon_table = false;
			oven_to_upgrade = oven_inst;
			
		
	}
	
	//confirming a purchase
	if (reroom_confirm_purchase and keyboard_check_pressed(vk_enter)) {
		if (show_icon_oven) {
			if (oven_can_upgrade) {
				var piebucks_needed = oven_upgrade[rrc_icon_tier - 1];
				var dbdb = tiermaster.ds_oven_tiers;
				
				// do not subtract pie bucks if in debug mode
				obj_stats.piebucks -= piebucks_needed;
				oven_to_upgrade.oven_tier += 1;
			
				//find oven to store variables in
				var ii = 0; repeat (ds_grid_height(dbdb)) {
					
					var cx = oven_to_upgrade.x;
					var cy = oven_to_upgrade.y;
					
					var px = dbdb[# 0, ii];
					var py = dbdb[# 1, ii];
					
					if (cx == px and cy == py) {
						var extension_added = dbdb[# 3, ii];
						
						dbdb[# 2, ii] = oven_to_upgrade.oven_tier;
						//show_debug_message("stored tier in machine with coordinates " + string(px) + " " + string(py));
						
						if (oven_to_upgrade.oven_tier >= 3 and !extension_added) {
							
							dbdb[# 3, ii] = true;
							upgraded_ovens += 1;
							
							
							
							reno_new_notif = true;
							reno_notif_string = "extension added";
							
						}
						break;
					}
					ii += 1;	
				}
				//show_debug_message("oven upgraded to tier " + string(oven_to_upgrade.oven_tier) + " with" + string(piebucks_needed));
				reroom_confirm_purchase = false;
			
			} else reno_new_notif = true;
			
		} else if (show_icon_table) {
			if (table_can_upgrade) {
				var piebucks_needed = table_upgrade[rrc_icon_tier - 1];
				var dbdb = tiermaster.ds_table_tiers;
				
				obj_stats.piebucks -= piebucks_needed;
				table_to_upgrade.table_tier += 1;
			
				//find oven to store variables in
					var ii = 0; repeat (ds_grid_height(dbdb)) {
					
						var cx = table_to_upgrade.x;
						var cy = table_to_upgrade.y;
					
						var px = dbdb[# 0, ii];
						var py = dbdb[# 1, ii];
					
						if (cx == px and cy == py) {
							dbdb[# 2, ii] = table_to_upgrade.table_tier;
							//show_debug_message("stored tier in table with coordinates " + string(px) + " " + string(py));
							break;
						}
						ii += 1;	
					}
				//show_debug_message("table upgraded to tier " + string(table_to_upgrade.table_tier) + " with" + string(piebucks_needed));
				reroom_confirm_purchase = false;
				
			} else reno_new_notif = true;
		}
	}
	
	
	
	if (keyboard_check_pressed(vk_escape)) {
		if (reroom_confirm_purchase) {
			reroom_confirm_purchase = false;
			
		} else {
			
			
			//WAS NOT WORKING
			with (tiermaster) {
				ds_map_replace(saver.save_data_map, "table tiers", ds_grid_write(ds_table_tiers));
				ds_map_replace(saver.save_data_map, "oven tiers", ds_grid_write(ds_oven_tiers));
		
			}
			
			editing_room = false;
			room_goto(rm_attic);
			
			alarm[0] = 1;
		}
	}
	
}

*/
#endregion