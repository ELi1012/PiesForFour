
//show_debug_message(" ");
//show_debug_message(string(cluster) + " = cluster id /// with " + string(cluster_number) + " in the cluster");
//show_debug_message(string(customer_id) + " is customer id with " + string(table_spot) + " as table_spot");
//show_debug_message(string(leftmost_bbox) + " is leftmost bbox");
//show_debug_message(string(spawn_x) + " is spawn x");
//show_debug_message(" ");


if (global.game_pause) exit;

// by what factor to add to time
with (daycycle) {
	if (speedup_time)	other.timer_add = speedup_factor;
	else				other.timer_add = 1;
}

// run state function
state();



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
				
				if (state == state_findseat and top_of_table) { //prevents oscillation if seated at table top
					moveX = spd;
				} else moveX = spd * sign(goal_x);//table_spot_left;  //until no y collision
				
				if (place_meeting(x + moveX, y, obj_collision)) moveX = 0;
				
				moveY = 0;
				
				//show_debug_message("normal collision y");
					
			} 
		}
		
		
		
	} else if (disable_collision and !instance_place(x, y, obj_collision)) {
		//and state != state_leaving) { //sets collision back to false if not colliding - runs at start of creation
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

if (remove_from_checklist) {
	if (is_leader) {
		with (obj_checklist) {
			other.remove_from_checklist = false;
			tables_ordered -= 1;
			if (tables_ordered == 0) new_order = false;
				
			//ONLY DECREASE LIST INC IF ORDER HEIGHT (height of ds grid) IS NOT 1
			// list_inc is used to reference ds grid; cannot be less than 0
			if (orderheight > 1 and list_inc > 0) list_inc -= 1;
				
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
if (!angered and character_sprite != spr_customer_i1 and c_timer/room_speed >= impatience_limit) {
	character_sprite = spr_customer_i1;
}


