event_inherited();

outline_init();

arrow_frame = 0;
arrow_width = 64;
arrow_height = 32;

claimed = false;
dirty = false;
table_index = 0;
leader_inst = -1;
mouse_above = false;
claimed_number = -1;

draw_table_state = spr_table;
table_tier = 1;
type_index = 0;		// which table to draw

table_width = sprite_get_width(spr_table);
table_height = sprite_get_height(spr_table);

table_yoffset = sprite_get_yoffset(spr_table);
table_range = 3;
pie_size = 64;
pie_x = (table_width/2) - (pie_size/2);
pie_todraw = -1;
table_pie = -1;

// where customer will sit at the table

//left side
table_left_x = x;
table_left_y = y;

//right side
table_right_x = x + sprite_get_width(spr_table);
table_right_y = y;

//middle
table_middle_x = x + (sprite_get_width(spr_table)/2);
table_middle_y = bbox_top - 4;		// top of bounding box (relative to room coordinates) 

//top left
table_topright_x = x + (sprite_get_width(spr_customer_mask)/2); 
table_topright_y = table_middle_y;

//top right
table_topleft_x = x + sprite_get_width(spr_table) - (sprite_get_width(spr_customer_mask)/2);
table_topleft_y = table_middle_y;



