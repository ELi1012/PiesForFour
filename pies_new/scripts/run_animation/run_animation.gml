// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function run_animation(_sprite, frame, frame_spd, xpos, ypos){
	
	draw_sprite(_sprite, floor(frame), xpos, ypos);
	frame += frame_spd/room_speed;
	
	// check if frames have gone over limit
	var len = sprite_get_number(_sprite);
	if (frame/room_speed >= len) frame = 0;
	
	return frame;
}