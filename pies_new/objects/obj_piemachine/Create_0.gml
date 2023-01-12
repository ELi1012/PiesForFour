event_inherited();

m_width = sprite_get_width(spr_piemachine);
m_height = 48;	// not the same as sprite height; only accounts for front facing portion
mmiddlex = m_width / 2;
mmiddley = m_height / 2;
arrow_frame = 0;

machine_range = 6;
machine_xoffset = sprite_get_xoffset(spr_piemachine);
machine_yoffset = sprite_get_yoffset(spr_piemachine);


pie_size = 64;
pie_middle = pie_size / 2;


pie_scroll = 0;

oven_tier = 1;
extended = false;


pie_baking = -1;
timer = 0;
base_cooking_time = 5;
baking_done = base_cooking_time + ((base_cooking_time/tiermaster.max_tier) * (oven_tier - 1));

// pie instance is only created once player picks up pie
// otherwise oven only draws a display of the finished pie
pie_held = -1;




event_user(0);
event_user(1);		// state functions
state = state_checking;




