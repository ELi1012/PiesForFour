event_inherited();

dropping_ladder = true;
ladder_framelen = sprite_get_number(spr_ladder);
frame = 0;
frame_spd = 8;



if (obj_stats.room_extended == false) {
	ladder_x = 1376;
	ladder_y = 288;
} else if (obj_stats.room_extended == true) {
	ladder_x = 1056;
	ladder_y = 480;
}

// set coordinates
x = ladder_x;
y = ladder_y;

function draw_ladder(_x, _y) {
	
	if (dropping_ladder) {
		frame += frame_spd;
		if (frame/room_speed >= ladder_framelen) {
			dropping_ladder = false;
			frame = (ladder_framelen - 1) * room_speed;
		}
	}

	draw_sprite(spr_ladder, floor(frame/room_speed), _x, _y);
}

function draw_glow(cx, cy) {
	draw_ladder(x - cx, y - cy);
}