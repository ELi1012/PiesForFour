if (!show_wardrobe) exit;


var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);


	// draw background
draw_sprite(spr_wd_background, 0, wd_bg_x, wd_bg_y); //cut out transparent chunk and place above other sprites
draw_sprite(spr_wd_innerbg, 0, wd_innerbg_x, wd_innerbg_y);

draw_sprite(spr_wd_grid, 0, grid_x, grid_y);


			//WARDROBE ARGS
			//arg 0: sprite
			//arg 1: name
			//arg 2: description


var startfrom = grid_cellnum * page_index;		// index to start from
var repeatthese = display_num - startfrom;		// how many clothes to draw
var repeatthese = clamp(repeatthese, 0, grid_cellnum);

	// draw icons in grid
if (ds_selected[# 0, 0] != -1) {
	var ii = startfrom; repeat (repeatthese) {
		var px = ((ii - startfrom) mod grid_hblocks);
		var py = ((ii - startfrom) div grid_hblocks);
	
		if (ds_selected == ds_owned_head or ds_selected == ds_owned_body) {
			var _spr = ds_selected[# 0, ii];
			var yoffset = 0;
			//if (ds_selected == ds_owned_head) yoffset = hat_offset;
			
			draw_sprite_part(_spr, 0, 0, 0, cell_size, cell_size, (px * cell_withbuffx) + grid_x + cell_xbuff, 
				(py * cell_withbuffy) + grid_y + cell_ybuff + yoffset);
			
		} else if (ds_selected == ds_owned_pill) {
			
				// icons are contained in subimages instead of a sprite sheet
			draw_sprite_part(spr_pill_icons, ds_pill_info[# 0, ii], 0, 0, cell_size, cell_size, 
				(px * cell_withbuffx) + grid_x + cell_xbuff, (py * cell_withbuffy) + grid_y + cell_ybuff);
		
		}
		
		ii += 1;
	}
}


//------------------ DRAW ICON WITH PLAYER
#region display player to the right
draw_sprite(spr_wd_descbox, 0, wd_desc_x, wd_desc_y);


	// display selected cloth
	// selected_cloth == -1 IF nothing is being shown ie full view of player with clothes is visible (not just inidividual clothing)
if (selected_cloth != -1) {
	
	
	//draw clothes on player
	if (ds_selected == ds_owned_head or ds_selected == ds_owned_body) {
		var yoffset = 0;
		var scale = 2;
		var xx = desc_iconx;
		var yy = desc_icony - yoffset;
		if (ds_selected == ds_owned_head) yoffset = (16 * scale);
		
		draw_sprite_part_ext(selected_cloth, 0, 0, 0, cell_size, cell_size, xx, yy, scale, scale, c_white, 1);
		
	} else if (ds_selected == ds_owned_pill) {
		var scale = 2;
		draw_sprite_part_ext(spr_pill_icons, ds_pill_info[# 0, cloth_index], 0, 0, cell_size, cell_size, 
			desc_iconx, desc_icony, scale, scale, c_white, 1);
		
	}
	
	//draw text
	draw_set_valign(fa_bottom);
	//draw_text_ext(wd_desc_titlex, wd_desc_titley, string(ds_selected[# 1, sc]), 8, wd_desc_textwidth)
	
		// name
	draw_text(wd_desc_titlex, wd_desc_titley, string(ds_selected[# 1, cloth_index]));
	
	draw_set_valign(fa_top);
	
		// description
	draw_text_ext(wd_desc_textx, wd_desc_texty, string(ds_selected[# 2, cloth_index]), 20, wd_desc_textwidth);
	
		// pill number
	if (ds_selected == ds_owned_pill) {
		draw_text_ext(wd_desc_textx, wd_desc_texty + 20, string("pills left: "+string(ds_pill_info[# 1, cloth_index])), 20, wd_desc_textwidth);
	}
	
	
	
	var cblend = c_white;
	var equip_index = 0;		// 0: equip; 1: unequip
	
	//draw equip button
	if (!already_equipped) {
		//draw greyed out button if:
		//pressing on button
		if (mouse_check_button(mb_left) and mouse_over_button(equip_button, mx, my)) cblend = c_gray;
		equip_index = 0;
		
	} else if (selected_cloth == equipped_pill or selected_cloth == equipped_hat or selected_cloth == equipped_clothes) {
	
		// draw unequip button if selected item is already equipped
		
		if (mouse_check_button_pressed(mb_left) and mouse_over_button(equip_button, mx, my)) cblend = c_gray;
		equip_index = 1;
	
	}
	
	draw_sprite_ext(spr_wd_equip, equip_index, icon_equipx, icon_equipy, 1, 1, 0, cblend, 1);
	
	
	
} else { // nothing selected; display current attire
	
		//display icon is set by page incrementer
		//will only set to -1 if nothing equipped in current hat/clothes slot
	
		// something to display
	if (display_icon != -1) {
		
			// draw highlight around icon
		if (mouse_over_button(icon_square, mx ,my)) draw_sprite(spr_wd_highlight, 0, desc_iconx, desc_icony); 
			
		
		if (icon_index == 0) {
				// draw equipped pill
			if (equipped_pill != spr_player) {
				draw_sprite_part_ext(spr_pill_icons, pill_index, 0, 0, cell_size, cell_size, 
					desc_iconx, desc_icony, 2, 2, c_white, 1);
					
			} else { //draw player with currently equipped clothes
				var scale = 2;
				var yoffset = 16 * scale;
				var xx = desc_iconx;
				var yy = desc_icony;
				
				draw_sprite_part_ext(spr_player, 0, 0, 0, cell_size, cell_size, desc_iconx, desc_icony, 2, 2, c_white, 1);
				if (equipped_hat		!= -1) draw_sprite_part_ext(equipped_hat, 0, 0, 0, cell_size, cell_size, xx, yy - yoffset, scale, scale, c_white, 1);
				if (equipped_clothes	!= -1) draw_sprite_part_ext(equipped_clothes, 0, 0, 0, cell_size, cell_size, xx, yy, scale, scale, c_white, 1);
				
			}
			
			
			
		} else if (icon_index != 0) { //draw clothes/hat for selecting
			if (display_icon != spr_pill_icons) {
				draw_sprite_part_ext(display_icon, 0, 0, 0, cell_size, cell_size, desc_iconx, desc_icony, 2, 2, c_white, 1);
			}
			
			else {
				draw_sprite_part_ext(spr_pill_icons, pill_index, 0, 0, cell_size, cell_size, desc_iconx, desc_icony, 2, 2, c_white, 1);
			}
			
		}
		
		
	} else if (display_icon == -1) {
		//draw text
		draw_set_halign(fa_middle);
		draw_set_valign(fa_middle);
		var ddtx = desc_iconx + (desc_iconsize/2);
		var ddty = desc_icony + (desc_iconsize/2);
		
		
		//nothing to display
		if (icon_index = 0) draw_sprite_part_ext(spr_player, 0, 0, 0, cell_size, cell_size, desc_iconx, desc_icony, 2, 2, c_white, 1);
		else if (icon_index = 1) {
			draw_text_ext(ddtx, ddty, "no hat equipped", 16, wd_iconwidth);
		} else if (icon_index = 2) {
			draw_text_ext(ddtx, ddty, "no clothes equipped", 16, wd_iconwidth);
			
		}
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
	
	var cblend = c_white;
	
		// draw unequip button if not displaying player with all items equipped
		// and if there is something equipped in the current category
	if (!(icon_index == display_icons.display_player and equipped_pill == spr_player) and display_icon != -1) {
		if (mouse_over_button(equip_button, mx, my)) cblend = c_gray;
	
		draw_sprite_ext(spr_wd_equip, 1, icon_equipx, icon_equipy, 1, 1, 0, cblend, 1);
	
	}
	
}

#endregion display right icon


var ind;
var ii = 0; repeat (3) {
	ind = 0;
	if (ds_selected == clothing_type_array[ii]) ind = 1;
	
	draw_sprite_part(spr_wd_icon, ind, ii * wd_iconwidth, 0, wd_iconwidth, wd_iconheight,
		wd_icon_x  + (wd_iconwidth * ii), wd_icon_y);
	ii += 1;
}

draw_sprite(spr_wd_arrow, 0, wd_arrow_lx, wd_arrow_y);
draw_sprite(spr_wd_arrow, 1, wd_arrow_rx, wd_arrow_y);













