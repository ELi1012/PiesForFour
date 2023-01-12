


draw_sprite(spr_table, table_tier - 1, x, y);
draw_sprite(spr_dirtytable, table_index, x, y);

//table index 0 is clean table

if (claimed) {
	
	with (leader_inst) {
		if (state == c_states.eating) {
			
			var dd = 0; repeat (cluster_number) {
				with (cluster_id.ds_clustomers[# 0, dd]) {
					if (seated) {
						var anim_speed = 12;
						var anim_length = eating_framenum;
						
						
						draw_sprite_part(spr_customer_anim1, floor(eating_frame), 0, y_frame * frame_size, 
							frame_size, frame_size, x - x_offset, y - y_offset);
						
						//FRAMES
						eating_frame += anim_speed/60;
						if (eating_frame >= anim_length) eating_frame = 0;
						
					}
					
				}
				dd += 1;
			}
		}
	}
	
	//draw cluster number on table
	draw_sprite(spr_tablenumber, 0, table_middle_x, table_middle_y + 15);
	draw_set_color(c_black);
	draw_text(table_middle_x - 7, table_middle_y - 7, string(claimed_number));
	draw_set_color(c_white);
	
	//draw pie in center of table
	with (leader_inst) {
		if (state = c_states.eating) {
			var spr_pp = tiermaster.pie_sprite;
			var spr_pplen = 4;
			var pie_xx = other.pie_todraw mod spr_pplen;
			var pie_yy = other.pie_todraw div spr_pplen;
			var px = other.pie_x + other.x;
			var py = other.y - other.pie_size + 15;
			var ps = other.pie_size;
			
			draw_sprite_part(spr_pp, 2, pie_xx * ps, pie_yy * ps, ps, ps, px, py);
		
		}
	}
}









