///@desc converts slice array to note array
///@arg array
function slice_to_note(argument0) {

	//returns array

	var slice_array = argument0;

	if (!is_array(slice_array)) {
		return -1;
		show_debug_message("array called from slice to note conversion is not an array");
		exit;
	
	
	}

	var array_len = array_length(slice_array);
	var new_array = 0;
	var ii = 0;
	var n = 0;

	repeat (array_len) {
	
		var ss = slice_array[ii];
	
		switch (ss) {
	
			case 240: n = note_symbols.whole; break;
		
			case 120: n = note_symbols.half; break;
		
			case 60: n = note_symbols.quarter; break;
		
			case 30: n = note_symbols.eighth; break;
		
			case 15: n = note_symbols.sixteenth; break;
		
			case 180: n = note_symbols.dotted_half break;
		
			case 90: n = note_symbols.dotted_quarter; break;
		
			case 45: n = note_symbols.dotted_eighth; break;
		
			case 210:
				var ddh = note_symbols.dotted_dottedhalf;
				n = choose(-1, -1, -1, ddh);
				break;
		
			case 105: n = note_symbols.dotted_dottedquarter; break;
		
			//tied notes
		
			//case 210:
			//	n = -1;
			//	break;
	
			case 150: n = -2; break;
		
			case 75: n = -3; break;
	
			case 195: n = -4; break;
	
			case 135: n = -5; break;
			
			case 165: //half note + eighth note + sixteenth
				n = -6;
				break;
		
		
			default: n = 60; break;
		
		}
	
	
		new_array[ii] = n;
	
		ii += 1;
	}

	return new_array;










}
