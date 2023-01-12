///@desc creates cut line
///@arg rotation_degree
///@arg rotating_by
function draw_cut_line(argument0, argument1) {


	var rotation_degree = argument0;
	var rotating_by = argument1;
	var line_here = false;
	var degree_gone = 0;
	var is_between = false;
	var weird_slice = false;
	var between_point = -1;

	var lines = ds_lines;
	var dsheight = ds_grid_height(lines);
	var dswidth = ds_grid_width(lines);


	//0: pie slice number
	//1: pie degrees
	//2: pie degree boundary (lesser)
	//3: boundary (greater)
	//4: abs(closest_cut.rotate_degree - rotation_degree) > 180

	//offset from center
	var radiusx = lengthdir_x(pie_rad, rotation_degree); //pie rad is 320
	var radiusy = lengthdir_y(pie_rad, rotation_degree);

	//no line at current instance


	if (place_meeting(gui_middlex + radiusx, gui_middley + radiusy, obj_cutline)) {
		show_debug_message("line already here");
		//if not working check cutline collision mask
		return -1;
		exit;
	}


	var closest_cut = instance_nearest(gui_middlex + radiusx, gui_middley + radiusy, obj_cutline); //put this before creating the instance
	var line_inst = instance_create_layer(gui_middlex + radiusx, gui_middley + radiusy, "Instances", obj_cutline);

	//stores these variables in line inst
	with (line_inst) {
		rotate_degree = rotation_degree;
		rotate_by = rotating_by;
	}


	if (first_degree = -1) { //first degree not set
		//show_debug_message("first cut made");
		first_degree = rotation_degree;
		is_first = true;
		//show_debug_message(" ");
	
		return 0;
	
	} else { //first cut already made
	
		slices_cut += 1;
	
	#region check if current line is between an existing slice
		var j = 0; repeat (dsheight) {
			var greater_arm = lines[# 3, j];
			var lesser_arm = lines[# 2, j];
			///show_debug_message(string(j) + " j");
		
			if (slices_cut = 2) { //slice does not exist yet
				//show_debug_message("one pie slice");
				break; 
			}
		
			if (lines[# 4, j] = true) { //slice is weird
				if (rotation_degree < lesser_arm or rotation_degree > greater_arm) { //current degree within bounds of existing slice boundary
					//show_debug_message("within bounds of pie slice with weird pie");
					//show_debug_message(string(j) + " j");
					var greater_arm = lines[# 3, j];
					var lesser_arm = lines[# 2, j];
					between_point = j;
					is_between = true;
					break;
				}
			
			
			} else { //slice is normal
				if (rotation_degree > lesser_arm and rotation_degree < greater_arm) { //current degree within bounds of existing slice boundary
					//show_debug_message("within bounds of pie slice with normal pie");
					//show_debug_message(string(j) + " j");
					var greater_arm = lines[# 3, j];
					var lesser_arm = lines[# 2, j];
					between_point = j;
					is_between = true;
					break;
				
				}
			}
			j += 1;
		}
	#endregion check if current line is between an existing slice
	
		ds_grid_resize(lines, dswidth, dsheight + 1); //do this before using data grid with column dsheight
	
	
		if (is_between) {
		#region if cut is between boundaries of existing silce
			var old_degrees = -1;
			var new_degrees = -1;
		
			if (lines[# 4, between_point] = true) { //slice is weird
			
				if (rotation_degree > greater_arm and rotation_degree != 0) { //current arm in quadrant 3 or 4
					//show_debug_message("cut between weird slice and arm is in quadrant 3/4");
					old_degrees = rotation_degree - greater_arm;
					new_degrees = (360 - rotation_degree) + lesser_arm;
				
					//show_debug_message("old degrees = " + string(rotation_degree) + "(rotation degree) - " + string(greater_arm) + "(greater arm)");
					//show_debug_message("new degrees =  (360 - " + string(rotation_degree) + ") + " + string(lesser_arm) + "(lesser arm)");
				
					//old slot variables
					lines[# 1, between_point] = old_degrees;
					lines[# 2, between_point] = greater_arm; //new lesser arm
					lines[# 3, between_point] = rotation_degree; //new greater arm
					lines[# 4, between_point] = false; //slice is no longer weird
				
					//new slot variables
					//degree_gone = new_degrees; //always the top slice
					lines[# 1, dsheight] = new_degrees;
					lines[# 2, dsheight] = lesser_arm; //new lesser arm
					lines[# 3, dsheight] = rotation_degree; //new greater arm
					lines[# 4, dsheight] = true;
					
				}
			
				if (rotation_degree < lesser_arm and rotation_degree != 0) { //current arm is in quadrant 1 or 2
					//show_debug_message("cut between weird slice and arm is in quadrant 1/2");
					new_degrees = lesser_arm - rotation_degree;
					old_degrees = (360 - greater_arm) + rotation_degree;
				
					//show_debug_message("new degrees = " + string(lesser_arm) + "(lesser arm) - " + string(rotation_degree) + "(rotation degree)");
					//show_debug_message("old degrees =  (360 - " + string(greater_arm) + "(greater arm)) + " + string(rotation_degree) + "(rotation degree)");
				
					//old slot variables
					lines[# 1, between_point] = old_degrees;
					lines[# 2, between_point] = rotation_degree; //new lesser arm
					lines[# 3, between_point] = greater_arm; //new greater arm
					lines[# 4, between_point] = true; //slice is still weird
				
					//new slot variables
					//degree_gone = new_degrees; //always the top slice
					lines[# 1, dsheight] = new_degrees;
					lines[# 2, dsheight] = rotation_degree; //new lesser arm
					lines[# 3, dsheight] = lesser_arm; //new greater arm
					lines[# 4, dsheight] = false;
				
				}
			
				if (rotation_degree = 0) { //cut at degree 0
					//show_debug_message("cut between weird slice and arm is 0");
					new_degrees = lesser_arm;
					old_degrees = 360 - greater_arm;
				
					//show_debug_message("new degrees = " + string(lesser_arm) + "(lesser arm)");
					//show_debug_message("old degrees =  (360 - " + string(greater_arm) + "(greater arm))");
				
					//old slot variables
					lines[# 1, between_point] = old_degrees;
					lines[# 2, between_point] = 0; //new lesser arm //---CONDITION CANNOT BE LESSER THAN 0
					lines[# 3, between_point] = greater_arm; //new greater arm
					lines[# 4, between_point] = true; //slice is weird and lesser = 0
				
					//new slot variables
					degree_gone = new_degrees; //always the top slice
					lines[# 1, dsheight] = new_degrees;
					lines[# 2, dsheight] = 0; //new lesser arm
					lines[# 3, dsheight] = lesser_arm; //new greater arm
					lines[# 4, dsheight] = false;
				
				}
			
		
			} else { //slice is normal
				//show_debug_message("cut between normal slice");
				new_degrees = greater_arm - rotation_degree;
				old_degrees = rotation_degree - lesser_arm;
			
				//show_debug_message(string(new_degrees) + " new pie slice");
				//show_debug_message(string(old_degrees) + " old pie slice");
			
				
				//old slot variables
				lines[# 1, between_point] = old_degrees;
				lines[# 2, between_point] = lesser_arm; //new lesser arm
				lines[# 3, between_point] = rotation_degree; //new greater arm
				lines[# 4, between_point] = false;
				
				//new slot variables
				lines[# 1, dsheight] = new_degrees;
				lines[# 2, dsheight] = rotation_degree; //new lesser arm
				lines[# 3, dsheight] = greater_arm; //new greater arm
				lines[# 4, dsheight] = false;
			
			}
		#endregion //is between two slices
		
		} else { //is not between two arms
			//save degree of smallest slice
			//show_debug_message("is not between an existing slice");
			degree_gone = abs(closest_cut.rotate_degree - rotation_degree);
			//show_debug_message(string(closest_cut.rotate_degree) + " closest degree");
			//show_debug_message(string(rotation_degree) + " current degree");
	
			if (degree_gone > 180) { //chooses smaller slice
				degree_gone = min(closest_cut.rotate_degree, rotation_degree) + (360 - max(closest_cut.rotate_degree, rotation_degree))
				weird_slice = true;
			} else weird_slice = false;
		
		
		
		
			lines[# 1, dsheight] = degree_gone;
			lines[# 2, dsheight] = min(closest_cut.rotate_degree, rotation_degree);
			lines[# 3, dsheight] = max(closest_cut.rotate_degree, rotation_degree);
			lines[# 4, dsheight] = weird_slice;
			//show_debug_message(string(weird_slice) + " weird slice for slice not between something");
		
		}
	
		lines[# 0, dsheight] = slices_cut;
		var current_degrees_left = 360;
		var current_taken_away = 0;
	
		var dd = 1; repeat (dsheight) {
			current_degrees_left -= lines[# 1, dd]
			current_taken_away += lines[# 1, dd];
			//show_debug_message("took away " + string(current_taken_away));
		
		
			dd += 1;
		}
	
		//show_debug_message("degrees left " + string(current_degrees_left));
		degrees_left = current_degrees_left;
	
		//topmost column stores pie left
		lines[# 0, 0] = slices_cut;
		lines[# 1, 0] = degrees_left;
		lines[# 2, 0] = -1;
		lines[# 3, 0] = -1;
		lines[# 4, 0] = false;
	
	
		//show_debug_message(string(weird_slice) + " weird slice");
	
		//show_debug_message(string(closest_cut.rotate_degree) + " closest degree");
	
	
	
		/*
		show_debug_message("/////////////---TOP SLICE");
		show_debug_message(string(lines[# 1, dsheight]) + " size of pie in degrees");
		show_debug_message(string(lines[# 2, dsheight]) + " smallest boundary");
		show_debug_message(string(lines[# 3, dsheight]) + " largest boundary");
		show_debug_message(string(lines[# 4, dsheight]) + " is weird slice");
	
		show_debug_message(" ");
	
		if (is_between) {
			show_debug_message("/////////////---BOTTOM SLICE");
			show_debug_message(string(lines[# 1, between_point]) + " size of pie in degrees");
			show_debug_message(string(lines[# 2, between_point]) + " smallest boundary");
			show_debug_message(string(lines[# 3, between_point]) + " largest boundary");
			show_debug_message(string(lines[# 4, between_point]) + " is weird slice");
		
			show_debug_message(" ");
		}
		*/
	
		return 1;
	
	}



















}
