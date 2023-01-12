if (ds_exists(ds_clothing_head, ds_type_grid)) {
	ds_grid_destroy(ds_clothing_head);
	ds_grid_destroy(ds_clothing_body);
	ds_grid_destroy(ds_clothing_pill);
}