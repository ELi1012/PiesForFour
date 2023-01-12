// table types: array
// which tables in the room are of what type
// index based on distance from (0, 0) using point_distance function

// table types purchased: array
// size = number of table types			index = which table (based on distance from (0, 0)

// ovens to extend: real
// how many oven upgrades are currently available (consumed once oven is upgraded)


// #save: save this data using save_data()
furniture_data = {
	table_types: array_create(6, 0),	
	oven_types: array_create(2, 0),
	ovens_extended: array_create(2, false), // every oven is unextended
	
	ovens_to_extend: 0,
	
	table_types_purchased: array_create(4, 0),
	oven_types_purchased: array_create(4, 0)
}

// set variables for struct
with (furniture_data) {
	table_types_purchased[0] = 6; // 6 tables are of type 0
	table_types_purchased[1] = 3;
	table_types_purchased[2] = 1;

	oven_types_purchased[0] = 2;		// 2 ovens are of type 0
	oven_types_purchased[2] = 1;
	
	ovens_to_extend = 1;
}

table_num = 6;		// change if number of tables in room changes
oven_num = 2;

	// number of tables and ovens in extended room
room_upgrade_furniture = {
	table_num: 9,
	oven_num: 3
}



if (obj_stats.room_extended) {
	table_num = 9;
	oven_num = 3;
}


assign_furniture = true;		// toggle

function assign_furniture_types() {
	var fdata = furniture_data;
	
	#region assign values to table
	var num = instance_number(obj_table);
	var griddy = ds_grid_create(2, num);
	
		// sort tables based on location from 0, 0
	var i = 0; with (obj_table) {
			// store data
		var dist = point_distance(0, 0, x, y);	
		
		griddy[# 0, i] = id;
		griddy[# 1, i] = dist;
		
		i++;
	}
	

	ds_grid_sort(griddy, 1, true);		// sort based on increasing distance from 0, 0
	

		// give values to tables
	var type_array = fdata.table_types;
	if (array_length(type_array) < num) {
		show_debug_message("length of stored table types less than actual number of tables");
		array_resize(type_array, num);		// new indices in array set to 0
	}
	
	for (var i = 0; i < num; i++) {
		var inst = griddy[# 0, i];
		inst.type_index = type_array[i];		// array
	}
	
	
	#endregion
	
	#region store oven data
		
	
	var num = instance_number(par_oven);
	ds_grid_clear(griddy, -1);
	ds_grid_resize(griddy, 2, num);
	
	
		// sort ovens based on location from 0, 0
	var i = 0; with (par_oven) {
			// store data
		var dist = point_distance(0, 0, x, y);	
		
		griddy[# 0, i] = id;
		griddy[# 1, i] = dist;
		
		i++;
	}
	

	ds_grid_sort(griddy, 1, true);		// sort based on increasing distance from 0, 0
	

		// give values to tables
	var type_array = fdata.oven_types;
	if (array_length(type_array) < num) {
		show_debug_message("length of stored oven types less than actual number of ovens");
		array_resize(type_array, num);		// new indices in array set to 0
	}
	
		// assign values to ovens
		// #problem not assigning properly
		// extended ovens when upgraded do not carry over upgrades to next day
	
	for (var i = 0; i < num; i++) {
		var inst = griddy[# 0, i];
		with (inst) {
			type_index = type_array[i];		// array
			
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