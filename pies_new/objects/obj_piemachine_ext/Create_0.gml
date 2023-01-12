event_inherited();

//height of one oven not the whole sprite
section_height = 48;
m_width = sprite_get_width(spr_piemachine_ext);
mmiddlex = m_width / 2;
arrow_frame = 0;

machine_range = 6;
just_chose = false;		// prevents next section from choosing after first one


pie_size = 64;
pie_middle = pie_size / 2;



oven_tier = 1;
extended = true;

base_cooking_time = 10;
//baking_done = base_cooking_time - ((base_cooking_time/tiermaster.max_tier) * (oven_tier - 1));
baking_done = base_cooking_time - ((base_cooking_time/4) * (oven_tier - 1));


event_user(0);
event_user(1);		// state functions



enum oven_section {
	lower_section	= 0,
	upper_section	= 1
}


current_oven = oven_section.lower_section;

// stores the state of each respective half of the oven
// easier to access in the function

// need to write out separate structs explicitly
// lower_section = upper_section only stores a reference to upper_section instead of copying

upper_section = {
	state: state_checking,
	pie_scroll: 0,
	pie_baking: -1,
	
	timer: 0,
}

lower_section = {
	state: state_checking,
	pie_scroll: 0,
	pie_baking: -1,
	
	timer: 0,
}


section_array = array_create(2);
section_array[oven_section.lower_section] = lower_section;
section_array[oven_section.upper_section] = upper_section;

section_scroll = oven_section.lower_section;


function pie_something(_pie_inst) {
	//check if pie is being held by player
	var dd = obj_player.ds_pie_carry;
	var len = ds_list_size(dd);
		
	// player is holding pie
	if (len <= obj_player.max_pie_carry) {
		// add pie to list
		ds_list_add(dd, _pie_inst);
		with (_pie_inst) {
			picked_up = true;
			draw_using_depth = true;
			visible = false;
		}
			
	} else {
		// replace topmost pie with one on stove
		var old_pie = dd[| len - 1];
		ds_list_replace(dd, len - 1, _pie_inst);
			
		// reset variables for old pie
		with (old_pie) {
				
				
		}
	}
	
}





