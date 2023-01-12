// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function change_index(_index, _min_value, _max_value, _subtract_key, _add_key){
	// adds/subtracts a value from an index within the bounds of the min and max index value
	// subtract key is the key pressed to subtract a value, same for add key
	// returns the new index
	
	if (keyboard_check_pressed(_add_key)) {
		_index += 1;
		if (_index > _max_value) _index = _min_value;
	}
	
	else if (keyboard_check_pressed(_subtract_key)) {
		_index -= 1;
		if (_index < _min_value) _index = _max_value;
	}
	
	return _index;
}