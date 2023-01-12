event_inherited();

picked_up = false;
has_been_cut = false;

//pie type set by customer
pie_type = 0;
pie_trash = false;

trashed_timer = 0;
trashed_max = 3;

// stores degree angles of cuts instead of slices
// allows piecutter to recut pie if needed without converting back from slices to angles
// convert to slices when given to customer
// being a ds list is useful for sort function
// less converting back and forth between arrays and ds lists
cutline_array = ds_list_create();


//draw
pie_size = 64;
pie_xoffset = sprite_get_xoffset(spr_singlepie);
pie_yoffset = sprite_get_yoffset(spr_singlepie);

// called from within player object (to avoid pies running this multiple times per frame)

function pie_pickup() {
	
	if (keyboard_check_pressed(vk_space)) {
			// add id to ds list
			with (obj_player) {
				var d = ds_pie_carry;
				var num = ds_list_size(d);
				if (num < max_pie_carry) {
					//show_debug_message("picked up pie");
					ds_list_add(d, other.id);
					
					other.picked_up = true;
					other.draw_using_depth = false;
					other.visible = true;
				}
			}
	}
}

function pie_interact(_is_topmost, _index, _picked_up_pie) {
	// move pie with player
	with (obj_player) {
		other.x = x - x_offset + (sign(moveX) * piex_offset) + 32;
		other.y = y - y_offset + 42;
	}
	
	
	// pie is at top of stack
	if (_is_topmost and !_picked_up_pie) {
	
		// check for for furniture
		var inst = instance_place(x, y, par_furniture);
	
		var space_pressed = keyboard_check_pressed(vk_space);
		var interacted_with = false;
		var dd = obj_player.ds_pie_carry;
	
	
		if (inst != noone) {
			//show_debug_message(object_get_name(inst.object_index));
			interacted_with = true;
			switch (inst.object_index) {
				case obj_garbage:
					if (space_pressed) {
						if (pie_trash) {
							ds_list_delete(dd, _index);
							instance_destroy();
						}
						// set pie_trash = true here
						pie_trash = true;
						//show_debug_message("trashing");
					}
				
					break;
				case obj_piecutter:
					#region interact with piecutter
						
						obj_piecutter.mouse_above = true;
		
						//with (obj_garbage) if (instance_place(x, y, other.id)) trashing = true;
						//if (place_meeting(x, y, obj_garbage)) trashing = true;
		
						if (space_pressed and !pie_trash) {
			
							if (obj_piecutter.cutting_pie = false) {// and !has_been_cut) {
								
								daycycle.draw_daylight = false;
								
								//pass own variables to piecutter
								with (obj_piecutter) start_cutting_pie();
							}
						}
					#endregion
					break;
			
				case obj_table:
					// inst is a table
					if (space_pressed) {
						with (inst) {
							if (claimed)	{
								table_pie = other.id;
								ds_list_delete(dd, _index);
							}
							
							else			interacted_with = false;
						}
					}
					break;
				
				default:
					interacted_with = false;
					break;
			}
		}
	
		// double press space to trash
		// if second press doesnt come in time the pie stays
		if (pie_trash) {
			trashed_timer += 1;
			if (trashed_timer/room_speed >= trashed_max) {
				trashed_timer = 0;
				pie_trash = false;
			}
		}
		
		//deselect if not colliding with anything
		// pie is not a collision object
		if (!interacted_with and space_pressed) {
			// collision check won't work if done with pie because player is holding pie
			// check for collision from player
			var _colliding = false;
			

			
			// check for collision with any furniture
			if (place_meeting(x, y, obj_collision)) {
				var inst = instance_place(x, y, obj_collision);
				
				if (!(inst == noone or inst.object_index == obj_player)) {
					_colliding = true;
				}
			}
			
			// check for collision with ovens
			// will not work with regular place meeting checks due to collision checking
			if (!_colliding and place_meeting(x, y - 6, par_oven)) {
				_colliding = true;
			}
			
			// deselect pie if not colliding with anything else
			// and if a pie was not picked up by player
			if (!_colliding) {
				
				ds_list_delete(dd, _index);
				picked_up = false;
				draw_using_depth = true;
				visible = false;
				//show_debug_message("deselected pie");
			}
		}
	}
}

// function is called from player object if holding pie
// allows input from player object
// default position (if xoffset, yoffset are 0) is at the player's hands
function draw_pie(_xoffset, _yoffset, _alpha) {
	
	var spr_pp = tiermaster.pie_sprite;
	var spr_pplen = 4;
	var pie_xx = pie_type mod spr_pplen;
	var pie_yy = pie_type div spr_pplen;

	
	// all pies are located the same place while being held
	// are drawn at varying heights
	var xx = x - pie_xoffset;
	var yy = y - pie_yoffset;

	var pie_ind = 0;
	if (!has_been_cut) pie_ind = 0;
	else pie_ind = 1;

	// draw pie
	draw_sprite_part_ext(spr_pp, pie_ind, pie_xx * pie_size, pie_yy * pie_size, pie_size, pie_size, 
					xx + _xoffset, yy - _yoffset, 1, 1, c_white, _alpha);



	//draw_circle(x, y, 3, false);
	//draw_rectangle(bbox_right, bbox_top, bbox_left, bbox_bottom, true);
	
	
}