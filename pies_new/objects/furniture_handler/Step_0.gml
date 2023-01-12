/// @description assign types to furniture

if (room == rm_main or room == rm_main_ext) {
	if (assign_furniture and instance_exists(obj_table)) {
		assign_furniture = false;		// remains false until player moves to another room
		assign_furniture_types();
	}
} else {
		// reset toggle
	assign_furniture = true;
}