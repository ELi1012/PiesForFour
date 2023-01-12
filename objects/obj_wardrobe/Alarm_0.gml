var sdb = ds_map_find_value(saver.save_data, "owned hats");

if (!is_undefined(sdb)) {
	//show_debug_message("wardrobe ds exists in map");
	//load ds grids from save data
	var sdsd = saver.save_data;
	
	
	ds_grid_read(ds_owned_head, sdsd[? "owned hats"]);
	ds_grid_read(ds_owned_body, sdsd[? "owned clothes"]);
	ds_grid_read(ds_owned_pill, sdsd[? "owned pills"]);
	
}