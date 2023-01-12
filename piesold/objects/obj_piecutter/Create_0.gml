
event_inherited();

cutting_pie = false;
inst_pie = -1; //pie being cut

cell_size = 64;
total_pie = 240;
knife_rotate = 0; //current knife rotation
rotate_by = 90; //how many degrees to rotate by
rotate_string = "quarters";
cutting_notif = "Currently cutting into: ";
rotate_scroll = 0;
six_toggle = false;
done = false;

spr_background = spr_piecutbackground;
spr_pie = tiermaster.piecut_sprite;
spr_pie_index = 0;

mousex = 0;
mousey = 0;

mask_index = spr_piecutter;

pie_middlex = sprite_get_width(spr_pietocut) / 2;
pie_middley = sprite_get_height(spr_pietocut) / 2;
pie_rad = pie_middlex;

board_width = global.game_width;
board_height = global.game_height;

gui_middlex = board_width/2;
gui_middley = board_height/2;


x_buffer = gui_middlex - ((gui_middlex div cell_size) * cell_size);
y_buffer = gui_middley - ((gui_middley div cell_size) * cell_size);


board_rows = board_width/cell_size;
board_columns = board_height/cell_size;

first_degree = -1;
degrees_left = 360;
slices_cut = 1;

//pie slices table
x_margin = 30;
y_margin = 30;
blinex = 10;
bliney = 30;

done_width = sprite_get_width(spr_done);
done_height = sprite_get_height(spr_done);

draw_donex = board_width - done_width - x_margin;
draw_doney = board_height - done_height - y_margin;

ds_lines = -1;
ds_lines = ds_grid_create(5, 1);
ds_grid_clear(ds_lines, 0);
ds_lines[# 0, 0] = slices_cut;
ds_lines[# 1, 0] = degrees_left;
ds_lines[# 2, 0] = -1;
ds_lines[# 3, 0] = -1;
ds_lines[# 4, 0] = false;

//0: pie slice number
//1: pie degrees
//2: pie degree boundary (lesser)
//3: boundary (greater)
//4: abs(closest_cut.rotate_degree - rotation_degree); > 180

enum knife_rotations { //how many degrees to rotate the knife by
	//if going smaller than a sixteenth update array check create count
	quarters = 90,
	eigths = 45,
	sixteenths = 22,
	height = 3
	
	
}

