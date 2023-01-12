

if (daycycle.time_pause) exit;

var day_hours = daycycle.hours;

//set spawn phase frequencies
#region phases and spawning

endofday = false;
not_serving = false;
pprevious = pstart;

if (day_hours >= spawn_phase.first and day_hours <= spawn_phase.second) {			//first phase
	pstart = spawn_phase.first;
	pend = spawn_phase.second;
	spawn_random = 1;
	spawn_these = spawn_frequency[0];
	
} else if (day_hours > spawn_phase.second and day_hours <= spawn_phase.third) {		//second phase
	pstart = spawn_phase.second;
	pend = spawn_phase.third;
	spawn_random = 3;
	spawn_these = spawn_frequency[1];
	
} else if (day_hours > spawn_phase.third and day_hours <= spawn_phase.fourth) {		//third phase
	pstart = spawn_phase.third;
	pend = spawn_phase.fourth;
	spawn_random = 2;
	spawn_these = spawn_frequency[2];
	
} else if (day_hours > spawn_phase.fourth and day_hours <= spawn_phase.fifth) {		//fourth phase															//fourth phase
	pstart = spawn_phase.fourth;
	pend = spawn_phase.fifth;
	spawn_random = 4;
	spawn_these = spawn_frequency[3];
	
} else if (day_hours > spawn_phase.fifth or day_hours <= spawn_phase.endday) {		//fifth phase
	pstart = spawn_phase.fifth;
	pend = spawn_phase.endday;
	spawn_random = 2;
	endofday = true;
	
	if (day_hours <= spawn_phase.endday) {
		day_hours += 24;
	}
	spawn_these = spawn_frequency[4];
	
} else if (day_hours > spawn_phase.endday and day_hours < spawn_phase.first) { //spawn_these does not exist as an array - should be in attic
	not_serving = true;
	
	//sets daycycle time increment as slow as real time
	if (day_hours < daycycle.begin_day and day_hours > spawn_phase.endday) daycycle.dday = 1; 
	
	
}

#endregion

if (not_serving) exit;

#region set intervals
//DO NOT RUN THE CODE ONLY ONCE OR ELSE THE LOCAL VARIABLES WILL BE DESTROYED
//set spawn array to find which time intervals to spawn each instance in
if (!endofday) {
	var interval = (pend - pstart) / spawn_these;
	var spawn_set = 0;
	
	var ii = 0; repeat (spawn_these) {
		spawn_set[ii] = pstart + (interval * ii);
		ii += 1;
	}
	
} else {
	var interval = ((24 - pstart) + pend) / spawn_these;
	var spawn_set = 0;
	
	var ii = 0; repeat (spawn_these) {
		spawn_set[ii] = pstart + (interval * ii);
		ii += 1;
	}
}


if (mouse_check_button_pressed(mb_left)) {
	//show_debug_message("------------");
	var ddd = 0; repeat (array_length(spawn_set)) {
		//show_debug_message("spawn interval " + string(spawn_set[ddd]));
		ddd += 1;
	}
	//show_debug_message("------------");
}
#endregion set intervals


#region -------------TOGGLE SPAWNER

//CHECK FOR WHEN SPAWN NUMBER IS INCREMENTED

//customer hasnt spawned yet and hours are within bounds of spawn interval
if (!done_spawned and day_hours >= pp and pp != -1) {
	spawn_clusters = true;
	done_spawned = true;
	spawn_number += 1;
	
	//show_debug_message("toggled spawn " + string(spawn_number) + " in total");
}

//check if moved into next phase
if (pprevious != pstart) {
	done_spawned = false;
	spawn_number = 0;
	pp = -1;
	intint = 0;
	//show_debug_message(" ");
	//show_debug_message("------------NEXT PHASE");
	
}

//moved into next spawn interval - can spawn again
if (intint != array_length(spawn_set) - 1) {
	if (day_hours >= spawn_set[intint] + interval and pp != -1) {
		done_spawned = false;
		pp = -1;
		intint += 1;
	
		//show_debug_message("moved into next spawn interval");
		//show_debug_message("current time " + string(day_hours));
		//show_debug_message("next interval " + string(spawn_set[intint] + interval));
	}
}

