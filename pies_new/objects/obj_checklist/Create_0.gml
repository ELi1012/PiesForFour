
in_view = false;
ds_orders = ds_grid_create(4, 1);
ds_orders[# 0, 0] = -1;
ds_orders[# 1, 0] = -1;
ds_orders[# 2, 0] = -1;
ds_orders[# 3, 0] = -1;

new_order = false;
nframe = 0;			// increment this frame to animate notification


scale = 1;

list_width = sprite_get_width(spr_checklist) * scale;
list_height = sprite_get_height(spr_checklist) * scale;

viewmargin_in = (list_width + 30);
viewmargin_out = 10;

x_inview = global.game_width - viewmargin_in;
x_outview = global.game_width - viewmargin_out;

//keep x and y position the same throughout scaling
x_pos = x_outview;
y_pos = 50;


list_region = {
	x1: x_pos,
	y1: y_pos,
	x2: x_pos + list_width,
	y2: y_pos + list_height
}

pie_size = 64 * scale;

list_inc = 0;

x_margin = 50 * scale;
y_margin = 50 * scale;

max_in_row = 2;
note_spacing = 5;
note_marginx = (pie_size * 2) + note_spacing;
note_marginy = y_margin + (20 * scale);


move_checklist = false;
tables_ordered = 0; //increments when customer order is taken
mouse_above = false;		// idk probably set in some other obecjt should check


//0: cluster number
//1: pie type
//2: slices array
