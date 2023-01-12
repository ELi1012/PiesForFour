event_inherited();

m_width = sprite_get_width(spr_piemachine);
m_height = sprite_get_height(spr_piemachine);
mmiddlex = m_width / 2;
mmiddley = m_height / 2;

machine_range = 5;

pie_size = 64;
pie_middle = pie_size / 2;

pie_scale = 1 / ((pie_size/m_width) * 2);

pie_scroll = 0;

others_making = false;

oven_tier = 1;


pie_making = -1;
making_timer = 0;
base_cooking_time = 5;
making_done = base_cooking_time + ((base_cooking_time/tiermaster.max_tier) * (oven_tier - 1));

pie_inst = -1;
pie_on_stove = false;

mstate = 1;
mstate_checking = 1;
mstate_choosing = 2;
mstate_baking = 3;
mstate_done = 4;

machine_xoffset = sprite_get_xoffset(spr_piemachine);
machine_yoffset = sprite_get_yoffset(spr_piemachine);






