event_inherited();

//height of one oven not the whole sprite
m_width = sprite_get_width(spr_piemachine_ext);
m_height = (sprite_get_height(spr_piemachine_ext) - 16) / 2;
mmiddlex = m_width / 2;
mmiddley = m_height / 2;

machine_range = 6;
machine_scroll = 1;

//which machines to choose
machine_scroll_max = 2;
machine_scroll_min = 1;


pie_size = 64;
pie_middle = pie_size / 2;

pie_scale = 1 / ((pie_size/m_width) * 2);

pie_scroll = 0;
pscroll_up = ord("X");
pscroll_down = ord("Z");

others_making = false;

oven_tier = 1;


pie_making = -1;
making_timer = 0;
base_cooking_time = 5;
making_done = base_cooking_time - ((base_cooking_time/tiermaster.max_tier) * (oven_tier - 1));

lower_pie_inst = -1;
lower_pie_on_stove = false;

upper_pie_inst = -1;
upper_pie_on_stove = false;


m_state = 1;


mstate_checking = 1;
mstate_choosing = 2;
mstate_baking = 3;
mstate_done = 4;


lower_mstate = 1;
lower_piemaking = -1;
lower_making_timer = 0;

upper_mstate = 1;
upper_piemaking = -1;
upper_making_timer = 0;

machine_xoffset = sprite_get_xoffset(spr_piemachine);
machine_yoffset = sprite_get_yoffset(spr_piemachine);

//starting from the bottom
machine_lower_y = 0;
machine_upper_y = 64;








