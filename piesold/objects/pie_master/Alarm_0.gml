//archived code


/*

//step event
var dd = ds_pie_t1;
show_debug_message("table 1----------");

var ddd = 0; repeat (ds_grid_height(dd)) {
show_debug_message(string(dd[# 0, ddd]) + string(dd[# 1, ddd]) + string(dd[# 2, ddd]) + string(dd[# 3, ddd]))
ddd += 1;
}


show_debug_message("table 1----------");
show_debug_message(" ");

var dd = ds_pie_t2;
show_debug_message("table 2----------");
var ddd = 0; repeat (ds_grid_height(dd)) {
show_debug_message(string(dd[# 0, ddd]) + string(dd[# 1, ddd]) + string(dd[# 2, ddd]) + string(dd[# 3, ddd]))
ddd += 1;
}
show_debug_message("table 2----------");
show_debug_message(" ");

var dd = ds_pie_t3;
show_debug_message("table 3----------");
var ddd = 0; repeat (ds_grid_height(dd)) {
show_debug_message(string(dd[# 0, ddd]) + string(dd[# 1, ddd]) + string(dd[# 2, ddd]) + string(dd[# 3, ddd]))
ddd += 1;
}
show_debug_message("table 3----------");
show_debug_message(" ");



//draw event

var f = 0;repeat(ds_grid_height(ds_pie_t1)) {
	w = 0; repeat(ds_grid_width(ds_pie_t1)) {
		draw_text((w * 30) + 100, (f * 30) + 100, string(ds_pie_t1[# w, f]));
		
		w += 1;
	}
	
	f += 1;
}


var pie_width = 64;

if (order_taken) {
	
	//pass on variables to cutting board
	if (place_meeting(mouse_x, mouse_y, obj_piecutter) and !pie_inst.has_been_cut) {
		with (obj_piecutter) {
			cutting_pie = true;
			inst_pie = other.pie_inst;
			inst_pie.pie_type = other.pie_scroll;
			inst_pie.has_been_cut = true;
		}
		order_taken = false;
		
	}
	
	
}