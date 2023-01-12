if(ds_exists(ds_lines, ds_type_grid)) ds_grid_destroy(ds_lines);
if(instance_exists(obj_cutline)) {
	with (obj_cutline) instance_destroy();
}