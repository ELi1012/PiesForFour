///@desc archived code


#region wardrobe cell drawer
/*
//CREATE EVENT
wd_grid_height_spr = sprite_get_height(spr_wd_grid);
wd_grid_height_ui = wd_bg_height - wd_grid_y;
wd_grid_height_page = wd_grid_vblocks * (cell_size + cell_ybuff); //total height of cell blocks
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
var full_sprites = wd_grid_vblocks div wd_grid_height_blocks;
var ii = 0; repeat (full_sprites) {
	draw_sprite(spr_wd_grid, 0, wd_grid_x, wd_grid_y + (ii * (wd_grid_height_spr - cell_ybuff)) - mouse_scroll);
	ii += 1;
}

var separated_sprite = wd_grid_vblocks mod wd_grid_height_blocks;
if (separated_sprite != 0) {
	var spspy = wd_grid_y + ((full_sprites * (wd_grid_height_spr - cell_ybuff))) - mouse_scroll;
	
	draw_sprite_part(spr_wd_grid, 0, 0, (separated_sprite - 1) * cell_withbuffy, wd_grid_width, cell_withbuffy * separated_sprite,
		wd_grid_x, spspy);
	
	//draw the little bit at the end
	draw_sprite_part(spr_wd_grid, 0, 0, 0, wd_grid_width, cell_ybuff,
		wd_grid_x, spspy + (cell_withbuffx * separated_sprite));
}
*/
#endregion wardrobe cell drawer








#region old pie selecting code

	//check for instances of pie cutter
	//code will not run if table is clicked while order taken
	//pie inst is already created when customer order is taken
	
	/*
	if (mouse_wheel_up()) {
		pie_scroll += 1;
		if (pie_scroll >= pies.height) { pie_scroll = 0; }
		
	} else if (mouse_wheel_down()) {
		pie_scroll -= 1;
		if (pie_scroll < 0) { pie_scroll = pies.height - 1; }
		
	}
	
	draw_sprite_part(spr_pies, 0, pie_scroll*pie_width, 0, 64, 64, mouse_x, mouse_y);
	
	*/

#endregion





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

#region checking for tables
/*
//----------PAR_CUSTOMER || CHECK FOR EMPTY TABLES
//initialize table instances grid
ds_tables = ds_grid_create(2, 1);
ds_tables[# 0, 0] = 0; //buffer
ds_tables[# 1, 0] = 0;
	

with (obj_table) {
		
	if (!claimed and !counted) { //counts number of unclaimed tables
			
		var dt = other.ds_tables;
		var g_height = ds_grid_height(dt); //current height
		ds_grid_resize(dt, 2, g_height + 1); //resized height

			
		dt[# 0, g_height] = x;
		dt[# 1, g_height] = y - sprite_get_yoffset(spr_table);

		show_debug_message(string(g_height) + " open");
		counted = true;


	}
			
	//draw table arrow
	if (!claimed) {
		var aw = par_customer.arrow_width;
		var ah = par_customer.arrow_height;
			
		draw_sprite_part(spr_selected, 0, floor(arrow_frame)*aw, 0, aw, 
		ah, x + (table_width/2) - (aw/2), y - sprite_get_yoffset(spr_table) - ah);
			
		arrow_frame += anim_speed/60;
		if (arrow_frame >= 5) { arrow_frame = 0; }
	}
}
*/
#endregion checking for tables