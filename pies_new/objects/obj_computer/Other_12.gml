/// @description state specific draw events

desktop_page_draw = function(mx, my) {
	draw_sprite(cm_background, 0, screen_x, screen_y);

	draw_sprite(cm_folders, 0, cm_icon_cx, cm_icon_cy);
	draw_sprite(cm_folders, 1, cm_icon_ix, cm_icon_iy);
	draw_sprite(cm_folders, 2, cm_icon_rx, cm_icon_ry);
	draw_sprite(cm_folders, 3, cm_icon_px, cm_icon_py);
	draw_sprite(cm_folders, 4, cm_icon_sx, cm_icon_sy);
	draw_sprite(cm_folders, 5, cm_icon_ex, cm_icon_ey);
}


#region room editor
room_editor_draw = function (mx, my) {
	draw_sprite_part(page_sprite, 0, 0, mouse_scroll, cm_window_width, cm_window_height, cm_window_x, cm_window_y);
	
}

#endregion


#region draw clothes website
clothes_storefront_draw = function(mx, my) {
	
	// draw background
	draw_sprite_part(page_sprite, 0, 0, mouse_scroll, gui_width, cm_window_height, cm_window_x, cm_window_y);
	
	var startfrom = cloth_pageinc * page_icon_num;
	var display_these = clamp(cloth_displaynum - startfrom, 0, page_icon_num);
		
	var ii = startfrom; repeat (display_these) {
		
		var _spr = ds_selected[# 0, ii];		// spritesheet containing clothing
		var yoffset = 0;
		if (ds_selected == ds_head) yoffset = hat_offset;
		
		//location on screen
		var px = ((ii - startfrom) mod page_rows) * (cell_size + x_buffer);
		var py = ((ii - startfrom) div page_rows) * (cell_size + y_buffer);
			
		
		draw_sprite_part(_spr, 0, 0, 0, cloth_displaysize,
			cloth_displaysize + yoffset, clot_marginx + px, clot_marginy + py - mouse_scroll); // no offset
			
		ii += 1;
	}
		
	if (show_purchase) {
		var _spr = ds_selected[# 0, selected_cloth_index];		// spritesheet containing clothing
		var yoffset = 0;
		if (ds_selected == ds_head) yoffset = hat_offset;
		
		var disx = cloth_spx + 20;
		var disy = cloth_spy + 24;
			
			
		draw_set_alpha(0.3);
		draw_set_color(c_black);
		draw_rectangle(0, 0, gui_width, gui_height, false);
		draw_set_color(c_white);
		draw_set_alpha(1);
			
		draw_sprite(spr_clothes_confirm, 0, cloth_spx, cloth_spy);
		
		draw_sprite_part_ext(_spr, 0, 0, 0, cloth_displaysize,
		cloth_displaysize + yoffset, disx, disy - yoffset, 2, 2, c_white, 1);
			
	}
}

#endregion


#region draw furniture/wallpaper website

interior_page_draw = function(mx, my) {
			// draw background
	draw_sprite_part(page_sprite, 0, 0, mouse_scroll, cm_window_width, cm_window_height, cm_window_x, cm_window_y);
	
	if (place_meeting(mx, my, obj_clickbox)) {
		var inst = instance_place(mx, my, obj_clickbox);
		var o = inst.optional_variable;
		var xx = inst.x;
		
			// draw grey box over tab if hovering
		if (xx == interior_tabs.table_x or xx = interior_tabs.oven_x) {
			
			var w = sprite_get_width(spr_clickbox);
			var xx = inst.x;
			var yy = inst.y;
			
			draw_set_color(c_gray);
			draw_set_alpha(0.2);
			draw_rectangle(xx, yy, xx + (inst.image_xscale * w), yy + (inst.image_yscale * w), false);
			draw_set_color(c_white);
			draw_set_alpha(1);
		}
		
	}
	
		// draw buy buttons
	var t = interior_tabs;
	draw_sprite(spr_int_buttons, 0, t.buy_furniture_x, t.buy_button_y);
 	if (current_tab == t.oven) draw_sprite(spr_int_buttons, 1, t.buy_ext_x, t.buy_button_y);
	
		
		// draw rectangle
	var w = 150;						var h = 86;
	var xx = 32 + cm_window_x;			var yy = 96 + cm_window_y;
	draw_set_color(c_black);
	draw_set_alpha(0.3);
	draw_rectangle(xx, yy, xx + w, yy + h, false);
	draw_set_color(c_white);
	draw_set_alpha(1);
	
	var _tabs = interior_tabs;
	var _spr;
	
	if (current_tab == _tabs.table) _spr = spr_table;
	else if (current_tab == _tabs.oven) _spr = spr_piemachine;
	
		// draw table or oven
	
	var xoffset = sprite_get_xoffset(_spr);		var yoffset = sprite_get_yoffset(_spr);
	var tw = sprite_get_width(_spr);				var th = sprite_get_height(_spr);
		
	draw_sprite(_spr, int_index, xx + xoffset + (w/2) - (tw/2), yy + yoffset + (h/2) - (th/2));
	
	
	
	
}

#endregion






#region draw company website
company_homepage_draw = function(mx, my) {
	// nothing to draw here
		// draw background
	draw_sprite_part(page_sprite, 0, 0, mouse_scroll, gui_width, screen_height, screen_x, screen_y + upper_taskbar);
}

company_statistics_draw = function(mx, my) {
	
		// draw background
	draw_sprite_part(page_sprite, 0, 0, mouse_scroll, gui_width, screen_height, screen_x, screen_y + upper_taskbar);
	
		//current tier
	draw_set_font(fnt_cmp);
	draw_set_color(c_black);
	draw_text(st_marginx, st_tiertexty - mouse_scroll, "Current tier: " + string(obj_stats.tier));
		
		
	draw_set_font(fnt_cmp_small);
	var t = obj_stats.tier;
	var t_inc = tiermaster.tier_inc;
	var can_upgrade = true;
	var tier_string, req_string;
		
		
	if (t < tiermaster.max_tier) {
			
		if (tier_req[t] > obj_stats.rating or tier_upgrade[t] > obj_stats.piebucks) can_upgrade = false;
			
		var rt_star = floor(tier_req[t]/t_inc);
			
		tier_string = "Cost to upgrade tier: " + string(tier_upgrade[t]);
		req_string = "Rating needed for upgrade: " + string(rt_star) + " stars";
			
			
			
			
	} else {
		can_upgrade = false;
			
		tier_string = "Maxed out tier";
		req_string = " ";
	}
		
	var swidth = string_width(tier_string);
	var inmargin = 15;
	var final_x = st_marginx_rj - inmargin - swidth;
	var twidth = (page_width + page_marginx) - final_x - inmargin;
		
		
	draw_text(final_x, st_upgradetiery - mouse_scroll, string(tier_string));
	draw_text_ext(final_x, st_upgradetiery + 20 - mouse_scroll, string(req_string), 20, twidth);
	draw_set_font(fnt_cmp);
		
		
	var ind = 0;
	if (!can_upgrade) ind = 1;
	else if (mouse_check_button_pressed(mb_left)) {
		if (instance_place(mouse_x, mouse_y, obj_clickbox) == st_upgrade) ind = 1;
	}
		
	draw_sprite(spr_cmp_icons, ind, st_marginx + inmargin, st_upgradetiery - mouse_scroll);
		
		
		
		
	//give a rating out of stars
	//set how much of the sprite to draw
	var percent = obj_stats.rating/tiermaster.max_rating;
	var percent_stars = star_num * percent;
	var whole_stars = floor(percent_stars);
	var rating_width = (whole_stars * st_starwidth) + (whole_stars * st_starmargin) + 
		((percent_stars - whole_stars) * st_starwidth) + (st_starmargin/2);
		
		
	draw_text(st_marginx, st_stary - 30 - mouse_scroll, "Rating: ");
	draw_sprite(spr_cmp_stars_empty, 0, st_starx, st_stary - mouse_scroll);
	draw_sprite_part(spr_cmp_stars_full, 0, 0, 0, rating_width, spr_stars_height, st_starx, st_stary - mouse_scroll);
		
	draw_set_color(c_white);
	draw_set_font(fnt_default);
	
}

#endregion



#region draw renovation website
reno_homepage_draw = function(mx, my) {
	
	// draw background
	draw_sprite_part(page_sprite, 0, 0, mouse_scroll, cm_window_width, cm_window_height, cm_window_x, cm_window_y)
	
	// draw icons
	//draw_sprite_part(spr_renoicons, 0, (0 * reno_icon_size), 0, reno_icon_size, reno_icon_size, reno_furnx, reno_furny - mouse_scroll);
	//draw_sprite_part(spr_renoicons, 0, (1 * reno_icon_size), 0, reno_icon_size, reno_icon_size, reno_reroomx, reno_reroomy - mouse_scroll);
	//draw_sprite_part(spr_renoicons, 0, (2 * reno_icon_size), 0, reno_icon_size, reno_icon_size, reno_roomextx, reno_roomexty - mouse_scroll);
		
	//if (reno_confirm_roomext) {
	//	var tx = rcre_x + 215;
	//	var ty = rcre_y + 72;
				
	//	draw_sprite(spr_reno_confirm_ext, 0, rcre_x, rcre_y);
	//	draw_set_color(c_black);
	//	draw_text(tx, ty, obj_catalogue.room_upgrade);
	//	draw_set_color(c_white);
				
	//}
		
}

reno_furniture_draw = function(mx, my) {
		// draw background
	draw_sprite_part(page_sprite, 0, 0, mouse_scroll, gui_width, screen_height, screen_x, screen_y + upper_taskbar);
}


reno_room_draw = function(mx, my) {
	
		// draw background
	draw_sprite_part(page_sprite, 0, 0, mouse_scroll, cm_window_width, cm_window_height, cm_window_x, cm_window_y);
	
	var buyx = 200 + cm_window_y;
	var buyy = 400 + cm_window_x;
	var buyw = sprite_get_width(spr_reno_reroomb);
	var buyh = sprite_get_height(spr_reno_reroomb);
	
	tier = obj_stats.tier;
	
	var xx = cm_window_x + 50;
	var yy = cm_window_y + 10;
	
		//draw renovation sprite
	if (ra_inc <= tier) draw_sprite(reno_reroom_view, ra_inc, xx, yy - mouse_scroll);
	else draw_sprite(spr_reno_reroomd, 4, xx, yy - mouse_scroll);
		
	var draw_butt = 0;
	var reno_array = 0;
	var text_alpha = 1;
	var c = c_white;
			
	if (reno_reroom_view == spr_reno_reroomd) {
		if (!reno_drawbuttond) draw_butt = 1;
		reno_array = obj_catalogue.reroomd_array;
	}
	else if (reno_reroom_view == spr_reno_reroomk) {
		if (!reno_drawbuttonk) draw_butt = 1;
		reno_array = obj_catalogue.reroomk_array;
	}
			
	if (draw_butt == 1) text_alpha = 0.6;
			
	draw_sprite(spr_reno_reroomb, draw_butt, buyx, buyy - mouse_scroll);
	draw_text_ext_color(buyx + 15, buyy + 5 - mouse_scroll, "Buy for " + string(reno_array[ra_inc]) + " piebucks",
		10, buyw, c, c, c, c, text_alpha);
}

#endregion

#region draw pill website

pills_homepage_draw = function(mx, my) {
		// draw background
	draw_sprite_part(page_sprite, 0, 0, mouse_scroll, cm_window_width, cm_window_height, cm_window_x, cm_window_y);
	
}

pills_buypage_draw = function(mx, my) {
	// don't draw default background; background changes depending on how many pills are available
	
		//upper limit of region
	//var mtor = (((mouse_y - page_marginy + mouse_scroll) div pl_region_height) * pl_region_height) + page_marginy - mouse_scroll;
		
	//draw_line(page_marginx, mtor, page_marginx + page_width, mtor);
	//draw_line(page_marginx, mtor + pl_py + pl_purchase_height, page_marginx + page_width, mtor + pl_py + pl_purchase_height);
		
	var ii = 0; repeat (pill_displaynum) {
		var region_uplimit = cm_window_y + (ii * pl_region_height) - mouse_scroll;
			
		draw_sprite_part(spr_pill_buypage, 0, 0, 0, page_width, pl_region_height, cm_window_x, region_uplimit)
		draw_sprite_part(spr_pill_buypage, 0, 0, pl_region_height, page_width, page_height - pl_region_height, cm_window_x,
			cm_window_y + (pill_displaynum * pl_region_height) - mouse_scroll);
			
		//draw_sprite_part(spr_clothing_pill, 0, xx * cell_size, yy * cell_size, cell_size, cell_size, 
		//	pl_iconx + cm_window_x, region_uplimit + pl_icony);
		
		draw_sprite(spr_pill_icons, ii, pl_iconx + cm_window_x, region_uplimit + pl_icony);
			
		var c = c_lime;
		draw_set_font(fnt_pl);
				
		var pds = obj_catalogue.ds_clothing_pill;
		var _name = pds[# 1, ii];
		if (ii >= ds_grid_height(pds)) pl_str = " ";
		else pl_str = _name;
				
		draw_text_ext_color(cm_window_x + pl_textx, region_uplimit + pl_texty, string(pl_str), 10, screen_width, c, c, c, c, 1);
		draw_set_font(fnt_default);
			
		ii += 1;
	}
}

#endregion
