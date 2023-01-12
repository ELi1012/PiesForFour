if (!show_wardrobe) exit;



draw_sprite(spr_wd_background, 0, wd_bg_x, wd_bg_y); //cut out transparent chunk and place above other sprites
draw_sprite(spr_wd_innerbg, 0, wd_innerbg_x, wd_innerbg_y);


draw_sprite(spr_wd_grid, 0, wd_grid_x, wd_grid_y);

var startfrom = wd_grid_cellnum * wd_pageinc;
var repeatthese = wd_grid_displaynum - startfrom;
var repeatthese = clamp(repeatthese, 0, wd_grid_cellnum);

if (ds_selected[# 0, 0] != -1) {
	var ii = startfrom; repeat (repeatthese) {
		var px = ((ii - startfrom) mod wd_grid_hblocks);
		var py = ((ii - startfrom) div wd_grid_hblocks);
	
		if (ds_selected == ds_owned_head or ds_selected == ds_owned_body) {
			var draw_id = ds_selected[# 0, ii];
			draw_sprite_part(wd_grid_displayarray[draw_id], 0, 0, 0, cell_size, cell_size, (px * cell_withbuffx) + wd_grid_x + cell_xbuff, 
				(py * cell_withbuffy) + wd_grid_y + cell_ybuff);
			
		} else if (ds_selected == ds_owned_pill) {
			//location on sprite sheet
			var iidd = ds_selected[# 0, ii];
			var pl_sprsheet_hblocks = 4;
		
			var xx = iidd mod pl_sprsheet_hblocks;
			var yy = iidd div pl_sprsheet_hblocks;
		
			draw_sprite_part(spr_clothing_pill, 0, xx * cell_size, yy * cell_size, cell_size, cell_size, 
				(px * cell_withbuffx) + wd_grid_x + cell_xbuff, (py * cell_withbuffy) + wd_grid_y + cell_ybuff);
		
		}
		
		ii += 1;
	}
}

#region display icon to the right
draw_sprite(spr_wd_descbox, 0, wd_desc_x, wd_desc_y);

if (selected_cloth > -1) { //display selected cloth
	var sc = selected_cloth;
	var scc = wd_grid_displayarray[cloth_id];
	
	var cblend = c_white;
	
	//draw equip button
	if (!already_equipped) {
		//draw greyed out button if:
		//pressing on button
		if (mouse_check_button(mb_left) and instance_place(mouse_x, mouse_y, icon_equip)) cblend = c_gray;
		
		//if selecting pill while pill is already equipped
		if (stats_pill != spr_player) cblend = c_gray;
		
	} else cblend = c_gray;
	
	draw_sprite_ext(spr_wd_equip, 0, icon_equipx, icon_equipy, 1, 1, 0, cblend, 1);
	
	
	//draw sprite
	if (ds_selected == ds_owned_head or ds_selected == ds_owned_body) {
		draw_sprite_part_ext(scc, 0, 0, 0, cell_size, cell_size, wd_desc_iconx, wd_desc_icony, 2, 2, c_white, 1);
	} else if (ds_selected == ds_owned_pill) {
		draw_sprite_part_ext(spr_clothing_pill, 0, (temp_pill_id mod pill_hcells) * cell_size, (temp_pill_id div pill_hcells) * cell_size, cell_size, cell_size, 
			wd_desc_iconx, wd_desc_icony, 2, 2, c_white, 1);
	}
	
	//draw text
	draw_set_valign(fa_bottom);
	//draw_text_ext(wd_desc_titlex, wd_desc_titley, string(ds_selected[# 1, sc]), 8, wd_desc_textwidth)
	draw_text(wd_desc_titlex, wd_desc_titley, string(ds_selected[# 1, sc]));
	
	draw_set_valign(fa_top);
	draw_text_ext(wd_desc_textx, wd_desc_texty, string(wd_grid_descarray[cloth_id]), 20, wd_desc_textwidth)
	
	
	
} else { //display current attire
	
	if (icon_displaycur != -1) { //something equipped
		//displaycur is set by page incrementer
		//wil only set displaycur to -1 if nothing equipped in current hat/clothes slot
		var mx = device_mouse_x_to_gui(0);
		var my = device_mouse_y_to_gui(0);
		
		
		if (place_meeting(mx, my, obj_backbutton)) {
			var inst = instance_place(mx, my, obj_backbutton);
			if (inst == icon_pic) draw_sprite(spr_wd_highlight, 0, wd_desc_iconx, wd_desc_icony); 
			
		}
		
		if (icon_displayinc = 0) {
			if (equip_pill != spr_player) {
				draw_sprite_part_ext(spr_clothing_pill, 0, (pill_id mod pill_hcells) * cell_size, (pill_id div pill_hcells) * cell_size, cell_size, cell_size, 
					wd_desc_iconx, wd_desc_icony, 2, 2, c_white, 1);
					
			} else { //draw player with currently equipped clothes
				draw_sprite_part_ext(icon_displaycur, 0, 0, 0, cell_size, cell_size, wd_desc_iconx, wd_desc_icony, 2, 2, c_white, 1);
				if (equip_hat		!= -1) draw_sprite_part_ext(equip_hat, 0, 0, 0, cell_size, cell_size, wd_desc_iconx, wd_desc_icony, 2, 2, c_white, 1);
				if (equip_clothes	!= -1) draw_sprite_part_ext(equip_clothes, 0, 0, 0, cell_size, cell_size, wd_desc_iconx, wd_desc_icony, 2, 2, c_white, 1);
				
			}
			
			
			
		} else { //draw clothes/hat
			draw_sprite_part_ext(icon_displaycur, 0, 0, 0, cell_size, cell_size, wd_desc_iconx, wd_desc_icony, 2, 2, c_white, 1);
			
		}
		
		
	} else if (icon_displaycur == -1) {
		//draw text
		draw_set_halign(fa_middle);
		draw_set_valign(fa_middle);
		var ddtx = wd_desc_iconx + (wd_desc_iconsize/2);
		var ddty = wd_desc_icony + (wd_desc_iconsize/2);
		
		
		//nothing to display
		if (icon_displayinc = 0) draw_sprite_part_ext(spr_player, 0, 0, 0, cell_size, cell_size, wd_desc_iconx, wd_desc_icony, 2, 2, c_white, 1);
		else if (icon_displayinc = 1) {
			draw_text_ext(ddtx, ddty, "no hat equipped", 16, wd_iconwidth);
		} else if (icon_displayinc = 2) {
			draw_text_ext(ddtx, ddty, "no clothes equipped", 16, wd_iconwidth);
			
		}
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
	
	var cblend = c_white;
	
	//draw unequip button
	if (icon_displaycur == spr_player or icon_displaycur == -1) cblend = c_gray
	else if (mouse_check_button(mb_left) and instance_place(mouse_x, mouse_y, icon_equip)) cblend = c_gray;
	
	draw_sprite_ext(spr_wd_equip, 1, icon_equipx, icon_equipy, 1, 1, 0, cblend, 1);
	
	
	
}

#endregion display right icon



var ii = 0; repeat (3) {
	draw_sprite(spr_wd_icon, ii, wd_icon_x  + (wd_iconwidth * ii), wd_icon_y);
	ii += 1;
}

draw_sprite(spr_wd_arrow, 0, wd_arrow_lx, wd_arrow_y);
draw_sprite(spr_wd_arrow, 1, wd_arrow_rx, wd_arrow_y);




/*
with (obj_backbutton) {
	draw_rectangle(x, y, x + (bbox_right - bbox_left), y + (bbox_bottom - bbox_top), true);
}
*/











