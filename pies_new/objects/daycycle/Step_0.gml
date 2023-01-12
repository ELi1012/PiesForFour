
if (global.game_pause or obj_catalogue.editing_room) exit;
//if(keyboard_check_pressed(ord("T"))) time_pause = !time_pause;

#region check if player can leave room
can_leave_room = false;

if (room == rm_main or room == rm_main_ext) {
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
	
} else if (room == rm_attic) {
	if (hours >= begin_day) can_leave_room = true;
	if (dropped_ladder) dropped_ladder = false;
}
#endregion



if (time_pause) exit;

time_increment = dday;

speedup_time = false;
if (keyboard_check(vk_right)) {
	
	//fast forward time if hours are between 6 and 7
	//if (hours >= begin_day and hours < spawn_phase.first) 
	time_increment = dday * speedup_factor;
	speedup_time = true;
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
	
	// need to account for nighttime hours > sunrise hours
	if (current_phase != phase.nighttime and hours > next_phase) switch_phase(next_phase);
	else if (current_phase == phase.nighttime and hours < phase.daytime and hours > phase.sunrise) switch_phase(next_phase);
	
	#endregion
	//-------------------------------------------
	#region alter colours and darkness depending on time
	var darks, colours, pstart, pend;
	darks = opacity_array;
	colours = colour_array;
	pstart = current_phase;
	pend = next_phase;
	
	//colours
	if (pstart == phase.nighttime) { light_colour = colours[0]; }
	else {
		
		// cc picks a colour from the colour array depending on how far the hour is in the current cycle
		var cc = ((hours - pstart) / (pend - pstart)) * (array_length(colours) - 1);
		
		var c1 = colours[floor(cc)];
		var c2 = colours[ceil(cc - 0.1)]; //cc - 0.1 prevents ceil from rounding a whole number to the next
		
		light_colour = merge_color(c1, c2, cc - floor(cc));
	}
	
	//darkness
	if (pstart == phase.nighttime) { darkness = darks[0]; }
	
	else {
		var dd = ((hours - pstart) / (pend - pstart)) * (array_length(darks) - 1);
		var d1 = darks[floor(dd)];
		var d2 = darks[ceil(dd - 0.1)];
	
		darkness = merge_number(d1, d2, dd - floor(dd));
		
	}
	
	#endregion
	
	
}


