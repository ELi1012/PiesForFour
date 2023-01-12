
if (global.no_moving or global.game_pause) exit;

//------------INPUT CHECK
input_left = keyboard_check(ord("A"));
input_right = keyboard_check(ord("D"));
input_up = keyboard_check(ord("W"));
input_down = keyboard_check(ord("S"));
input_walk = keyboard_check(vk_control);
input_run = keyboard_check(vk_shift);

moveX = 0;
moveY = 0;

#region movement

//------------ALTER SPEED
if (input_walk or input_run) {
	spd = abs((input_walk * w_spd) - (input_run * r_spd));
} else {
		spd = n_spd;
}

//------------INTENDED MOVEMENT

moveX = (input_right - input_left) * spd;

if (moveX == 0) { moveY = (input_down - input_up) * spd; }

#endregion

#region //------------COLLISION CHECK
// HORIZONTAL

var c_inst = instance_place(x, y, obj_collision)

if (c_inst == noone or c_inst == obj_pie) { //prevents player from getting stuck in collision object
	if (moveX != 0) {
		var collisionH = instance_place(x + moveX, y, obj_collision);
		if(collisionH != noone and collisionH.collideable) {
			repeat(abs(moveX)){
				if(!place_meeting(x + sign(moveX), y, obj_collision)) {
					x += sign(moveX);
				} else {
					break;
				}
			}
			moveX = 0;
		}
	}

	// VERTICAL
	if(moveY != 0) {
		var collisionV = instance_place(x, y + moveY, obj_collision);
		if(collisionV != noone and collisionV.collideable) {
			repeat(abs(moveY)){
				if(!place_meeting(x, y + sign(moveY), obj_collision)) {
					y += sign(moveY);
				} else {
					break;
				}
			}
			moveY = 0;
		}
	}
}

#endregion

// OBJECTS
var space_pressed = keyboard_check_pressed(vk_space);

// go to another room
if (space_pressed and place_meeting(x, y, obj_transition) and daycycle.can_leave_room) {
	
	// returns id if collision occurs at x, y
	// goes into the game object and sets its spawnRoom variable as inst.targetRoom
	// . operator: takes the variable (targetRoom) that belongs to an instance (inst)
	
	var inst = instance_place(x, y, obj_transition);
	var target_room = inst.targetRoom;
	var sx = inst.targetX;
	var sy = inst.targetY;
	
	if (inst.leads_downstairs) {
		target_room = rm_main;
		if (obj_stats.room_extended) target_room = rm_main_ext;
		
		sx = obj_game.target_x
		sy = obj_game.target_y;
		
	}
	
	with (obj_game) {
		spawnRoom = target_room;
		room_goto(spawnRoom);
		spawnX = sx;
		spawnY = sy;
	}
}

// check if colliding with pies
// can only pick up pies if ovens exist in room
if (instance_exists(par_oven)) {
	var picked_up_pie = false;
	with (obj_pie) {
		// colliding with player and hasn't been picked up yet
		if (place_meeting(x, y, obj_player) and !picked_up) {
			pie_pickup();
			picked_up_pie = true;
			
		}
	}

	// run step event for pies in list
	var d = ds_pie_carry;
	var len = ds_list_size(d);
	
	if (!ds_list_empty(d)) {
		// loop downwards so pie at top goes first
		for (var i = len - 1; i >= 0; i--) {
			var is_top = false;
			if (i == len - 1) is_top = true;
		
			with (d[| i]) {
				// piecutter, garbage can will only be used for topmost pie
				pie_interact(is_top, i, picked_up_pie);
			}
		}
	}
	
	// shuffle pies from bottom to top
	if (keyboard_check_pressed(ord("Q")) and len > 1) {
		
		// newlist stores new order of pies
		var newlist = ds_list_create();
		
		// put topmost pie on bottom of new list
		ds_list_insert(newlist, 0, d[| len - 1]);
		
		// add rest of values
		var i = 1; repeat (len - 1) {
			ds_list_insert(newlist, i, d[| i - 1]);
			i++;
		}
	
		
		// replace old list with newlist
		// ds_pie_carry = newlist only passes on reference to newlist not the list itself
		ds_list_copy(ds_pie_carry, newlist);
		ds_list_destroy(newlist);
		
	}
}


if (spr_pill == spr_sprike) {
	if (moveX != 0 or moveY != 0) {
		frame += frameSpd/60;
	
		if (frame >= frame_num) frame = 0;
		
	} else frame = 0;
}





//------------UNSTICK
/*
if (keyboard_check_pressed(vk_backspace)) {
	x = xstart;
	y = ystart;
}
*/


//------------APPLY MOVEMENT
x += moveX;
y += moveY;

