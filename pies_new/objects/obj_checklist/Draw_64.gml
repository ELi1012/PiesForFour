if (global.game_pause) exit;


orderheight = ds_grid_height(ds_orders);



// draw notification button when new order is added
if (new_order) {
	var notif_width = 32;
	// function returns the new incremented frame
	nframe = run_animation(spr_notif, nframe, 10, x_outview - notif_width - 20, y_pos + floor(list_height/3));
	
	//nframe += nspeed/60;
}


// draw orders on sheet
if (tables_ordered > 0 and (in_view or move_checklist)) {
	//DRAWS ORDER OF CUSTOMERS WHO HAVE BEEN SEATED
	
	//if all values are being set to 0 - issue with grid resizing
	//IF DRAW SPRITE PART IS UNDEFINED ds_orders[# 2, list_inc]; DOES NOT EXIST AS A VALUE
	//might happen when cluster number 0 is found at top of the grid and there are
	//multiple customer groups
	
	
	//undefined if no customers are taking orders
	var cluster = ds_orders[# 0, list_inc];
	var pietype = ds_orders[# 1, list_inc];
	var slices_temp = ds_orders[# 2, list_inc];
	var note_array = ds_orders[# 3, list_inc];
	var slices_len = array_length(slices_temp);
	var note_size = 32;
	
	
	//draw background
	draw_sprite_ext(spr_checklist, 0, x_pos, y_pos, scale, scale, 0, c_white, 1);
	
	//draw pie name
	
	//ds_pie_t3[# 2, yy]
	
	var pieds = tiermaster.tier_ds;
	draw_text(x_pos + 20, y_pos + 20, string(pieds[# 2, pietype]));
	
	
	//draw cluster number and pie
	var spr_pplen = 4;
	var text_x = x_pos + x_margin;
	var text_y = y_pos + y_margin;
	
	draw_text(text_x, text_y, "for table " + string(cluster));
	draw_sprite_part_ext(tiermaster.pie_sprite, 0, (pietype mod spr_pplen)* pie_size, (pietype div spr_pplen) * pie_size, pie_size, pie_size,
		x_pos, y_pos + y_margin, 2, 2, c_white, 1);
	
	/*
	//draw slice numbers
	var ii = 0; repeat(slices_len) {
		draw_text(x_pos + (x_margin * 2), y_pos + y_margin + (20 * scale * (ii + 1)), "slice " + string(slices_temp[ii]));
		
		ii += 1;
	}
	
	*/
	
	//draw note symbols
	
	note_rows = 0;
	var ii = 0; repeat (slices_len) {
		
		var sbsb = note_array[ii];
		var note_width = note_size;
		var note_sprite = spr_notesymbols;
		var row_margin = 10;
		var moddy = 5;
		var max_in_row = 2;
		
		//check if note is tied
		if (sign(sbsb) = -1) {
			sbsb = -sbsb;
			moddy = 3;
			note_width = note_size * 2;
			note_sprite = spr_tiednotes;
			max_in_row = 1;
			//might have to have a variable for x margin
		}
		
		if (ii mod max_in_row == 0) note_rows += 1;
		
		var notex = sbsb mod moddy;
		var notey = sbsb div moddy;
		var notemx = note_spacing + note_width;
		
		draw_sprite_part(note_sprite, 0, notex * note_width * scale, notey * note_size * scale, note_width * scale, 
				note_size * scale, x_pos + note_marginx + (notemx * (ii mod max_in_row)), 
				y_pos + y_margin + ((note_size + row_margin) * note_rows));
				
		
		//y_pos + note_marginy + (20 * scale * (ii + 1))
		
		ii += 1;
	}
	
		
} else { //no orders
	
	//draw background and text
	draw_sprite_ext(spr_checklist, 0, x_pos, y_pos, scale, scale, 0, c_white, 1);
	draw_text(x_pos + x_margin + 10, y_pos + y_margin, "no orders!");
	
}


#region show ds grid (debugging)
/*
var ddd = 0; repeat (orderheight) {
	draw_text(512, 300 + (50 * ddd), string(ds_orders[# 0, ddd]));
	draw_text(512 + 40, 300 + (50 * ddd), string(ds_orders[# 1, ddd]));
	draw_text(512 + 80, 300 + (50 * ddd), string(ds_orders[# 2, ddd]));
	draw_text(512 + 120, 300 + (50 * ddd), string(ds_orders[# 3, ddd]));
	
	ddd += 1;
	
	
}
*/

#endregion









