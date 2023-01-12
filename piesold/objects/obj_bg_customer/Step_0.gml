if (state == wandering) {
	timer += 1;
	moveX = dir * spd;
	
	if (timer/room_speed >= timer_max) {
		var f = choose(0, 1);
		if (f == 0) {
			state = idle;
			moveX = 0;
			timer = 0;
			dir = choose(-1, 1);
		}
		
		timer = 0;
	}
	
} else if (state == idle) {
	timer += 1;
	
	if (timer/room_speed >= timer_max) {
		var f = choose(0, 1, 2);
		if (f == 0) state = wandering;
		
		timer = 0;
	}
}

x += moveX;

if (x > room_width or x < 0) instance_destroy();