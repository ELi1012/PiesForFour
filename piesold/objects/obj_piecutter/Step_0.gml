
if (!cutting_pie) exit;


//cutting pie is set to true in obj pie

//------be careful with place meeting functions

global.no_moving = true;
global.using_escape = true;

mousex = device_mouse_x_to_gui(0);
mousey = device_mouse_y_to_gui(0);

mask_index = spr_smallmask;

//gives cell number - must be multiplied by cell size to work
cx = mousex div cell_size;
cy = mousey div cell_size;

//cell number multipled by cell size
sx = (cx * cell_size) + x_buffer;
sy = (cy * cell_size) + y_buffer;

#region knife rotating and switching

if (mouse_wheel_up()) {
	knife_rotate = 0;
	rotate_scroll += 1;
	if (rotate_scroll >= knife_rotations.height) {
		rotate_scroll = 0;
	} 
	
} else if (mouse_wheel_down()) {
	knife_rotate = 0;
	rotate_scroll -= 1;
	if (rotate_scroll < 0) {
		rotate_scroll = knife_rotations.height;
	}
}

switch (rotate_scroll) {
	case 0:
		rotate_by = knife_rotations.quarters;
		rotate_string = "quarters";
		break;
	case 1:
		rotate_by = knife_rotations.eigths;
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

if (mouse_check_button_pressed(mb_right)) {
	
	//show_debug_message(string(knife_rotate));
	//show_debug_message(string(knife_rotate mod 360));
	
	if (rotate_by = knife_rotations.sixteenths) {
		six_toggle = !six_toggle;
		
		if (six_toggle) {
			rotate_by = 23;
		} else {
			rotate_by = 22;
		}
		
		//show_debug_message("rotate by" + string(rotate_by));
		
	}
	
	knife_rotate += rotate_by;
}


#endregion knife rotating and switching


if (sx = gui_middlex and sy = gui_middley and mouse_check_button_pressed(mb_left)) {
	
	//player is allowed to cut pie
	var current_degree = knife_rotate mod 360;
	var cuts = draw_cut_line(current_degree, rotate_by);
	
	
}

//-------------DONE CUTTING
if (point_in_rectangle(mousex, mousey, draw_donex, draw_doney, draw_donex + done_width, draw_doney + done_height)
	and mouse_check_button_pressed(mb_left) and !done) {
	//show_debug_message(" ");
	//show_debug_message("////////IS DONE");
	done = true;
	cutting_pie = false;
	daycycle.draw_daylight = true;
	visible = false;
	mask_index = spr_piecutter;
	
	//set all pie degree variables to fractions of 240
	var dd = 0;
	var ds_slices = ds_lines;
	var dheight = ds_grid_height(ds_slices);
	temp_array = array_create(dheight);
	
	slices_cut = ds_slices[# 0, 0];
	
	//show_debug_message("grid height is " + string(dheight));
	//show_debug_message("slices cut is " + string(slices_cut));
	
	repeat (dheight) {
		
		//current value in ds_slices[# 1, dd] is the size in degrees
		//convert to fraction of a whole pie (240)
		var cc = ds_slices[# 1, dd]
		var ccmod = cc mod 45;
		var ccdiv = cc div 45;
		//if (cc = 22 or cc = 23) cc = 22.5;
		if (ccmod = 22 or ccmod = 23) cc = (45 * ccdiv) + 22.5;
		
		//show_debug_message("slice before conversion is " + string(cc));
		cc = (cc/360) * 240;
		//show_debug_message("slice after conversion is " + string(cc));
		//show_debug_message(" ");
		
		ds_slices[# 1, dd] = cc;
		temp_array[dd] = cc;
		
		dd += 1;
	}
	
	//pass relevant variables to pie inst
	with (inst_pie) {
		
		if (other.slices_cut > 1){
			is_selected = true;
			has_been_cut = true;
			slices_array = other.temp_array;
		} else {
			has_been_cut = false;
			is_selected = true;
		}
		
	}
	
	obj_player.pie_selected = inst_pie;
	
	//player can move again
	global.no_moving = false;
	global.using_escape = false;
	
	//reset all variables
	event_perform(ev_create, 0);
	instance_destroy(obj_cutline);
	temp_array = -1;
	
	
}



















