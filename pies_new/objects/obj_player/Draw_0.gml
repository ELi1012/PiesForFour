


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


//spr_pill = spr_pill_7;


draw_set_alpha(alpha);

//DRAWING
draw_sprite_part_ext(spr_pill, 0, floor(x_frame)*frame_size, y_frame*frame_size, frame_size, frame_size, 
					xx, yy, 1, 1, c_white, alpha);


//spr_clothes = spr_body_2;

if (spr_clothes != -1) {
	draw_sprite_part(spr_clothes, 0, floor(x_frame)*frame_size, y_frame*frame_size, frame_size, frame_size, xx, yy);
}



// check if holding pie
var pie_hold = false;
var dd = ds_pie_carry;
if (!ds_list_empty(dd)) pie_hold = true;

//holding pie - draw it and the arm
if (pie_hold) {
	
	// loop through pies in list to draw
	// y offset is subtracted from base y
	for (var i = 0; i < ds_list_size(dd); i++) {
		var aa = alpha;
		with (dd[| i]) {
			draw_pie(0, 10 * i, aa);
		}
	}
	
	if (spr_clothes != -1) {
		draw_sprite_part(spr_clothes, 1, floor(x_frame)*frame_size, y_frame*frame_size, frame_size, frame_size, xx, yy);
	}
}


// draw arm of spr_pill

if (spr_pill != -1) {
	var arm_index = 1;
	if (pie_hold) arm_index = 2;
	else arm_index = 1;
	
	draw_sprite_part_ext(spr_pill, arm_index, floor(x_frame)*frame_size, y_frame*frame_size, frame_size, frame_size, 
					xx, yy, 1, 1, c_white, alpha);
}


//spr_hat = spr_head_7;
// draw hat
if (spr_hat != -1) {
	var hat_height = frame_size + hat_offset;
	draw_sprite_part(spr_hat, 0, floor(x_frame)*frame_size, y_frame*hat_height, frame_size, hat_height, xx, yy - hat_offset);
}






if (pill_transform) {
	if (transform_counter/room_speed >= transform_done) {
		pill_transform = false;
		transform_counter = 0;
		
	}
	transform_counter += 1;
}


// reset alpha
alpha = 1;
draw_set_alpha(1);




//FRAMES
x_frame += anim_speed/60;
if (x_frame >= anim_length) x_frame = 1;





