init_x += spd * dir;

var sf = frame_len * car_type;

frame += frame_spd;
if (frame/room_speed >= frame_len + sf) frame = sf * room_speed;


x = init_x + (global.camerax * 0.9);

if (x > room_width or x < -64) instance_destroy();