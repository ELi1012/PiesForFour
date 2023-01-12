
//clean table
if (dirty) {
	var tr = table_range;
	var ty = y - table_yoffset;
	if (collision_rectangle(x - tr, ty - tr, x + table_width + tr, ty + table_height + tr,
		obj_player, false, false) and keyboard_check_pressed(vk_space)) {
		dirty = false;
		table_index = 0;
	}
}






