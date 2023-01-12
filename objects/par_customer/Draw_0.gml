var anim_length = 3;
var anim_speed = 12;



//CONTROLS
if (moveX > 0) y_frame = 0
else if (moveX < 0) y_frame = 1
else if	(moveY == 0)	x_frame = 0


//DRAWING
if (character_sprite == spr_customer) {
	if (random_timer/room_speed >= random_anim and !play_anim and state != c_states.eating) {
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

//draw arrows
if (cluster_selected) {
	var arrow_width = 64;
	var arrow_height = 32;
	
	with (obj_table) {
		//draw table arrow
		if (!claimed) {
			var aw = par_customer.arrow_width;
			var ah = par_customer.arrow_height;
			
			draw_sprite_part(spr_selected, 0, floor(arrow_frame)*aw, 0, aw, 
			ah, x + (table_width/2) - (aw/2), y - sprite_get_yoffset(spr_table) - ah);
			
			arrow_frame += anim_speed/60;
			if (arrow_frame >= 5) { arrow_frame = 0; }
		}
	}
	
	//draw customer arrow
	if (cluster_selected) { //cluster is only selected if customer is leader
		var dd = 0;
		
		repeat(cluster_number) {
			with (cluster_id.ds_clustomers[# 0, dd]) {
				var arrow_width = 64;
				var arrow_height = 32;
				draw_sprite_part(spr_selected, 0, floor(other.arrow_frame)*arrow_width, 0, arrow_width, 
				arrow_height, x - x_offset, y - y_offset - arrow_height);
			}
			
		dd += 1;
		}
	}
	
	
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
	
	//draw speech bubble and pie
	draw_sprite(spr_piebubble, 0, table_midx - (bubble_size/2), table_midy - bubble_size - 10);
	draw_sprite_part(tiermaster.pie_sprite, 0, pie_xx * pie_size, pie_yy * pie_size, pie_size, pie_size, 
		table_midx - 32, table_midy - bubble_size - 10 + 8);
		
}

//draw time left
if (is_leader) {
	if (state != c_states.leaving and state != c_states.eating) {
	
		var time_left = time_given - (c_timer/room_speed);
		//draw_text(x, y - y_offset - 50, string(time_left));
	
	
		var width = sprite_get_width(spr_timer);
		var height = sprite_get_height(spr_timer);
		var margin = 1;
	
	
		var marginx = (frame_size/2) - (width/2);
		var tx = (x - x_offset) + marginx;
		var ty = y - y_offset;
	
		draw_sprite(spr_timer, 1, tx, ty);
		draw_sprite_part(spr_timer, 0, margin, 0, ((time_left/time_given) * (width - (margin * 2))), height, tx, ty);
	
	}
	
}















