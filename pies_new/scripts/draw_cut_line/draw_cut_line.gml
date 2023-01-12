function cut_pie_line_list(cutline_list, _current_degree) {
	var dd = cutline_list;
	var cc = _current_degree;
	
	
	// check if cut already exists at given degree
	// ds_list_find_index returns -1 if it finds nothing that matches rotation_degree
	if (ds_list_find_index(dd, cc) == -1) {
		ds_list_add(dd, cc);
		show_debug_message("added degree " + string(cc));
	}
}

function cut_pie_line(_cutline_array, _current_degree) {
	var dd = _cutline_array;
	var cc = _current_degree;
	var already_here = false;
	var len = array_length(dd);
	
	//show_debug_message("current_degree " + string(_current_degree));
	
	
	// check if cut already exists at given degree
	for (var i = 0; i < len; i++) {
		//show_debug_message("current degree: "+string(cc)+", dd[i]: "+string(dd[i]));
		if (cc == dd[i]) {
			already_here = true;
			//show_debug_message("cut already here");
			break;
		}
	}
	
	if (!already_here) dd[len] = cc;
	
	return dd;
}

function degrees_to_slices_array(_cut_array) {
	
	// spawner sets values used by customers to check for correct pie slices
	var dd = _cut_array;
	var len = array_length(dd);
	var wp = obj_spawner.whole_pie;
	
	
	// if only one cut has been made, no slices made
	if (len > 1) {
		var temp_array = array_create(len);
		sort_array(dd, true);
		
		// adjust cuts so smallest value = 0
		// ie rotate all cuts by smallest value (dd[| 0]
		for (var i = 0; i < len; i++) {
			dd[i] -= dd[0];
		}
		// #problem giving negative slices
		// create slices
		for (var i = 0; i < len; i++) {
			var one_cut, next_cut, pslice;
			one_cut = dd[i];
			
			// last slice will always have next_cut at 0 degrees; change to 360
			if (i == len - 1)	next_cut = 360;
			else				next_cut = dd[i + 1];
			
			
			// convert from degrees to percentage of 240
			pslice = next_cut - one_cut;
			
			temp_array[i] = (pslice/360) * wp;
			
			show_debug_message("first cut: " + string(one_cut));
			show_debug_message("next cut: " + string(next_cut));
			show_debug_message("slice created: " + string(pslice));
			show_debug_message(" ");
			
		}
		
		return temp_array;
		
	}
	
}

function degrees_to_slices(list_of_cuts) {
	
	// spawner sets values used by customers to check for correct pie slices
	var dd = list_of_cuts;
	var len = ds_list_size(dd);
	var wp = obj_spawner.whole_pie;
	
	
	// if only one cut has been made, no slices made
	if (len > 1) {
		var temp_array = array_create(len);
		ds_list_sort(dd, true);
		
		// adjust cuts so smallest value = 0
		// ie rotate all cuts by smallest value (dd[| 0]
		for (var i = 0; i < len; i++) {
			dd[| i] -= dd[| 0];
		}
		
		// create slices
		for (var i = 0; i < len; i++) {
			var one_cut, next_cut, pslice;
			one_cut = dd[| i];
			
			// last slice will always have next_cut at 0 degrees; change to 360
			if (i == len - 1)	next_cut = 360;
			else				next_cut = dd[| i + 1];
			
			
			// convert from degrees to percentage of 240
			pslice = next_cut - one_cut;
			
			temp_array[i] = (pslice/360) * wp;
			
			show_debug_message("first cut: " + string(one_cut));
			show_debug_message("next cut: " + string(next_cut));
			show_debug_message("slice created: " + string(pslice));
			show_debug_message(" ");
			
		}
		
		return temp_array;
		
	}
	
}

// called from within customer when checking pie accuracy
function list_to_array(_list_id) {
	var len = ds_list_size(_list_id);
	var temp_array = array_create(len);
	
	for (var i = 0; i < len; i++) {
		temp_array[i] = _list_id[| i];
	}
	
	return temp_array;
}















