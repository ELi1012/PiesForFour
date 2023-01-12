


if (!debug) { exit; }


with (obj_collision) {
	draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_blue, c_blue, c_blue, c_blue, true);
}

with (obj_player) {
	draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_blue, c_blue, c_blue, c_blue, true);
}

if (instance_exists((par_customer))) {
	with (par_customer) {
	
		if (is_leader) {
			draw_set_color(c_blue);
			draw_circle(x, y - 70, 2, false);
			draw_set_color(c_black);
		}
	
	}
}


var cs = cellSize;

draw_set_alpha(0.3);

var xx = 0;
var w = roomWidth div cs;
repeat (w) {
	draw_line_color(xx, 0, xx, roomHeight, c_black, c_black)
	xx += cs;
}


var yy = 0;
var h = roomHeight div cs;
repeat (h) {
	draw_line_color(0, yy, roomWidth, yy, c_black, c_black)
	yy += cs;
}

draw_set_alpha(1);

// nantondu 65 does not appear in game because draw_sprite unactivated