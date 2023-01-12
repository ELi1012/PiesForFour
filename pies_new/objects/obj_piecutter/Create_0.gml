
event_inherited();

mouse_above = false;
outline_init();

cutting_pie = false;


cell_size = 64;
knife_rotate = 0; //current knife rotation
rotate_by = 90; //how many degrees to rotate by
rotate_string = "quarters";
cutting_notif = "Currently cutting into: ";
rotate_scroll = 0;
done = false;

spr_background = spr_piecutbackground;
spr_pie = tiermaster.piecut_sprite;

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



//pie slices table

done_width = sprite_get_width(spr_done);
done_height = sprite_get_height(spr_done);

	var xx = board_width - done_width - 30;
	var yy = board_height - done_height - 30;
	
done_button = {
	x1: xx,		// top left corner x
	y1: yy,
	x2: xx + done_width,
	y2: yy + done_height
}



ds_piecut = ds_list_create();		// stores array with cuts for each pie in stack
piestack_index = 0;		// index of pie in stack


enum knife_rotations { //how many degrees to rotate the knife by
	//if going smaller than a sixteenth update array check create count
	quarters = 90,
	eighths = 45,
	sixteenths = 22.5,
	height = 3
	
	
}

function start_cutting_pie() {
	spr_pie = tiermaster.piecut_sprite;
	cutting_pie = true;
	visible = true;
									
	// put data in ds_piecut
	var dd = obj_player.ds_pie_carry;
	var pie_num = ds_list_size(dd);
	
	for (var i = 0; i < pie_num; i++) {
		var pie_id = dd[| i];
		var pie_cutlines = pie_id.cutline_array;
		ds_piecut[| i] = ds_list_create();
		
		// copy list if cutlist in pie object is not empty
		if (!ds_list_empty(pie_cutlines))			ds_list_copy(ds_piecut[| i], pie_cutlines);
		
		// mark as list so sublists are destroyed with parent list
		ds_list_mark_as_list(ds_piecut[| i], i);
	}
	
	
}

