draw_sprite(spr_type, floor(frame/room_speed), x, y);


frame += frame_spd;
if (frame/room_speed >= frame_len) frame = 0;