// DO NOT USE spawn_set[intint + 1] IN CASE IT GOES OUT OF BOUNDS - USE + INTERVAL
//choose a random point at which to toggle the spawner
if (pp = -1) {
	pp = random_range(spawn_set[intint], spawn_set[intint] + interval);
	//var pbbhtht = irandom_range(1, spawn_random);
	//var spawn_count = choose(1, pbbhtht); //50/50 chance of spawning 1 or pbhghbth
	spawn_count = irandom_range(1, spawn_random);
	
	if (endofday and pp > 24) {
		pp -= 24;
		//show_debug_message("pp subtracted");
	}
	
	//show_debug_message("spawn count set to " + string(spawn_count));
	//show_debug_message("reset spawn time to " + string(pp));
	//show_debug_message(" ");
}

#endregion


//par_customer gets lineline from spawner object
//change lineline if necessary
//var lineline_cur = floor(total_spawned/5);
//lineline = lineline_og - (lineline_dist * lineline_cur);



#region CREATE CUSTOMER

if (spawn_clusters) { //keyboard_check_pressed(ord("U"))
	repeat (spawn_count) { //relies on pp being set
		lined_up += 1;
		cluster_count += 1;
		cluster_number = irandom_range(1, cluster_count_max);
		inc = 0;
		pie_slice = whole_pie;
		slices_array = array_create(cluster_number);
		leftmost = room_width;
		rightmost = 0;
	
		//show_debug_message(string(lined_up) + " lined up");
	
		
		// ds grid stores id and data on each customer in cluster
		var _dd = ds_grid_create(4, cluster_number);
		ds_grid_clear(_dd, -1);
		
	
		repeat (cluster_number) {
			spawn_x = obj_spawn.x + irandom_range(0, 60);
			spawn_y = obj_spawn.y + irandom_range(-32, 32);
		
			var inst = instance_create_layer(spawn_x, spawn_y, "Instances", obj_customer);
			//show_debug_message("customer " + string(ii + 1) + " created");
			
			
			//set variables of each customer
			with (inst) {
				var i = other.inc;
				var current_leftmost = other.leftmost;
				var current_rightmost = other.rightmost;
				
				cluster = other.cluster_count; //which cluster
				cluster_number = other.cluster_number; //how many total customers in cluster
				customer_id = i + 1;
				//customer_id = (other.cluster_count * 100) + i + 1; //unique customer_id
				other.leftmost = min(lining_x + other.spawn_x, current_leftmost);
				other.rightmost = max(lining_x + other.spawn_x, current_rightmost);
				line_up_id = other.lined_up;
			
				spawn_x = other.spawn_x;
				spawn_y = other.spawn_y;
				
				eating_frame = random_range(0, eating_framenum - 1);
			
				if (i != (cluster_number - 1)) { //if customer is not the last one being created
					pie_slice = get_pie_slice(other.pie_slice, i, other.array_possible_slices);
				
					other.pie_slice = other.pie_slice - pie_slice;
				
				} else {
					//show_debug_message("last customer given last piece of pie");
					pie_slice = other.pie_slice;
					other.pie_slice = other.pie_slice - pie_slice;
				
				}
			
				//store slice given in array
			
				other.slices_array[i] = pie_slice;
				//show_debug_message(" ");
				//show_debug_message(string(pie_slice) + " slice given to customer");
				//show_debug_message(string(other.pie_slice) + " pie left in total");
				//show_debug_message(string(other.slices_array[i]) + " slice stored in array");
				//show_debug_message(" ");
			
				
				set_table_position(i, cluster_number); //SETS TABLE POSITION
			
				_dd[# 0, i] = id;
				_dd[# 1, i] = x;
				_dd[# 2, i] = y;
				_dd[# 3, i] = false; //whether customer is seated or not
				
				bigman = _dd[# 0, 0];		// leader id
			
			}
			inc += 1;
		}
	
		var lead = _dd[# 0, 0];
	
		with (lead) {
			leftmost_bbox = other.leftmost;
			rightmost_bbox = other.rightmost;
			is_leader = true;
			c_slices_array = other.slices_array;
			pie_wanted = irandom_range(0, tiermaster.pielist_height - 1);
			ds_cluster = _dd;
			
			//var i = 0; repeat (cluster_number) {
			//	show_debug_message(string(c_slices_array[i]) + " " + string(i) + " number slice");
			//	i += 1;
			//}
			
		}
		total_spawned += 1;
	}
	spawn_clusters = false;
}
#endregion MAKE CUSTOMER











