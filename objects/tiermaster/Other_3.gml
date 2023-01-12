if (ds_exists(ds_table_tiers, ds_type_grid)) {
	ds_grid_destroy(ds_table_tiers);
	ds_grid_destroy(ds_oven_tiers);
}