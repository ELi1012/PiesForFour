var anim_length = 3;
var anim_speed = 12;


//CONTROLS
if (moveX > 0) y_frame = 0
else if (moveX < 0) y_frame = 1
else if	(moveY == 0)	x_frame = 0


//DRAWING

draw_sprite_part_ext(spr_customer, 0, floor(x_frame)*frame_size, 
	y_frame*frame_size, frame_size, frame_size, x - x_offset, y - y_offset, size_scale, size_scale, c_white,
	1);

//FRAMES
x_frame += anim_speed/60;
if (x_frame >= anim_length) x_frame = 1;