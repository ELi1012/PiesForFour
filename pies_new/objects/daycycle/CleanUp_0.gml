if (surface_exists(surface)) {
	surface_free(surface);
}

if (ds_exists(ds_glow, ds_type_grid)) ds_grid_destroy(ds_glow);
