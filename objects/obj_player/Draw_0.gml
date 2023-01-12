if (spr_pill == spr_sprike) {
	draw_sprite(spr_sprike, floor(frame), x, y);
	exit;
}

var frame_size = 64
var anim_length = 3
var anim_speed = 12

//CONTROLS

if (moveX > 0) y_frame = 0
else if (moveX < 0) y_frame = 1
else if	(moveY == 0)	x_frame = 0

var xx = x - x_offset;
var yy = y - y_offset;

// y_frame determines type of walk cycle not y direction


//DRAWING
draw_sprite_part(spr_pill, 0, floor(x_frame)*frame_size, y_frame*frame_size, frame_size, frame_size, xx, yy);

var pie_hold = false;

if (pie_selected != -1) {
	//set sprite index to 1
	//pie selected is set to -1 in step event if not selected
	if (instance_exists(pie_selected)) pie_hold = true;
}

if (spr_blothes != -1) draw_sprite_part(spr_blothes, 0, floor(x_frame)*frame_size, y_frame*frame_size, frame_size, frame_size, xx, yy);

//holding pie - draw it and the arm
if (pie_hold) {
	if (spr_blothes != -1) draw_sprite_part(spr_blothes, 1, floor(x_frame)*frame_size, y_frame*frame_size, frame_size, frame_size, xx, yy);
	with (pie_selected) event_perform(ev_draw, 0);
	
}


if (spr_hat != -1) draw_sprite_part(spr_hat, 0, floor(x_frame)*frame_size, y_frame*frame_size, frame_size, frame_size, xx, yy);

if (pill_transform) {
	if (transform_counter/room_speed >= transform_done) {
		pill_transform = false;
		transform_counter = 0;
		
	}
	
	transform_counter += 1;
}





//FRAMES
x_frame += anim_speed/60;
if (x_frame >= anim_length) x_frame = 1;





