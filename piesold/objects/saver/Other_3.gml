if (saving_on and room == rm_attic) {
	//save data to a string
	with (obj_stats) event_perform(ev_alarm, 0);
	var _string = json_encode(save_data);
	save_string_to_file("savefile.dingus", _string);
	//ds_map_secure_save(save_data, file_name);
	
	//show_debug_message("game saved at game end");
}

if (ds_exists(ds_type_map, save_data)) ds_map_destroy(save_data);