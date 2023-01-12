
if (global.game_pause or obj_catalogue.renovating) exit;
//if(keyboard_check_pressed(ord("T"))) time_pause = !time_pause;

//check if player can transition
can_leave_room = false;

if (room == obj_stats.current_room) {
	if (hours > spawn_phase.endday and hours < begin_day) {
		can_leave_room = true;
		
		if (!dropped_ladder) {
			instance_create_layer(0, 0, "Instances", obj_ladder);
			dropped_ladder = true;
		}
		
		
		obj_stats.player_pill = spr_player;
		
		//if player does not exist it will wait until it does
		if (instance_exists(obj_player)) {
			if (obj_player.spr_pill != spr_player) obj_player.spr_pill = spr_player;	
		}
	}
} else if (room == rm_attic and hours >= begin_day) can_leave_room = true;

if (room == rm_attic and dropped_ladder) dropped_ladder = false;


if (time_pause) exit;

time_increment = dday;

if (keyboard_check(vk_right)) {
	
	//fast forward time if hours are between 6 and 7
	//if (hours >= begin_day and hours < spawn_phase.first) 
	time_increment = dday * 20;
	
}

//if (keyboard_check_pressed(vk_f2)) {
//	if (!can_leave_room and room != rm_attic) seconds = 2.5 * 3600;
//}


//jump ahead by 6 hours
//if (keyboard_check_pressed(ord("O"))) seconds += 6*(3600);


//increment time
seconds += (1/room_speed) * time_increment;
minutes = seconds/60;
hours	= minutes/60;

if (hours >= 24) seconds = 0;


if (draw_daylight) {
	#region phases and variables
	var darks, colours, pstart, pend;
	
	if (hours > phase.sunrise and hours <= phase.daytime) {			//sunrise
		darks	= [max_darkness, 0.2];
		colours = [merge_color(c_black, c_navy, 0.3), c_orange];
		pstart = phase.sunrise;
		pend = phase.daytime;
	} else if (hours > phase.daytime and hours <= phase.sunset) {	//daytime	
		darks	= [0.2, 0, 0, 0, 0.2];
		colours = [c_orange, c_orange, c_white, c_orange, c_orange];
		pstart = phase.daytime;
		pend = phase.sunset;
	} else if (hours > phase.sunset and hours <= phase.nighttime) {	//sunset
		//IF HOURS < OR EQUAL TO NIGHTTIME ARRAY WILL BE OUT OF BOUNDS
		darks	= [0.2, max_darkness];
		colours = [c_orange, c_navy, merge_color(c_black, c_navy, 0.3)];
		pstart = phase.sunset;
		pend = phase.nighttime;
	} else {														//nighttime
		darks	= [max_darkness];
		colours = [merge_color(c_black, c_navy, 0.3)];
		pstart = phase.nighttime;
		pend = phase.sunrise;
	}
	#endregion
	//-------------------------------------------
	#region alter colours and darkness depending on time
	//colours
	if (pstart == phase.nighttime) { light_colour = colours[0]; }
	else {
		
		var cc = ((hours - pstart) / (pend - pstart)) * (array_length_1d(colours) - 1);
		//if (keyboard_check_direct(vk_space)) {
		//	show_debug_message(string(cc) + " cc");
		//	show_debug_message(string(ceil(cc - 0.1)) + " cc ceil");
		//}
		
		var c1 = colours[floor(cc)];
		var c2 = colours[ceil(cc - 0.1)]; //cc - 0.1 prevents ceil from rounding a whole number to the next
		
		light_colour = merge_color(c1, c2, cc - floor(cc));
	}
	
	//darkness
	if (pstart == phase.nighttime) { darkness = darks[0]; }
	
	else {
		var dd = ((hours - pstart) / (pend - pstart)) * (array_length_1d(darks) - 1);
		var d1 = darks[floor(dd)];
		var d2 = darks[ceil(dd - 0.1)];
	
		darkness = merge_number(d1, d2, dd - floor(dd));
		
	}
	
	#endregion
	
	
}


