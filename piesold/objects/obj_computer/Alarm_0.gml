var ind = 0;
glow_timer += 1;
	
if (glow_timer/room_speed >= 3) {
	if (!flicker) {
		var c = choose(1, 2, 3);
		if (c == 1) flicker = true;
	} else flicker = false;
		
	glow_timer = 0;
}
	
if (flicker) {
	fframe += glow_spd;
	if (fframe/room_speed >= c_len) {
		fframe = 0;
		flicker = false;
	}
		
	ind = floor(fframe/room_speed);
}
	
draw_sprite(spr_computer_glow, ind, x, y);
	
	