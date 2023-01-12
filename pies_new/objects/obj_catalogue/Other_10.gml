/// @description function

function edit_room_start() {
	var fdata = furniture_handler.furniture_data;
	
		//copy arrays
	var tt = fdata.table_types_purchased;
	var len1 =  array_length(tt);
	table_type_available = array_create(len1);
	array_copy(table_type_available, 0, tt, 0, len1);
	
	var oo = fdata.oven_types_purchased;
	var len2 =  array_length(oo);
	oven_type_available = array_create(len2);
	array_copy(oven_type_available, 0, oo, 0, len2);
	
	
	#region give table data
		
		// table types are given based on location, not instance id
	var num = instance_number(obj_table);
	var griddy = ds_grid_create(3, num);
	
		// sort tables based on location from 0, 0
	var i = 0; with (obj_table) {
			// store data
		var dist = point_distance(0, 0, x, y);	
		
		griddy[# 0, i] = id;
		griddy[# 1, i] = type_index;
		griddy[# 2, i] = dist;
		
		other.table_type_available[type_index] -= 1;
		i++;
	}
	

	ds_grid_sort(griddy, 2, true);		// sort based on increasing distance from 0, 0
	

		// give values to tables
	
	for (var i = 0; i < num; i++) {
		var inst = griddy[# 0, i];
		with (inst) {
			type_index = fdata.table_types[i];		// array
		}
	}
	
	
	
	#region chunk
	/*
	
	var sorted_grid = ds_grid_create(3, num);
	
	var leftmost_index = 0;		// position on ds grid of top left table in row
	var leftmost_y = griddy[# 2, leftmost_index];
	sorted_grid[# 0, 0] = griddy[# 0, leftmost_index];
	sorted_grid[# 1, 0] = griddy[# 1, leftmost_index];
	sorted_grid[# 2, 0] = leftmost_y;
	
	var temp_list = ds_list_create();
	var y_tolerance = 20;		// how far apart y values of tables in a row can be
	
		// sort based on x position of tables in row
	for (var i = leftmost_index; i < num; i++) {
		var yy = griddy[# 2, i];
		
			// around +- the y value of leftmost table
		if (abs(yy - leftmost_y) < y_tolerance) {
			
		}
	}
	
	
	
	
	
	
	// assuming tables are in rows, y value fo first row tables will be close to each other
	// take the first row and sort by x value
	var i = 0; while (i < num) {
		var j = i;
		var first_y = griddy[# 2, j];
		var error_margin = 10;
		var row_len = j - i;
		for (var j = i; j < num; j++) {
			
			var yy = griddy[# 2, j];
			if (yy > first_y + error_margin or yy < first_y - error_margin) {
				// obtained first row of tables whose y values lie within +- error margin pixels of each other
				row_len = j - i;
				i = j;
				show_debug_message("number of tables in row: " + string(row_len));
				break;
			} else if (j = num - 1) {
				// reached end of grid
				show_debug_message("end of grid");
				row_len = j - i;
				i = j;
				show_debug_message("number of tables in row: " + string(row_len));
				break;
			}
		}
		
			// now sort by x value
		var temparray = array_create(row_len);
		var startfrom = i;
		
		var r = 0; repeat (row_len) {
			temparray[r] = griddy[# 1, startfrom];
			startfrom++;
			r++;
		}
		
		show_debug_message(" ");
		show_debug_message(temparray);
		sort_array(temparray, true);
		
	}
	
	var locationx = ds_list_create();
	var locationy = ds_list_create();
	
	ds_list_destroy(locationx);
	ds_list_destroy(locationy);
	
	
	*/
	#endregion
	
	#endregion
	
	#region store oven data
		
	
	var num = instance_number(par_oven);
	ds_grid_clear(griddy, -1)
	ds_grid_resize(griddy, 3, num);
	
	
		// sort ovens based on location from 0, 0
	var i = 0; with (par_oven) {
			// store data
		var dist = point_distance(0, 0, x, y);	
		
		griddy[# 0, i] = id;
		griddy[# 1, i] = type_index;
		griddy[# 2, i] = dist;
		
		other.oven_type_available[type_index] -= 1;		// minus one table from the available list of oven types
		i++;
	}
	

	ds_grid_sort(griddy, 2, true);		// sort based on increasing distance from 0, 0
	

		// assign values to ovens
	
	for (var i = 0; i < num; i++) {
		var inst = griddy[# 0, i];
		with (inst) {
			type_index = fdata.oven_types[i];		// array
			
				// extend oven if needed
			if (!extended and fdata.ovens_extended[i] = true) {
				var newinst = instance_create_layer(x, y, "Instances", obj_piemachine_ext);
				griddy[# 0, i] = newinst;
				
				instance_destroy();
			}
		}
	}
	
	#endregion
	
	ds_grid_destroy(griddy);
	
		
	
}


function edit_room_end() {
	var fdata = furniture_handler.furniture_data;
		
	#region store table data
		
		// sort tables based on location, not instance id
	
	var num = instance_number(obj_table);
	var griddy = ds_grid_create(3, num);
	
		// store x and y location of each table and sort
	var i = 0; with (obj_table) {
			// store data
		var dist = point_distance(0, 0, x, y);	
		
		griddy[# 0, i] = id;
		griddy[# 1, i] = type_index;// show_debug_message("table index stored in griddy "+string(type_index));
		griddy[# 2, i] = dist;
		i++;
	}
	

	ds_grid_sort(griddy, 2, true);		// sort based on increasing distance from 0, 0
	

		// put values in table_types array from obj stats
	
	with (fdata) {
		table_types = array_create(num);
			
		for (var i = 0; i < num; i++) {
			table_types[i] = griddy[# 1, i];// show_debug_message("table index stored in struct "+string(table_types[i]));
		}
	}

	
	
	
	#endregion
	
	#region store oven data
		
	
	var num = instance_number(par_oven);
	ds_grid_clear(griddy, -1)
	ds_grid_resize(griddy, 3, num);
	
	
		// store x and y location of each table and sort
	var i = 0; with (par_oven) {
			// store data
		var dist = point_distance(0, 0, x, y);	
		
		griddy[# 0, i] = id;
		griddy[# 1, i] = type_index;
		griddy[# 2, i] = dist;
		i++;
	}
	

	ds_grid_sort(griddy, 2, true);		// sort based on increasing distance from 0, 0
	

		// put values in oven_types array from obj stats
		
	with (fdata) {
		oven_types = array_create(num);
		for (var i = 0; i < num; i++) {
			oven_types[i] = griddy[# 1, i];
		}
	}
	
	
	#endregion
	
	
	ds_grid_destroy(griddy);
	
	
		// restore variables
		
		show_debug_message(furniture_handler.furniture_data);
		
	editing_room = false;
	alarm[0] = 1;
	room_goto(rm_attic);
}



function edit_room() {
		//check for clicking
	var mx = mouse_x;
	var my = mouse_y;
	
		// player wants to change table
	if (place_meeting(mx, my, obj_table) and mouse_check_button_pressed(mb_left)) {
		
		var inst = instance_place(mx, my, obj_table);
		var current_tier = obj_stats.tier;
		thing_index = 0;
		
		furniture_inst = inst;
		furniture_type = furniture_types.table;
		furniture_sprite = spr_table;
		furniture_type_available = table_type_available;
		switch_furniture = true;
		
	}
	
	else if (place_meeting(mx, my, par_oven) and mouse_check_button_pressed(mb_left)) {
			
			
		var inst = instance_place(mx, my, par_oven);
		var current_tier = obj_stats.tier;
		thing_index = 0;
		
		furniture_inst = inst;
		furniture_type = furniture_types.oven;
		furniture_sprite = spr_piemachine;
		if (inst.extended) furniture_sprite = spr_piemachine_ext;
		furniture_type_available = oven_type_available;
		switch_furniture = true;
		
	}
	
		// change table/oven type to switch to
	if (switch_furniture) {
		var current_tier = obj_stats.tier
		
		#region	change index
		if (keyboard_check_pressed(vk_right)) {
				// loop until type_num == 0 or thing_index = 0;
			var f = furniture_type_available;
			thing_index += 1;
			if (thing_index >= current_tier) thing_index = 0;
				
		}
		
		else if (keyboard_check_pressed(vk_left)) {
				// loop until type_num == 0 or thing_index = 0;
			var f = furniture_type_available;
			thing_index -= 1;
			if (thing_index < 0) thing_index = current_tier - 1;
				
		}
		
		#endregion
		
		
			// confirm switch
		var f = furniture_type_available;
		if (keyboard_check_pressed(vk_enter) and f[thing_index] > 0) {
			var inst = furniture_inst;
			var new_type = thing_index;
			var old_type = furniture_inst.type_index;
			
			
			if (furniture_type == furniture_types.table) {
				table_type_available[new_type] -= 1;
				table_type_available[old_type] += 1;
				//show_debug_message(string(table_type_available));
			} else if (furniture_type == furniture_types.oven) {
				oven_type_available[new_type] -= 1;
				oven_type_available[old_type] += 1;
				//show_debug_message(string(oven_type_available));
			}
			
			
				// new type
			furniture_inst.type_index = new_type;
			switch_furniture = false;
			
		} else if (keyboard_check_pressed(ord("O")) and ovens_to_extend > 0) {
				// extend oven
			var inst = furniture_inst;
			
			if (inst.object_index == obj_piemachine) {
				var inst_type = inst.type_index;
				var xx = inst.x;
				var yy = inst.y;
				
				with (inst) instance_destroy();
				
				var newinst = instance_create_layer(xx, yy, "Instances", obj_piemachine_ext);
				newinst.type_index = inst_type;
				ovens_to_extend -= 1;
				switch_furniture = false;
				
					// add to obj stats
				with (furniture_handler.furniture_data) {
					for (var i = 0; i < array_length(ovens_extended); i++) {
						if (ovens_extended[i] == false) {
							ovens_extended[i] = true;
							break;
						}
					}
				}
			}
		}
	}
	
	
	if (keyboard_check_pressed(vk_escape)) {
		if (switch_furniture) {
			switch_furniture = false;
			
		} else {
			
			
			edit_room_end();
		}
	}
	
}


function draw_edit_room() {
		// draw background
	draw_sprite(spr_reno_confirm, 0, reroom_confirmx, reroom_confirmy);
	
		// draw furniture
	draw_sprite_ext(furniture_sprite, thing_index, rrc_icon_x, rrc_icon_y, 2, 2, 0, c_white, 1)
		
	draw_set_font(fnt_beeg);
	draw_set_color(c_black);
		
	draw_text(rrc_text_x, rrc_text_y, "Number left: " + string(furniture_type_available[thing_index]));
	draw_set_font(fnt_default);
	draw_set_color(c_white);
}


