event_inherited();

// player alpha value when selecting pie to bake
p_alpha = 0.2;

// index of image in draw sprite
type_index = 0;

function oven_draw_pie(_pie_type, _xx, _yy) {
	
	// draw pie inside oven
	var spr_pp = tiermaster.pie_sprite;
	var spr_pplen = sprite_get_width(spr_pp) div pie_size;	// how many pies across in sprite
		
	var pie_xx = _pie_type mod spr_pplen;
	var pie_yy = _pie_type div spr_pplen;
	
	draw_sprite_part(spr_pp, 0, pie_xx*pie_size, pie_yy*pie_size, pie_size, pie_size, 
		_xx, _yy);
		
}

// putting expressions as arguments gives values as default arg if not given
function oven_draw_arrow(_highlight, _ox, _oy, _oven_matches = true) {
	if (_oven_matches and place_meeting(x, y + machine_range, obj_player)) {
		var arrow_sprite = spr_oven_arrow;
		
		if (_highlight) {
			arrow_frame = run_animation(arrow_sprite, arrow_frame, 6, _ox, _oy);
		} else {
			// #problem DRAW TIMER HERE INSTEAD
			draw_sprite_ext(arrow_sprite, 0, _ox, _oy, 1, 1, 0, c_grey, 0.9);
		}
	}
}