/// @desc other functions

function state_change(_prev_state, _new_state) {
	if (_prev_state == state_lining or _prev_state == state_ordering or _prev_state == state_waiting) {
		if (c_timer/room_speed >= impatience_limit and !angered) {
			show_debug_message("impatience limit reached - " + string((c_timer/room_speed)/60) + " minutes have passed");
			impatience += 1;
			time_given -= impatience_penalty * impatience;
			impatience_limit = (2/3) * time_given;
			//character_sprite = spr_customer_i1;
			show_debug_message("time given is now " + string(time_given/60) + " minutes");
		}
	}
	
	// customers in line move forward
	if (_prev_state == state_lining and is_leader) {
		obj_spawner.lined_up -= 1;
		
		if (instance_exists(par_customer)) {
			with (par_customer) {
				if (state == state_lining and line_up_id != 1) line_up_id -= 1;
			}
		}
	}
	
	if (_new_state != state_leaving) character_sprite = spr_customer;
	if (_prev_state != state_ordering) c_timer = 0;
	
	// movement related timer resets won't cause trouble if state does not change mid movement
	collision_timer = 0;
	goal_timer = 0;
	
}

function customer_rating(_is_angered) {
	show_debug_message("angered: " + string(_is_angered));
	#region cock rating
		//(_))===================================D~~~~~~~
		////////////////////////////////////////////
		///////---------FINAL RATING---------///////
		////////////////////////////////////////////
	//(_))=======================================D~~~~~~~
	//calculate in percentage first then add 1
	var wait_time = c_timer/room_speed;
	var wait_bonus_max = 3/4;
	var wait_time_avg = time_given * wait_bonus_max; //starts subtracting rating if customer waits into 3/4 of given time
	var wait_divider = time_given * 2;
			
	// check if wait time is greater than wait_time_avg
	if (wait_time > wait_time_avg) wait_divider = time_given;
	//if (sign(wait_time_avg - wait_time) == -1) wait_divider = time_given;
			
			
	var wait_rating = (wait_time_avg - wait_time)/wait_divider;
	//show_debug_message("wait rating is 1 + " + string(wait_time_avg) + " - " + string(wait_time) + " / (" + string(time_given)
	//	+ " * 2)");
	show_debug_message(" ");
	show_debug_message("wait rating calculated is 1 + " + string(wait_rating));
				
				
	//piebucks given
	
		var final_piebucks;
		
		// give no  money if customer angered
		if (_is_angered) final_piebucks = 0;
		else {
			
			var p = pie_wanted;		// scope might act up
			var initial_piebucks = tiermaster.tier_ds[# 1, p]
			
			//dont leave less than 0.1 of initial piebucks
			//give no more than half of initial piebucks (unless customer angered)
		
			var wait_bonus = clamp(wait_rating, -0.9, 0.5);
			var final_piebucks = ceil(initial_piebucks * (1 + wait_bonus));
			
			show_debug_message(" ");
			show_debug_message("wait multiplier for piebucks " + string(wait_bonus));
			show_debug_message("initial piebucks " + string(initial_piebucks));
			
		}

		show_debug_message("final piebucks " + string(final_piebucks));
		
		obj_stats.piebucks += final_piebucks;
					
				
	//rating given
		
		//reduce rating by up to half according to tier
		var rating_limit = tiermaster.max_rating/4; //will reduce rating when current rating hits a certain number
		var current_rating = obj_stats.rating;
		var current_ratingx = 0;
				
		//gives value between 0 and 0.5
		if (current_rating >= rating_limit) {
			current_ratingx = ((current_rating - rating_limit)/(tiermaster.max_rating - rating_limit)) * 0.5;
			show_debug_message("rating penalty before adjusting " + string(current_ratingx));
					
			//will never go into the negatives - avoids giving positive rating
			current_ratingx = clamp(current_ratingx, 0, 0.5); 
		}
				
		// rating multipliers all given in percentages
		// are multipliers to the base rating
		var imp_penalty = impatience * 0.2;
		var wait_mrating = max(wait_rating, -tiermaster.base_rating);
		var dirtytable_penalty = 0;
		var anger_penalty = 0;
		
		if (given_dirtytable) dirtytable_penalty = 0.1 * obj_stats.tier; // scale based on tier
		if (_is_angered) {
			wait_mrating = 0;		// no bonus for wait time if angered
			anger_penalty = 0.15 * obj_stats.tier;
		}
			
		var final_multiplier = 1 - current_ratingx + wait_mrating - imp_penalty - dirtytable_penalty - anger_penalty;
		
		if (_is_angered) final_multiplier = final_multiplier - 1;	// negative multiplier
					
		show_debug_message(" ");
		show_debug_message("rating penalty according to current rating " + string(current_ratingx));
		show_debug_message("wait multiplier for rating " + string(wait_mrating));
		show_debug_message("rating penalty for dirty table " + string(dirtytable_penalty));
		show_debug_message(" ");
					
		obj_stats.day_rating += tiermaster.base_rating * final_multiplier;
					
		show_debug_message("final day rating " + string(tiermaster.base_rating * final_multiplier));
		show_debug_message(" ");
		show_debug_message(" ");
				
	#endregion
	
}

function customer_angered() {
	// leave rating if leader
	if (is_leader) {
		customer_rating(true);
		
		if (set_table != -1) {
			with (set_table) {
				claimed = false;
				pie_todraw = -1;
			}
		}
	}
	
	angered = true;
	state_change(state, state_leaving);
	state = state_leaving;
	
	remove_from_checklist = true;
	character_sprite = spr_customer_angry;
	
	// have some variation
	if (irandom_range(1, 3) == 1) character_sprite = choose(spr_customer_i1, spr_customer_i2);
	
}

function check_pie_accuracy(_pie_id) {
	var given_right = false;
	var pieslices;
			
			
	// no slices made if number of cuts is less than 2
	// in such cases set array[0] = 240
	if (ds_list_size(_pie_id.cutline_array) < 2) {
		pieslices[0] = 240;
	} else {
		// takes ds list as input; outputs array
		pieslices = degrees_to_slices(_pie_id.cutline_array);
				
	}
			
			
	var c_wanted = sort_array(c_slices_array, true);
	var c_given = sort_array(pieslices, true);
			
	var c_wanted_len = array_length(c_wanted);
	var c_given_len = array_length(c_given);
			
		
	//show_debug_message(string(c_wanted_len) + " c wanted length");
	//show_debug_message(string(c_given_len) + " c given length");
			
	//var ii = 0; repeat (c_given_len) {
	//	show_debug_message(string(c_given[ii]) + " " + string(ii) + " given slice");
	//	ii += 1;
	//}
			
	//show_debug_message(" ");
			
	//var ii = 0; repeat (c_wanted_len) {
	//	show_debug_message(string(c_wanted[ii]) + " " + string(ii) + " wanted slice");
	//	ii += 1;
	//}
		
	// same number of slices as requested
	if (c_wanted_len == c_given_len) {
		var dd = 0; repeat (c_wanted_len) {
			given_right = true;
			//show_debug_message(string(c_given[dd]) + " c given, " + string(c_wanted[dd]) + " c wanted");
			
			// check if slices are the right size
			if (c_given[dd] != c_wanted[dd]) {
				//show_debug_message("c given array did not match c wanted");
				given_right = false;
				break;
			}
			dd += 1;
		}
				
	} else if (c_wanted_len != c_given_len) {
		given_right = false;
		//show_debug_message("c array heights did not match");
	}
			
	if (_pie_id.pie_type != pie_wanted) {
		given_right = false;
		//show_debug_message("not given right pie type");
	}
	return given_right;
}