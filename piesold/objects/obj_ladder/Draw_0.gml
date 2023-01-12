
if (dropping_ladder) {
	frame += frame_spd;
	if (frame/room_speed >= ladder_framelen) {
		dropping_ladder = false;
		frame = (ladder_framelen - 1) * room_speed;
	}
}

draw_sprite(spr_ladder, floor(frame/room_speed), ladder_x, ladder_y);