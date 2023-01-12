var anim_length = 3;
var anim_speed = 12;



//CONTROLS
if (moveX > 0) y_frame = 0
else if (moveX < 0) y_frame = 1
else if	(moveY == 0)	x_frame = 0


//DRAWING



// draw outline if mouse is hovering over customer in front of line
var is_outlining = false;
if (state == state_lining and line_up_id == 1) {
	// check if leader is being hovered over
	
	if (bigman.mouse_above) {
		is_outlining = true;
	}
	
	if (is_outlining) outline_start(1, c_navy, spr_customer);
}


if (character_sprite == spr_customer) {
	if (random_timer/room_speed >= random_anim and !play_anim and state != state_eating) {
		var c = choose(1, 2, 3);
		if (c == 1) {
			play_anim = true;
			anim_to_play = non_idle_anim[irandom_range(0, non_idle_len - 1)];
			random_anim_len = sprite_get_number(anim_to_play);
		}
	
		random_timer = 0;
	
	} else random_timer += 1;
}

if (play_anim) {
	
	draw_sprite_part(anim_to_play, floor(r_frame/room_speed), floor(x_frame)*frame_size, 
	y_frame*frame_size, frame_size, frame_size, x - x_offset, y - y_offset);
	
	r_frame += r_spd;
	if (r_frame/room_speed >= random_anim_len) {
		play_anim = false;
		r_frame = 0;
	}
	
} else {
	draw_sprite_part(character_sprite, 0, floor(x_frame)*frame_size, 
		y_frame*frame_size, frame_size, frame_size, x - x_offset, y - y_offset);
}

// reset shader
if (is_outlining) outline_end();


//draw arrows
if (cluster_selected) {
	
	// draw arrow over table if leader
	if (is_leader) {
		var arrow_width = 64;
		var arrow_height = 32;
	
	
		with (obj_table) {
			//draw table arrow
			if (!claimed) {
				var tb = instance_place(mouse_x, mouse_y, obj_table);
				if (tb != noone) {
					tb.mouse_above = true;
				}
			
				var aw = par_customer.arrow_width;
				var ah = par_customer.arrow_height;
			
				draw_sprite_part(spr_selected, 1, floor(arrow_frame)*aw, 0, aw, 
				ah, x + (table_width/2) - (aw/2), y - sprite_get_yoffset(spr_table) - ah);
			
			
				arrow_frame += anim_speed/60;
				if (arrow_frame >= 5) { arrow_frame = 0; }
			}
		}
	}
	
	//draw customer arrow
	var arrow_width = 64;
	var arrow_height = 32;
	draw_sprite_part(spr_selected, 0, floor(arrow_frame)*arrow_width, 0, arrow_width, 
	arrow_height, x - x_offset, y - y_offset - arrow_height);
	
	arrow_frame += anim_speed/60;
	if (arrow_frame >= 5) { arrow_frame = 0; }
	
}


//FRAMES
x_frame += anim_speed/60;
if (x_frame >= anim_length) x_frame = 1;


//draw wanted pie in speech bubble
if (all_seated and !order_taken and !angered) {
	var table_midx = set_table.table_middle_x;
	var table_midy = set_table.table_middle_y;
	var bubble_size = sprite_get_height(spr_piebubble);
	var pie_size = 64;
	var piespr_width = 4;
	
	var pie_xx = pie_wanted mod piespr_width;
	var pie_yy = pie_wanted div piespr_width;
	
	var bb_xx = table_midx - (bubble_size/2);		// x coordinate of bubble
	var bb_yy = table_midy - bubble_size - 10;		// y coordinate of bubble
	
			
	// check if mouse is hovering over it
	var is_hovering = point_in_rectangle(mouse_x, mouse_y, bb_xx, bb_yy, bb_xx + bubble_size, bb_yy + bubble_size)
	if (is_hovering) outline_start(2, c_black, spr_piebubble);
			
	//draw speech bubble and pie
	draw_sprite(spr_piebubble, 0, bb_xx, bb_yy);
	if (is_hovering) outline_end();
	
	draw_sprite_part(tiermaster.pie_sprite, 0, pie_xx * pie_size, pie_yy * pie_size, pie_size, pie_size, 
		table_midx - 32, table_midy - bubble_size - 10 + 8);
		
}

//draw time left
if (is_leader) {
	if (state != state_leaving and state != state_eating and mouse_above) {
	
		var time_passed = c_timer/room_speed;
		var rot = -((time_passed/time_given) * 360 - 90);
		var cc = c_white;
		
		if (time_passed > (time_given * 0.75)) {
			var red_amount = (time_passed - (time_given * 0.75))/(time_given * 0.25) * 255;
			cc = make_color_rgb(255, 255 - red_amount, 255 - red_amount);
			show_debug_message(red_amount);
		}
	
	
		var marginx = (frame_size/2);
		var tx = (x - x_offset) + marginx;
		var ty = y - y_offset - 10;
		
			// origin of sprite is at the center
	
		draw_sprite_ext(spr_timer, 0, tx, ty, 1, 1, 0, cc, 1);
		draw_sprite_ext(spr_timer, 1, tx, ty, 1, 1, rot, c_white, 1)
	
	}
}















