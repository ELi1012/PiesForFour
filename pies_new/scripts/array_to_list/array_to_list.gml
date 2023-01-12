// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function array_to_list(_array_id) {
	// MANUALLY DELETE LIST ONCE FINISHED USING
	// FUNCTION WILL NOT DO IT
	
	var len = array_length(_array_id);
	var templist = ds_list_create();
	
	for (var i = 0; i < len; i++) {
		templist[| i] = _array_id[i];
	}
	
	return templist;
}