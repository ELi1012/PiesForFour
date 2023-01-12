x += spd * dir;

frame += frame_spd;
if (frame/room_speed >= frame_len) frame = 0;

if (x > room_width or x < 0) instance_destroy();