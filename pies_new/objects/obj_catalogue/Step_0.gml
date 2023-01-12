//if (!show_catalogue) exit;


if (editing_room) {
	
	//destroy unneeded objects
	if (instance_exists(obj_player)) {
		with (obj_player) {
			instance_destroy();
			//show_debug_message("destroyed player");
		}
		
		with (obj_piecutter) {
			other.pc_x = x;
			other.pc_y = y;
			instance_destroy();
		}
		
		instance_destroy(obj_checklist);
		instance_destroy(obj_spawner);
		
		edit_room_start();
		
	}
	
	
	
	edit_room();
	
}












