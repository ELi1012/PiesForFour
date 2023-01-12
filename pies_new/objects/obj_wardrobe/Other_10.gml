///@desc save load functions

function load_data_old() {
	var sdb = ds_map_find_value(saver.save_data_map, "owned hats");
	
	if (!is_undefined(sdb)) {
		//show_debug_message("wardrobe ds exists in map");
		//load ds grids from save data
		var sdsd = saver.save_data_map;
		ds_grid_read(ds_owned_head, sdsd[? "owned hats"]);
		ds_grid_read(ds_owned_body, sdsd[? "owned clothes"]);
		ds_grid_read(ds_owned_pill, sdsd[? "owned pills"]);
	}
}

function save_data_old() {
	var ddh = ds_owned_head;
	var ddb = ds_owned_body;
	var ddp = ds_owned_pill;
		
	with (saver) {
		//save ds grids in savedata
		ds_map_replace(save_data_map, "owned hats", ds_grid_write(ddh));
		ds_map_replace(save_data_map, "owned clothes", ds_grid_write(ddb));
		ds_map_replace(save_data_map, "owned pills", ds_grid_write(ddp));
	}
}