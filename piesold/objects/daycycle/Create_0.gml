

//USE GAME OBJECT TO SPAWN DAYCYCLE INSTANCE IF USING DIFFERENT ROOMS

seconds = 6.5 * 3600;
seconds = 2 * 3600;
minutes = 0;
hours	= 0;

day = 0;

time_in_day = 10; //how many minutes a day lasts
dday = 24/(time_in_day/60);
time_increment = dday;

//time_increment = 1; //seconds per step
time_pause = false;

//cycle check
max_darkness	= 0.7;
darkness = 0;
light_colour	= c_black;
draw_daylight	= true; //SET BACK TO FALSE
can_leave_room = false;

guiWidth	= global.game_width;
guiHeight	= global.game_height;




dropped_ladder = false;


enum phase {
	sunrise		= 5,
	daytime		= 8.5,
	sunset		= 18, 
	nighttime	= 22,
	
}

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




