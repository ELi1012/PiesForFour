
if (!cutting_pie) exit;


//cutting pie is set to true in obj pie

//------be careful with place meeting functions

global.no_moving = true;
global.using_escape = true;

mousex = device_mouse_x_to_gui(0);
mousey = device_mouse_y_to_gui(0);
var ds_cuts = ds_piecut[| piestack_index];		// stores info on each cut on current pie

mask_index = spr_smallmask;


var gx = gui_middlex;
var gy = gui_middley;

// switch pies in stack
var stack_height = ds_list_size(obj_player.ds_pie_carry);
if (stack_height > 1) {
	if (keyboard_check_pressed(ord("D"))) {
		piestack_index += 1;
		if (piestack_index > stack_height - 1) piestack_index = 0;
	}
	else if (keyboard_check_pressed(ord("A"))) {
		piestack_index -= 1;
		if (piestack_index < 0) piestack_index = stack_height - 1;
	}
}

// switch knife rotation increments
if (mouse_check_button_pressed(mb_right)) {
	
	rotate_scroll += 1;
	if (rotate_scroll >= knife_rotations.height) rotate_scroll = 0;

	switch (rotate_scroll) {
		case 0:
			rotate_by = knife_rotations.quarters;
			rotate_string = "quarters";
			break;
		case 1:
			rotate_by = knife_rotations.eighths;
			rotate_string = "eighths";
			break;
		case 2:
			rotate_by = knife_rotations.sixteenths;
			rotate_string = "sixteenths";
			break;
		default:
			rotate_by = knife_rotations.quarters;
			rotate_string = "quarters";
			break;
	}
}



// change knife_rotate if mouse is within a certain distance of the middle (not the center though)
if (!point_in_circle(mousex, mousey, gx, gy, 16)) {
	// round degree to nearest multiple of rotating degree
	var deg = point_direction(gui_middlex, gui_middley, mousex, mousey); // in degrees
	
	if (rotate_by != knife_rotations.sixteenths) {
		var dmultiple = deg div rotate_by;
		var dmod = deg mod rotate_by;
		deg = (dmultiple + round(dmod/rotate_by)) * rotate_by;
	
	} else {
		// correct rotation degree if rotating by sixteenths
		deg = deg mod 360;	// calculations mess up otherwise
		var ccm45 = (deg div 45) * 45;
		var ccleft = round((deg - ccm45)/22.5) * 22.5;
		
		// round to nearest multiple of 22.5
		deg = ccm45 + ccleft;
	}
	
	knife_rotate = deg mod 360;			// any cut at 0 degrees will not be set to 360
	
}



// make a cut if checklist is not in view
if (mouse_check_button_pressed(mb_left) and !mouse_over_button(done_button, mousex, mousey) and
	!obj_checklist.mouse_above) {
	
		//player is allowed to cut pie
		// need to return value to array, not the local variable
		cut_pie_line_list(ds_cuts, knife_rotate);
		
}


//-------------DONE CUTTING
if (mouse_check_button_pressed(mb_left) and !done and 
	mouse_over_button(done_button, mousex, mousey)) {
		
	//show_debug_message(" ");
	//show_debug_message("////////IS DONE");
	
	done = true;
	cutting_pie = false;
	daycycle.draw_daylight = true;
	visible = false;
	mask_index = spr_piecutter;
	
	// pass variables to each pie in stack
	var pies_in_stack = ds_list_size(ds_piecut);
	
	for (var i = 0; i < pies_in_stack; i++) {
		
		var d = ds_piecut[| i];			// ds list containing all cuts made on pie
		var t = degrees_to_slices(d);	// returns an array of pie slices
		var len = ds_list_size(d);		// how many cuts were made
		
		var pstack = obj_player.ds_pie_carry;
		var inst_pie = pstack[| i];
	
		//pass relevant variables to pie inst
		// passes degree of cuts instead of slices
		// makes it easier to recut a pie without having to convert back from slices to degrees
		
		with (inst_pie) {
			picked_up = true;
		
			if (len > 1) {
				has_been_cut = true;
				ds_list_copy(cutline_array, d);		// list will be cleared if already contains information
				
				//cutline_array = d;
				//if (cutline_array == -1) cutline_array = array_create(0);
				//array_copy(cutline_array, 0, d, 0, len);
				} else {
					has_been_cut = false;
				}
		}
	}
	
	// destroy ds lists
	// sublists are marked as lists; will be destroyed with parent list
	ds_list_destroy(ds_piecut);
	ds_piecut = ds_list_create();
	
	
	//player can move again
	global.no_moving = false;
	global.using_escape = false;
	
	//reset all variables
	event_perform(ev_create, 0);
	
	
}



















