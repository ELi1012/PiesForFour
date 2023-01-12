if (ds_exists(ds_owned_head, ds_type_grid)) {
	ds_grid_destroy(ds_owned_head);
	ds_grid_destroy(ds_owned_body);
	ds_grid_destroy(ds_owned_pill);
	
	ds_grid_destroy(ds_pill_info);
}