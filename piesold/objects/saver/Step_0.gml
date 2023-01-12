


//delete file
if (keyboard_check_pressed(ord("M"))) {
	var df_set_false = false;
	
	if (delete_file) {
		if (keyboard_check_pressed(vk_numpad0)) {
			file_delete("savefile.dingus");
			with (obj_stats) {
				new_notif = true;
				notif_string = "file deleted";
			}
			saving_on = false; //dont save data again right after deleting it
			df_set_false = true;
			
		} else if (keyboard_check_pressed(vk_anykey)) {
			df_set_false = true;
		}
	}
	
	if (file_exists("savefile.dingus") and !delete_file) delete_file = true;
	
	if (df_set_false) delete_file = false;
	
	
	
}