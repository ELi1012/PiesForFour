event_inherited();

dropping_ladder = true;
ladder_framelen = sprite_get_number(spr_ladder);
frame = 0;
frame_spd = 8;



if (obj_stats.current_room == rm_main) {
	ladder_x = 1376;
	ladder_y = 288;
} else if (obj_stats.current_room = rm_main_ext) {
	ladder_x = 1056;
	ladder_y = 480;
}