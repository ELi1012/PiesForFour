

//draw background and pie
draw_sprite(spr_background, 0, 0, 0);
draw_sprite(spr_pie, spr_pie_index, gui_middlex - pie_middlex, gui_middley - pie_middley);

with (obj_cutline) {
	draw_sprite_ext(spr_cutline, 0, cutx, cuty, 1, 1, rotate_degree, c_black, 1);
}

//draw knife
draw_sprite_ext(spr_knifeline, 0, sx, sy, 1, 1, knife_rotate, c_white, 1);



//shows current knife rotation
var putthis = cutting_notif + rotate_string;
draw_text(30, y_margin, string(putthis));


draw_sprite(spr_done, 0, draw_donex, draw_doney);
	


#region debug drawings
//draw_circle(sx, sy, 2, false);
//draw_line(0, board_height/2, board_width, board_height/2);
//draw_line(board_width/2, 0, board_width/2, board_height);

//draws pie slice numbers
/*
var ddd = 0;
var lineslength = ds_grid_height(ds_lines);

repeat (lineslength) {
	draw_text(x_margin, y_margin + (ddd * bliney), string(ds_lines[# 1, ddd]));
	ddd += 1;
	
}
*/

//draw_text(board_width - 250, y_margin, "degrees left " + string(ds_lines[# 1, 0]));
//draw_text(board_width - 250, y_margin + 60, "slices cut " + string(ds_lines[# 0, 0]));



//draw_circle(gui_middlex, gui_middley, 2, false);

#endregion debug drawings
















