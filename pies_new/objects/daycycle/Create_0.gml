

//USE GAME OBJECT TO SPAWN DAYCYCLE INSTANCE IF USING DIFFERENT ROOMS

seconds = 7 * 3600;
minutes = seconds/60;
hours	= minutes/60;

day = 0;


time_in_day = 10; //how many real minutes a day lasts
dday = 24/(time_in_day/60);	// conversion from real hours to in game hours??
time_increment = dday;		// is multiplied by 1/room_speed to increment seconds every frame
speedup_factor = 30;			// by what factor to speed up time
speedup_time = false;

//time_increment = 1; //seconds per step
time_pause = false;

//cycle check
max_darkness	= 0.8;
darkness		= 0;					// light opacity
light_colour	= c_black;
draw_daylight	= true;				//SET BACK TO FALSE
glow_opacity	= 0;

surface = noone;

// list of all instances that draw over the daycycle
ds_glow = ds_grid_create(1, 6);
ds_glow[# 0, 0] = obj_player;
ds_glow[# 0, 1] = obj_light;
ds_glow[# 0, 2] = obj_piemachine;
ds_glow[# 0, 3] = obj_piemachine_ext;
ds_glow[# 0, 4] = obj_computer;
ds_glow[# 0, 5] = obj_ladder;


can_leave_room = false;

dropped_ladder = false;


enum phase {
	sunrise		= 5,
	daytime		= 8.5,
	sunset		= 18, 
	nighttime	= 22,
	
}

current_phase = 1;
next_phase = 1;

opacity_array = -1;
colour_array = -1;

event_user(0);

if (hours > phase.sunrise and hours <= phase.daytime) {			//sunrise
	next_phase = phase.sunrise;
} else if (hours > phase.daytime and hours <= phase.sunset) {	//daytime	
	next_phase = phase.daytime;
} else if (hours > phase.sunset and hours <= phase.nighttime) {	//sunset
	next_phase = phase.sunset;
} else {														//nighttime
	next_phase = phase.nighttime;
}

switch_phase(next_phase);


enum spawn_phase {
	
	first = 7, //if changing change room start variable
	second = 11,
	third = 15,
	fourth = 18,
	fifth = 22,
	endday = 3
	
}

//begin day evaluated to 7 when added directly to 0.5
var spfirst = spawn_phase.first;
begin_day = spfirst - 0.5;

// draw light halo around object
function draw_halo(_glow_sprite, _scale, _x, _y, cx, cy) {
		// colour doesnt matter - only punches a hole through darkness
		// _x, _y: where middle of the glow should be
		// does not account for offset
	
		var gw = sprite_get_width(_glow_sprite);
		var gh = sprite_get_height(_glow_sprite);
		var gx = _x - (gw*_scale)/2;
		var gy = _y - (gh*_scale)/2;
		
		draw_sprite_ext(spr_player_glow, 0, gx - cx, gy - cy, _scale, _scale, 0, c_white, daycycle.glow_opacity);
	
}