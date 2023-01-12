if (ds_exists(ds_clustomers, ds_type_grid)) { 
	ds_grid_destroy(ds_clustomers);
	show_debug_message("clustomers destroyed");
}