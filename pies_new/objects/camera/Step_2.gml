#macro view view_camera[0]

camera_set_view_size(view, view_width, view_height);

if (instance_exists(obj_player)) {
	var _xo = view_width/2;
	var _yo = view_height/2;
	
	x = clamp(x, following.x - distance, following.x + distance);
	y = clamp(y, following.y - distance, following.y + distance);
	
	
	if (room == rm_main_ext) {
		var _y = clamp(y, _yo, room_height + _yo) - _yo;
		sect_one = 992;
	}
	else if (room == rm_main) {
		var _y = (room_height/2) - _yo;
		sect_one = 928;
	}
	
	//var _x = clamp(x, _xo, sect_one - (view_width/2)) - _xo;
	var _x = clamp(x, _xo, room_width - _xo) - _xo;
	
	if (room != rm_attic) {
		//if (obj_player.x > sect_one) _x = sect_one;
		//else x = sect_one;
	} else if (room = rm_attic) {
		_x = (room_width/2) - _xo;
		_y = (room_height/2) - _yo;
		
	}
	
	var _cur_x = camera_get_view_x(view);
	var _cur_y = camera_get_view_y(view);
	
	var _spd = 0.1;
	
	_x = lerp(_cur_x, _x, _spd);
	_y = lerp(_cur_y, _y, _spd);
	
	global.camerax = _x;
	global.cameray = _y;
	
	camera_set_view_pos(view, _x, _y);
	
	/*
	x = clamp(x, following.x - distance, following.x + distance);
	y = clamp(y, following.y - distance, following.y + distance);
	
	var _x = clamp(x, view_width/2, room_width - view_width/2);
	var _y = clamp(y, view_height/2, room_height - view_height/2);
	
	camera_set_view_pos(view, _x - view_width/2, _y - view_height/2);
	
	
	var _cur_x = camera_get_view_x(view);
	var _cur_y = camera_get_view_y(view);
	
	var _spd = 0.1;
	
	camera_set_view_pos(view, 
						lerp(_cur_x, _x  - view_width/2, _spd),
						lerp(_cur_y, _y  - view_height/2, _spd));
	*/
						
} else if (obj_catalogue.editing_room) {
	
	move_camx = 0;
	move_camy = 0;
	
	move_camx = keyboard_check(ord("D")) - keyboard_check(ord("A"));
	move_camy = keyboard_check(ord("S")) - keyboard_check(ord("W")); //if (move_camx == 0)
	
	var _x = cam_speed * move_camx;
	var _y = cam_speed * move_camy;
	
	x += _x;
	y += _y;
	
	x = clamp(x, 0, room_width - view_width);
	
	if (room == rm_main_ext) y = clamp(y, 0, room_height - view_height);
	else if (room == rm_main) y = (room_height/2) - view_height/2;
	
	
	camera_set_view_pos(view, x, y);
	
	
}










