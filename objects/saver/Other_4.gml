if (!already_loaded) {
	if (!saving_on) exit;
	already_loaded = true;
	//load everything at the beginning
	if (file_exists(file_name)) {
		//show_debug_message("file exists");
		save_data = load_json_from_file("savefile.dingus");
		
		//save_data = ds_map_secure_load(file_name);
		var _mappy = save_data;
		
		
		//persistent object variables are set here
		//non persistent are set in their create event
		
		with (obj_stats) {
			
			gold = _mappy[? "gold"];
			rating = _mappy[? "rating"];
			
			player_hat = _mappy[? "hat"];
			player_clothes = _mappy[? "clothes"];
			player_pill = _mappy[? "pill"];
			
			tier = _mappy[? "tier"];
			current_room = _mappy[? "current room"];
			dining_bg = _mappy[? "dining bg"];
			kitchen_bg = _mappy[? "kitchen bg"];
			
			trans_x = _mappy[? "trans x"];
			trans_y = _mappy[? "trans y"];
			
			
		}
		
	
	
		with (tiermaster) {
			
			
			if (!is_undefined(_mappy[? "table tiers"])) {
				
				
				ds_table_tiers = ds_grid_create(0, 0);
				ds_oven_tiers = ds_grid_create(0, 0);
				
				ds_grid_read(ds_table_tiers, string(_mappy[? "table tiers"]));
				ds_grid_read(ds_oven_tiers, string(_mappy[? "oven tiers"]));
			} else show_debug_message("table tiers undefined");
		
		}
		
		with (daycycle) {
			day = _mappy[? "day"]
			seconds = _mappy[? "seconds"];
			
		}
		
		if (room == rm_attic) {
			with (obj_wardrobe) event_perform(ev_alarm, 0);
		}
		
	
		//show_debug_message("game loaded");
	
	}
	
	
	
}