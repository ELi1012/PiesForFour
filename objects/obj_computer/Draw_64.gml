

if (!using_computer) exit;


if (current_page != cm_background) {
	if (current_page != spr_pill_buypage) {
		draw_sprite_part(current_page, 0, 0, mouse_scroll, gui_width, screen_height, screen_x, screen_y + upper_taskbar);
		
	}
	//draw_sprite_part(current_page, 0, 0, mouse_scroll, gui_width, screen_height, screen_x, screen_y + upper_taskbar);
	
	if (current_website == website.company) {
	if (current_page == spr_cmp_statistics) {
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
			
			if (tier_req[t] > obj_stats.rating or tier_upgrade[t] > obj_stats.gold) can_upgrade = false;
			
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
		
	} else if (current_website == website.pills) {
		
		if (current_page == spr_pill_buypage) {
		
			//upper limit of region
			//var mtor = (((mouse_y - page_marginy + mouse_scroll) div pl_region_height) * pl_region_height) + page_marginy - mouse_scroll;
		
			//draw_line(page_marginx, mtor, page_marginx + page_width, mtor);
			//draw_line(page_marginx, mtor + pl_py + pl_purchase_height, page_marginx + page_width, mtor + pl_py + pl_purchase_height);
		
			var ii = 0; repeat (pill_displaynum) {
				var xx = ii mod pl_sprsheet_hblocks;
				var yy = ii div pl_sprsheet_hblocks;
				var region_uplimit = page_marginy + (ii * pl_region_height) - mouse_scroll;
			
				draw_sprite_part(spr_pill_buypage, 0, 0, 0, page_width, pl_region_height, page_marginx, region_uplimit)
				draw_sprite_part(spr_pill_buypage, 0, 0, pl_region_height, page_width, page_height - pl_region_height, page_marginx,
					page_marginy + (pill_displaynum * pl_region_height) - mouse_scroll);
			
				draw_sprite_part(spr_clothing_pill, 0, xx * cell_size, yy * cell_size, cell_size, cell_size, 
					pl_iconx + page_marginx, region_uplimit + pl_icony);
			
				var c = c_lime;
				draw_set_font(fnt_pl);
				
				var pl_str = pl_title_array[ii];
				if (ii >= array_length_1d(pl_title_array)) pl_str = " ";
				
				draw_text_ext_color(page_marginx + pl_textx, region_uplimit + pl_texty, string(pl_str), 10, screen_width, c, c, c, c, 1);
				draw_set_font(fnt_default);
			
				ii += 1;
			}
		} 
	} else if (current_website == website.clothes) {
	
		if (current_page == spr_clothespage) {
			var clothes_sprwidth = sprite_get_width(spr_draw_clothingtype) / cell_size;
			var startfrom = cloth_pageinc * page_icon_num;
			var display_these = clamp(cloth_displaynum - startfrom, 0, page_icon_num);
		
			var ii = startfrom; repeat (display_these) {
				//location on sprite sheet
				var xx = ii mod clothes_sprwidth;
				var yy = ii div clothes_sprwidth;
				//location on screen
				var px = ((ii - startfrom) mod page_rows) * (cell_size + x_buffer);
				var py = ((ii - startfrom) div page_rows) * (cell_size + y_buffer);
			
				draw_sprite_part(spr_draw_clothingtype, 0, xx * cloth_displaysize, yy * cloth_displaysize, cloth_displaysize,
					cloth_displaysize, clot_marginx + px, clot_marginy + py - mouse_scroll);
			
				ii += 1;
			}
		
			if (show_purchase) {
				var disx = cloth_spx + 20;
				var disy = cloth_spy + 24;
			
				var xx = selected_cloth mod clothes_sprwidth;
				var yy = selected_cloth div clothes_sprwidth;
			
			
				draw_set_alpha(0.3);
				draw_set_color(c_black);
				draw_rectangle(0, 0, gui_width, gui_height, false);
				draw_set_color(c_white);
				draw_set_alpha(1);
			
				draw_sprite(spr_clothes_confirm, 0, cloth_spx, cloth_spy);
			
				draw_sprite_part_ext(spr_draw_clothingtype, 0, xx * cloth_displaysize, yy * cloth_displaysize, cloth_displaysize,
					cloth_displaysize, disx, disy, 2, 2, c_white, 1);
			
			}
		}
		
	} else if (current_website == website.reno) {
		
		if (current_page == website_reno[0]) {
			draw_sprite_part(spr_renoicons, 0, (0 * reno_icon_size), 0, reno_icon_size, reno_icon_size, reno_furnx, reno_furny - mouse_scroll);
			draw_sprite_part(spr_renoicons, 0, (1 * reno_icon_size), 0, reno_icon_size, reno_icon_size, reno_reroomx, reno_reroomy - mouse_scroll);
			draw_sprite_part(spr_renoicons, 0, (2 * reno_icon_size), 0, reno_icon_size, reno_icon_size, reno_roomextx, reno_roomexty - mouse_scroll);
			if (obj_stats.current_room == rm_main_ext) draw_sprite(spr_greyed, 0, reno_roomextx, reno_roomexty - mouse_scroll);
		
			if (reno_confirm_roomext) {
				var tx = rcre_x + 215;
				var ty = rcre_y + 72;
				
				draw_sprite(spr_reno_confirm_ext, 0, rcre_x, rcre_y);
				draw_set_color(c_black);
				draw_text(tx, ty, obj_catalogue.room_upgrade);
				draw_set_color(c_white);
				
			}
		
		
		} else if (current_page == website_reno[2]) {
			tier = obj_stats.tier;
			//draw renovation sprite
			if (ra_inc <= tier) draw_sprite(reno_reroom_view, ra_inc, reno_selx, reno_sely - mouse_scroll);
			else draw_sprite(spr_reno_reroomd, 4, reno_selx, reno_sely - mouse_scroll);
		
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
			
			draw_sprite(spr_reno_reroomb, draw_butt, reno_buyx, reno_buyy - mouse_scroll);
			draw_text_ext_color(reno_buyx + 15, reno_buyy + 5 - mouse_scroll, "Buy for " + string(reno_array[ra_inc]) + " gold",
				10, reno_buywidth, c, c, c, c, text_alpha);
		
		}
	}
	
	draw_sprite(cm_upper_taskbar, 0, screen_x, screen_y);
	
} else { //computer background being drawn
	
	draw_sprite(cm_background, 0, screen_x, screen_y);

	draw_sprite(cm_folders, 0, cm_icon_cx, cm_icon_cy);
	draw_sprite(cm_folders, 1, cm_icon_rx, cm_icon_ry);
	draw_sprite(cm_folders, 2, cm_icon_px, cm_icon_py);
	draw_sprite(cm_folders, 3, cm_icon_sx, cm_icon_sy);
	
	
}



draw_sprite(cm_lower_taskbar, 0, cm_tb_x, cm_tb_y);

/*
if (instance_exists(obj_clickbox)) {
	with (obj_clickbox) draw_rectangle(bbox_right, bbox_top, bbox_left, bbox_bottom, true);
	with (obj_backbutton) draw_rectangle(bbox_right, bbox_top, bbox_left, bbox_bottom, true);
}
*/


draw_sprite(cm_outsidescreen, 0, 0, 0);

//draw cat
var clen;
if (cat_blink) clen = cat_len + cat_extra;
else clen = cat_len;

frame += frame_spd;
blink_timer += 1;

if (frame/room_speed >= clen) {
	frame = 0;
	if (cat_blink) cat_blink = false;
	else {
		if (blink_timer/room_speed >= 5) {
			blink_timer = 0;
			var c = choose(1, 2);
			if (c == 1) cat_blink = true;
		}
	}
}

draw_sprite(spr_luckycat, floor(frame/room_speed), catx, caty);


//draw daycycle
var c = daycycle.light_colour;
var dark = daycycle.darkness;

var ybottom = gui_height - screen_bottomy - taskbar + cm_tb_height - 1;

draw_set_alpha(dark);

//top rectangle
draw_rectangle_color(0, 0, gui_width, screen_y, c, c, c, c, false);
//right rectangle
draw_rectangle_color(0, screen_y + 1, screen_x, ybottom, c, c, c, c, false);
//left rectangle
draw_rectangle_color(screen_x + screen_width, screen_y + 1, gui_width, ybottom, c, c, c, c, false);
//bottom rectangle
draw_rectangle_color(0, ybottom + 1, gui_width, gui_height, c, c, c, c, false);


draw_set_alpha(1);


if (cm_new_notif) {
	cm_new_notif = false;
	cm_notif = true;
	//reset variables for notifications
	cm_notif_timer = 0;
}

if (cm_notif) {
	var notif_mx = 30;
	var notif_my = 30;
	
	cm_notif_timer += 1;
	
	var timer_current = cm_notif_timer/room_speed;
	var nd = 0.75; //fraction of max time to show notification at full opacity
	
	if (timer_current >= cm_notif_max * nd) {
		//fade out
		var sfo_max = cm_notif_max * 0.75;
		var text_alpha = (timer_current - sfo_max)/((1 - nd) * sfo_max);
		
		draw_set_alpha(1 - text_alpha);
	}
	
	if (cm_notif_timer/room_speed >= cm_notif_max) {
		cm_notif = false;
		cm_notif_timer = 0;
	}
	
	draw_text(notif_mx, notif_my, cm_notif_string);
	draw_set_alpha(1);
	
}








