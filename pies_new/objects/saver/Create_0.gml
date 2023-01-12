saving_on = false;
already_loaded = false;
file_name = "savefile.bingus";
delete_file = false;


event_user(0);


// objects with structs containing saveable data will have #save commented
function save_data() {
	var _save_data = array_create(0);
	
		// store data from objects
		// #problem store current wallpaper and flooring from obj tilesetter
		// and room target spots for room transitions
		// and wardrobe data
		
	with (furniture_handler) {
		array_push(_save_data, furniture_data);
	}
	
	
	with (obj_stats) {
		var tempdata = data_store();
		array_push(_save_data, tempdata);
	}
	
	with (daycycle) {
		var tempdata = {
			day: day,
			seconds: seconds
		}
		
		array_push(_save_data, tempdata);
	}
	
	
	
	
		// turn data into a JSON string and save it via a buffer
	var _string = json_stringify(_save_data);
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, file_name);
	buffer_delete(_buffer);
	
	show_debug_message("------------data saved");
}

function load_data() {
	
	if (!file_exists(file_name)) show_debug_message("save file not found");
	else {
		
			// load data back into array
		var _buffer = buffer_load(file_name);
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
		
		var _load_data = json_parse(_string);		// array
		
			// give variables back to objects
			// do it in the same order the data was saved into the array
			// all data is given to persistent objects; no room specific objects
		var aa = _load_data;
		
		with (furniture_handler) {
			furniture_data = aa[0];
		}
		
		with (obj_stats) {
			data_load(aa[1]);
			
			// change spawn coordinates if room has been extended
			if (room_extended) {
				with (obj_game) {
					target_x = ext_target_x;
					target_y = ext_target_y;
				}
			}
		}
		
		with (daycycle) {
			var tempdata = aa[2];
			day = tempdata.day;
			seconds = tempdata.seconds;
		}
		
		
		show_debug_message("------------data loaded")
		
	}
	
}