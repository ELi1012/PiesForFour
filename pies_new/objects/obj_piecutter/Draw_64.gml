if (!cutting_pie) exit;

var gx = gui_middlex;
var gy = gui_middley;

// list of cuts on current pie
var dd = ds_piecut[| piestack_index];
var len = ds_list_size(dd);//array_length(dd);
var current_pie = obj_player.ds_pie_carry[| piestack_index];
var ptype = current_pie.pie_type;


//draw background and pie
draw_sprite(spr_background, 0, 0, 0);
draw_sprite(spr_pie, ptype, gx - pie_middlex, gy - pie_middley);



for (var i = 0; i < len; i++) {
	draw_sprite_ext(spr_cutline, 0, gx, gy, 1, 1, dd[| i], c_white, 1);
}

//draw knife
draw_sprite_ext(spr_knifeline, 0, gx, gy, 1, 1, knife_rotate, c_white, 1);



//shows current knife rotation
var putthis = cutting_notif + rotate_string;
draw_text(30, 30, string(putthis));


draw_sprite(spr_done, 0, done_button.x1, done_button.y1);
	



