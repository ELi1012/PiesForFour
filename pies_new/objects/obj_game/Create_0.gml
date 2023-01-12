randomize();
//room_goto_next();
room_goto(rm_main);

cellSize = 32;


//DEBUG TOGGLES
debug = false;
global.game_pause = false;
global.using_escape = false;
global.no_moving = false;

// set time in daycycle create

pause_state_prev = global.using_escape;
draw_set_font(fnt_default);



enum note_symbols {
	
	whole				= 0,
	half				= 1,
	quarter				= 2,
	eighth				= 3,
	sixteenth			= 4,
	dotted_half			= 5,
	dotted_quarter		= 6,
	dotted_eighth		= 7,
	dotted_dottedhalf	= 8,
	dotted_dottedquarter = 9,
	height				= 10
	
	
}


spawnRoom = -1;
spawnX = 0;
spawnY = 0;


//store attic spawn coordinates
default_target_x = 1312;
default_target_y = 310;

ext_target_x = 1120;
ext_target_y = 500;

target_x = default_target_x;
target_y = default_target_y;

enum table_pos {
	table_left,
	table_right,
	table_middle,
	table_topright,
	table_topleft
}


