
if (state == 0) {
	frame = 0;
	counter++;
	
	moveX = 0;
	moveY = 0;
	
	if (counter >= room_speed * 2) {
		flip = choose(0, 1);
		switch (flip) {
			case 0: 
				state = states.wandering;
				show_debug_message("state wandering");
			
			case 1:
				counter = 0;
				break;
		}
	}
} else if (state == 1) {
	counter++;
	
	
	if (counter >= room_speed * 3) {
		flip = choose(0, 1);
		
		switch (flip) {
			case 0: 
				state = states.idle;
				show_debug_message("state idle");
			
			case 1:	
				dir = irandom_range(0, 359);
				moveX = lengthdir_x(spd, dir);
				moveY = lengthdir_y(spd, dir);
				
				counter = 0;
				break;
		}
	}
	
	nearby = collision_circle(x, y, r, par_customer, false, false);
	if (nearby != noone) {
		state = states.alert;
	}
	
} else if (state == 2) {
	
	pDir = point_direction(x, y, nearby.x, nearby.y);
	
	if (nearby != noone) {
		moveX = lengthdir_x(spd, pDir);
		moveY = lengthdir_y(spd, pDir);
		
	} else { state = states.idle; }
	
}

if (moveX != 0 and moveY != 0) {
	fInc++;
	
	if (fInc <= (frameNum + 1) * frameSpd) {
		frame = floor(fInc);
		
	} else { fInc = 0 }
	
}




//------------COLLISION CHECK
// HORIZONTAL
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

//------------APPLY MOVEMENT
x += moveX
y += moveY