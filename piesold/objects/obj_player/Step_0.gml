
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



//------------ALTER SPEED
if (input_walk or input_run) {
	spd = abs((input_walk * w_spd) - (input_run * r_spd));
} else {
		spd = n_spd;
}

//------------INTENDED MOVEMENT

moveX = (input_right - input_left) * spd;

if (moveX == 0) { moveY = (input_down - input_up) * spd; }

//------------COLLISION CHECK
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

// OBJECTS
if (place_meeting(x, y, obj_transition) and keyboard_check_pressed(vk_space) and daycycle.can_leave_room) {
	var inst = instance_place(x, y, obj_transition);
	var target_room = inst.targetRoom;
	var sx = inst.targetX;
	var sy = inst.targetY;
	
	if (inst.leads_downstairs) {
		target_room = obj_stats.current_room;
		sx = obj_stats.target_x;
		sy = obj_stats.target_y;
		
	}
	
	with (obj_game) {
		spawnRoom = target_room;
		room_goto(spawnRoom);
		spawnX = sx;
		spawnY = sy;
	} 
}

// returns id if collision occurs at x, y
// goes into the game object and sets its spawnRoom variable as inst.targetRoom
// . operator: takes the variable (targetRoom) that belongs to an instance (inst)


//change x y coordinates of pie if selecting
if (pie_selected != -1) {
	if (instance_exists(pie_selected)) {
	
		//displace by half if shifting in other direction
		pie_selected.x = x - x_offset + (sign(moveX) * piex_offset);
		pie_selected.y = y - y_offset;
		
	} else pie_selected = -1;
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

