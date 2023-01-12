/// @description show website subpages

desktop_page = function(mx, my) {
	
		// set clickboxes if just changed to page
	if (set_clickboxes) {
		set_clickbox(cm_icon_cx, cm_icon_cy, cm_iconsize, cm_iconsize, spr_clothespage, clothes_storefront);
		set_clickbox(cm_icon_rx, cm_icon_ry, cm_iconsize, cm_iconsize, spr_reno_homepage, reno_homepage);
		set_clickbox(cm_icon_px, cm_icon_py, cm_iconsize, cm_iconsize, spr_pill_homepage, pills_homepage);
		set_clickbox(cm_icon_sx, cm_icon_sy, cm_iconsize, cm_iconsize, spr_cmp_homepage, company_homepage);
		set_clickbox(cm_icon_ix, cm_icon_iy, cm_iconsize, cm_iconsize, spr_interior_page, interior_page);
		set_clickbox(cm_icon_ex, cm_icon_ey, cm_iconsize, cm_iconsize, spr_room_editor, room_editor);
			
		if (!ds_stack_empty(ds_prev_pages)) ds_stack_clear(ds_prev_pages);
		
		page_sprite = cm_background;
		draw_page_function = desktop_page_draw;
		set_clickboxes = false;
	}
	
	if (place_meeting(mx, my, obj_clickbox) and mouse_check_button_pressed(mb_left)) {
		var inst = instance_place(mx, my, obj_clickbox)
		
		if (inst.clicked_once == true and dbclick_timer/room_speed < dbclick_max) {
			dbclick_timer = 0;
			clicked_once = false;
			inst.clicked_once = false;
			
			//----------CLICKED ICON
			
			page_change(current_page, inst.page_redirect);
			
			page_redirect = inst.page_redirect;
			
		} else {
			
				inst.clicked_once = true;
				clicked_once = true;
				
		}
	}
	
	//increment timer if icon clicked once
	if (clicked_once) {
		dbclick_timer += 1;
		if (dbclick_timer/room_speed >= dbclick_max) {
			dbclick_timer = 0;
			with (obj_clickbox) clicked_once = false;
			clicked_once = false;
		}
	}
}


#region room editor
room_editor = function(mx, my) {
	if (set_clickboxes) {
		page_sprite = spr_room_editor;
		draw_page_function = room_editor_draw;
		set_clickboxes = false;
	}
	
	if (keyboard_check_pressed(ord("P"))) begin_room_edit();
}

#endregion


#region clothes

clothes_storefront = function(mx, my) {
	
	if (set_clickboxes) {
		clothing_display_page = spr_clothing_head;
		
		icon_head_tab = set_clickbox(head_tab.x1, head_tab.y1, 96, 16, ds_head);
		icon_body_tab = set_clickbox(body_tab.x1, body_tab.y1, 96, 16, ds_body);
		icon_r_arrow = set_clickbox(clot_pageinc_rx, clot_pageinc_y, clot_pageinc_width, clot_pageinc_height, 420);
		icon_l_arrow = set_clickbox(clot_pageinc_lx, clot_pageinc_y, clot_pageinc_width, clot_pageinc_height, -420);
		
		page_sprite = spr_clothespage;
		draw_page_function = clothes_storefront_draw;
		set_clickboxes = false;
		//show_debug_message("page clothes");
	}
	
	
	//clicked icon
	if (place_meeting(mx, my, obj_clickbox) and mouse_check_button_pressed(mb_left)) {
		var inst = instance_place(mx, my, obj_clickbox);
		
		switch (inst) {
			case icon_r_arrow:
				cloth_pageinc += 1;		// increment page index
				if (cloth_pageinc >= cloth_displaynum div page_icon_num) cloth_pageinc = 0;
				break;
				
			case icon_l_arrow:
				cloth_pageinc -= 1;		// increment page index
				if (cloth_pageinc < 0) cloth_pageinc = cloth_displaynum div page_icon_num;
				break;
			
			case icon_head_tab:
				ds_selected = ds_head;
				display_array = obj_catalogue.head_length;			// how many clothing to show depending on tier
				wardrobe_ds = obj_wardrobe.ds_owned_head;
				show_purchase = false;
				break;
				
			case icon_body_tab:
				ds_selected = ds_body;
				display_array = obj_catalogue.body_length;;
				wardrobe_ds = obj_wardrobe.ds_owned_body;
				show_purchase = false;
				break;
				
		}
	}
		
	
	tier = obj_stats.tier;
	cloth_displaynum = 0;
	var ii = 0; repeat (tier) {
		cloth_displaynum += display_array[ii];
		ii += 1;
	}
	cloth_displaynum = clamp(cloth_displaynum, 0, ds_grid_height(ds_selected));
	
	#region mouse slot
	
	var i_mousex = mx - clot_marginx; //position of mouse relative to page sprite
	var i_mousey = my - clot_marginy + mouse_scroll;
	
	if (point_in_rectangle(i_mousex, i_mousey, 0, 0, clot_page_width, clot_page_height)) {
		
		var cell_xbuff = (cell_size + x_buffer);
		var cell_ybuff = (cell_size + y_buffer);
		
		var nx = i_mousex div cell_xbuff; //shows which slot the mouse is in
		var ny = i_mousey div cell_ybuff;

		if (nx >= 0 and nx < page_rows and ny >= 0 and ny < page_columns) { //mouse is within bounds of UI
			//show_debug_message("within bounds")
			var sx = i_mousex - (nx * cell_xbuff);
			var sy = i_mousey - (ny * cell_ybuff);
	
			if ((sx < cell_size) and (sy < (cell_size + desc_size)) and !show_purchase) { //mouse is not in buffer zone//
				m_slot_x = nx;
				m_slot_y = ny;
				
				var y_spotcomparison = (m_slot_x + (m_slot_y * page_rows))
				var y_spot = y_spotcomparison + (cloth_pageinc * page_icon_num); //location on ds grid
				var y_spotmax = cloth_displaynum - (cloth_pageinc * page_icon_num);
				//yspotmax should never be negative or 0 otherwise page is displaying empty cells - check page incrementer
				
				//show_debug_message("y spot max " + string(cloth_displaynum) + " - " + string(cloth_pageinc) + " * " + string(page_icon_num));
				//show_debug_message("is " + string(y_spotmax));
				//show_debug_message("yspot " + string(y_spot));
				//show_debug_message(" ");
				
				if (mouse_check_button_pressed(mb_left) and y_spotcomparison < y_spotmax) {
					show_purchase = true;
					selected_cloth_index = y_spot;
				}
			}
		}
	} //check if mouse is within grid
	
	//show purchase only set to true if mouse is within bounds of above code
	if (show_purchase and mouse_check_button_pressed(mb_left)) {
					
		if (mouse_over_button(clothes_purchase_button, mx, my)) { //pb clicked
			  ////////////////////////////////
			 ///PASS VARIABLES TO WARDROBE///
			////////////////////////////////
			#region passing variables
					
			//find y coordinate of ds grid that matches selected slot
						
			//WARDROBE ARGS								//CATALOGUE ARGS
			//arg 0: sprite								//arg 0: sprite
			//arg 1: name								//arg 1: name
			//arg 2: description						//arg 2: description
														//arg 3: cost
														//arg 4: already bought or false
					
			var cds = ds_selected;		// ds grid in catalogue
			var ind = selected_cloth_index;
			
			var clothing_cost = cds[# 3, ind];
			var already_bought = cds[# 4, ind];
				
			if (!already_bought and obj_stats.piebucks >= clothing_cost) {
					// can purchase
				var wd = wardrobe_ds;
				var wheight = ds_grid_height(wd);
					
				if (wd[# 0, 0] != -1) {
					ds_grid_resize(wd, ds_grid_width(wd), wheight + 1);
					wheight += 1;
					show_debug_message("resized grid");
				}
				
				var yy = wheight - 1;
				var _spr = cds[# 0, ind];
				var _name = cds[# 1, ind];
				var _desc = cds[# 2, ind];
						
				wd[# 0, yy] = _spr;
				wd[# 1, yy] = _name;
				wd[# 2, yy] = _desc;
				
				obj_stats.piebucks -= clothing_cost;
				cds[# 4, ind] = true;
				show_debug_message(" ");
					
				show_debug_message("name " + string(wd[# 1, yy]));
				show_debug_message("current piebucks " + string(obj_stats.piebucks));
						
				show_debug_message(" ");
				show_purchase = false;
					
			} else if (already_bought) {
				cm_new_notif = true;
				cm_notif_string = "Already purchased this item";
			} else if (obj_stats.piebucks < clothing_cost) {
				cm_new_notif = true;
				cm_notif_string = "Not enough piebucks";
				
			}
			
			#endregion
			
		} else if (mouse_over_button(clothes_exit_button, mx, my) or !mouse_over_button(show_purchase_screen, mx, my)) {
				//continue shopping
			show_purchase = false;
		}
	}

	#endregion
	
}

#endregion

#region interior furniture and wallpaper page

interior_page = function(mx, my) {
	
	var t = interior_tabs;
	var tt = obj_stats.tier;
	
	if (set_clickboxes) {
			// struct already accounts for cm_window_x etc.
		var cx = cm_window_x;	var cy = cm_window_y;
		var tx = t.table_x;		var ox = t.oven_x;
		var yy = t.table_y;		// same as fy
		var fw = 42;					var ow = 42;
		var h = 16;						// same
		
		set_clickbox(tx, yy, fw, h, t.table, interior_page);
		set_clickbox(ox, yy, ow, h, t.oven, interior_page);
		set_clickbox(50 + cx, 192 + cy, 34, 24, t.arrow_left, interior_page);
		set_clickbox(116 + cx, 192 + cy, 34, 24, t.arrow_right, interior_page);
		set_clickbox(t.buy_furniture_x, t.buy_button_y, 64, 24, t.buy_button, spr_piemachine);
		set_clickbox(t.buy_ext_x, t.buy_button_y, 64, 24, t.buy_button, spr_piemachine_ext);
		
		page_sprite = spr_interior_page;
		page_height = sprite_get_height(spr_interior_page);
		draw_page_function = interior_page_draw;
		set_clickboxes = false;
	}
	
		// pick tab
	if (mouse_check_button_pressed(mb_left) and place_meeting(mx, my, obj_clickbox)) {
		var inst = instance_place(mx, my, obj_clickbox);
		var o = inst.optional_variable;
			// switch to new tab if new tab != current tab
		if (o == t.table or o == t.oven) {
			if (o != current_tab) current_tab = o;
		}
		
			// increment index
			// index starts at one because player cannot buy tier 1 items already owned
		else if (o == t.arrow_left) {
			int_index--;
			if (int_index < 1) int_index = tt - 1;
		} else if (o == t.arrow_right) {
			int_index++;
			if (int_index > tt - 1) int_index = 1;
		} else if (o == t.buy_button) {
			
			if (current_tab == t.table) {
				var piebucks_needed = obj_catalogue.table_upgrade[int_index - 1];
				var types = furniture_handler.furniture_data.table_types_purchased;
				var table_type = int_index;
				var can_buy = false;
				
				if (obj_stats.piebucks <= piebucks_needed) {
					cm_new_notif = true;
					cm_notif_string = "Not enough piebucks";
				} else if (types[table_type] >= furniture_handler.table_num) {
					cm_new_notif = true;
					cm_notif_string = "Maximum number of tables of this type already purchased";
				} else {
					can_buy = true;
				}
					
					
				if (can_buy) {
					obj_stats.piebucks -= piebucks_needed;
					furniture_handler.furniture_data.table_types_purchased[table_type] += 1;		// one more table of the type purchased
					
					cm_new_notif = true;
					cm_notif_string = "New table purchased";
					//show_debug_message("table of type "+string(table_type)+" bought, now have: "+string(types[table_type]));
					
				}
			}
			
			else if (current_tab == t.oven) {
				
					// buy new oven
				if (inst.page_redirect == spr_piemachine) {
					var piebucks_needed = obj_catalogue.oven_upgrade[int_index - 1];
					var types = furniture_handler.furniture_data.oven_types_purchased;
					var oven_type = int_index;
					var can_buy = false;
				
					if (obj_stats.piebucks <= piebucks_needed) {
						cm_new_notif = true;
						cm_notif_string = "Not enough piebucks";
					} else if (types[oven_type] >= furniture_handler.oven_num) {
						cm_new_notif = true;
						cm_notif_string = "Maximum number of ovens of this type already purchased";
					} else {
						can_buy = true;
					}
					
					
					
					if (can_buy) {
						obj_stats.piebucks -= piebucks_needed;
						furniture_handler.furniture_data.oven_types_purchased[oven_type] += 1;
					
						cm_new_notif = true;
						cm_notif_string = "New oven purchased";
					}
				
				} else if (inst.page_redirect == spr_piemachine_ext) {
						// buy extension
					var piebucks_needed = obj_catalogue.oven_extension;
					var can_buy = false;
					var num_extended = 0;
					var aa = furniture_handler.furniture_data.ovens_extended;	// array containing how many extended
					
					for (var i = 0; i < array_length(aa); i++) {
						if (aa[i] == true) num_extended += 1;
					}
					
					num_extended += furniture_handler.furniture_data.ovens_to_extend;		// how many extensions purchased but not used
					if (obj_stats.piebucks < piebucks_needed) {
						cm_new_notif = true;
						cm_notif_string = "Not enough piebucks";
					}
					else if (num_extended >= furniture_handler.oven_num) {
						cm_new_notif = true;
						cm_notif_string = "Maximum amount of extensions purchased";
						
					} else {
						can_buy = true;
					}
					
					if (can_buy) {
						obj_stats.piebucks -= piebucks_needed;
						furniture_handler.furniture_data.ovens_to_extend += 1;
						
						cm_new_notif = true;
						cm_notif_string = "Extension purchased";
					}
				}
			}
		}
	}
	
	
}


#endregion


#region subpage for company website
company_homepage = function(mx, my) {
	
	if (set_clickboxes) {
		st_viewst = set_clickbox(st_viewst_x, st_viewst_y, st_viewst_width, st_viewst_height, spr_cmp_statistics, company_statistics);
		
		page_sprite = spr_cmp_homepage;
		draw_page_function = company_homepage_draw;
		set_clickboxes = false;
	}
	
	
	if (place_meeting(mx, my, obj_clickbox) and mouse_check_button_pressed(mb_left)) {
		var inst = instance_place(mx, my, obj_clickbox);
		
		if (inst.page_redirect == company_statistics) {
			page_change(current_page, company_statistics);
		}
	}
}

company_statistics = function(mx, my) {
	
	if (set_clickboxes) {
		var inmargin = 15;
		st_upgrade = set_clickbox(st_marginx + inmargin, st_upgradetiery, st_upwidth, st_upheight, "upgrade");
		
		page_sprite = spr_cmp_statistics;
		draw_page_function = company_statistics_draw;
		set_clickboxes = false;
	}
	
	if (place_meeting(mx, my, obj_clickbox) and mouse_check_button_pressed(mb_left)) {
		var inst = instance_place(mx, my, obj_clickbox);
			
		if (inst == st_upgrade) {
			var t = obj_stats.tier;
			var can_upgrade = true;
				
			if (tier_req[t] > obj_stats.rating or tier_upgrade[t] > obj_stats.piebucks or t >= tiermaster.max_tier) can_upgrade = false;
				
			if (can_upgrade) tiermaster.increase_tier = true;
		}
	}
}

#endregion


#region subpage for renovations
reno_homepage = function(mx, my) {
	
	if (set_clickboxes) {
		var f_width = 218;
		var f_height = 16;
		var rr_width = 194;
		
		reno_furn = set_clickbox(reno_furnx, reno_furny, f_width, f_height, website_reno[1], reno_furniture);
		reno_reroom = set_clickbox(reno_reroomx, reno_reroomy, rr_width, f_height, website_reno[2], reno_room);
		reno_roomext = set_clickbox(reno_roomextx, reno_roomexty, reno_icon_size, reno_icon_size, website_reno[0]);
		
		page_sprite = spr_reno_homepage;
		draw_page_function = reno_homepage_draw;
		set_clickboxes = false;
	}
	
	if (place_meeting(mx, my, obj_clickbox) and mouse_check_button_pressed(mb_left)) {
		var inst = instance_place(mx, my, obj_clickbox);
			
		if (inst == reno_furn or inst == reno_reroom) {
			page_change(current_page, inst.page_redirect);
			
		} else if (inst == reno_roomext and !obj_stats.room_extended) reno_confirm_roomext = true;
	}
		
		
	if (reno_confirm_roomext and mouse_check_button_pressed(mb_left)) {
		if (point_in_rectangle(mx, my, rcre_yesx, rcre_yesy, rcre_yesx + rcre_yn_width, rcre_yesy + rcre_yn_height)) {
			if (obj_stats.piebucks >= obj_catalogue.room_upgrade) {
				////////////////////////////////
				//----------CHANGE MAIN ROOM
				////////////////////////////////
				extend_room();
				reno_confirm_roomext = false;
					
			} else {
				//not enough piebucks
				cm_new_notif = true;
				cm_notif_string = "not enough piebucks";
					
			}
		} else if (point_in_rectangle(mx, my, rcre_nox, rcre_noy, rcre_nox + rcre_yn_width, rcre_noy + rcre_yn_height)) {
			reno_confirm_roomext = false;
		}
	}
}

reno_furniture = function(mx, my) {
	
	if (set_clickboxes) {
		set_clickbox(reno_bx, reno_by, reno_bwidth, reno_bheight, "furn");
		
		page_sprite = spr_reno_furniture;
		draw_page_function = reno_furniture_draw;
		set_clickboxes = false;
	}
	
	if (place_meeting(mx, my, obj_clickbox) and mouse_check_button_pressed(mb_left)) {
		var inst = instance_place(mx, my, obj_clickbox);
			
		if (inst.redirect == "furn") {
			with (obj_catalogue) {
				editing_room = true;
				comp_scroll = other.mouse_scroll;
				cur_page = other.current_page;
				px = obj_player.x;
				py = obj_player.y;
					
			}
				
			daycycle.visible = false;
			global.using_escape = true;
		
			camera.x = 0;
			camera.y = 0;
			
			var rm = rm_main;
			if (obj_stats.room_extended) rm = rm_main_ext;
			
			room_goto(rm);
		}
	}
}

reno_room = function(mx, my) {
	
	if (set_clickboxes) {
		var r_left_x = 16 + cm_window_x;
		var r_right_x = 384 + cm_window_x;
		var arrow_y = 320 + cm_window_y;
		var arrow_width = 16;
		var arrow_height = 64;
		
		var dx = 64 + cm_window_x;
		var dy = 512 + cm_window_y;
		var dw = 96;
		var dh = 64;
		
		var kx = 256 + cm_window_x;
		var ky = 512 + cm_window_y;
		var kw = 96;
		var kh = 64;
	
		var buyx = 200 + cm_window_x;
		var buyy = 400 + cm_window_y;
		var buyw = sprite_get_width(spr_reno_reroomb);
		var buyh = sprite_get_height(spr_reno_reroomb);
		
		var r = reno_buttons;
		
		
		set_clickbox(r_left_x, arrow_y, arrow_width, arrow_height, r.right_arrow);
		set_clickbox(r_right_x, arrow_y, arrow_width, arrow_height, r.left_arrow);
					
		set_clickbox(dx, dy, dw, dh, r.dining_button);		
		set_clickbox(kx, ky, kw, kh, r.kitchen_button);
		set_clickbox(buyx, buyy, buyw, buyh, r.buy_button);
		
		page_sprite = spr_reno_reroom;
		draw_page_function = reno_room_draw;
		set_clickboxes = false;
	}
	
	
	
		//change view according to arrows
	if (place_meeting(mx, my, obj_clickbox) and mouse_check_button_pressed(mb_left)) {
		var r = reno_buttons;
		var inst = instance_place(mx, my, obj_clickbox);
		switch (inst.optional_variable) {
			case r.right_arrow:
				ra_inc += 1;
				if (ra_inc > ra_max) ra_inc = 0;
				//show_debug_message("ra inc " + string(ra_inc));
				break;
						
			case r.left_arrow:
				ra_inc -= 1;
				if (ra_inc < 0) ra_inc = ra_max;
				//show_debug_message("ra inc " + string(ra_inc));
				break;
					
			case r.dining_button:
				reno_reroom_view = spr_reno_reroomd;
				ra_inc = 0;
				break;
						
			case r.kitchen_button:
				reno_reroom_view = spr_reno_reroomk;
				ra_inc = 0;
				break;
				
			case r.buy_button:
					
				if (reno_reroom_view == spr_reno_reroomd and ra_inc <= tier) {
						
					if (current_dining == ra_inc) {
						cm_new_notif = true;
						if (dbought_room_upgrade) cm_notif_string = "already bought upgrade";
						else cm_notif_string = "already equipped";
						break;
					} else if (dbought_room_upgrade) {
						cm_new_notif = true;
						cm_notif_string = "already bought upgrade today";
						break;
					}
						
					with (obj_stats) {
						var cost = obj_catalogue.reroomd_array[other.ra_inc];
							
						piebucks -= cost;
						dining_bg = other.ra_inc;
							
						other.cm_new_notif = true;
						other.cm_notif_string = "bought upgrade for " + string(cost) + " piebucks";
						//show_debug_message("cost " + string(obj_catalogue.reroomd_array[other.ra_inc]));
					}
					dbought_room_upgrade = true;
						
				} else if (reno_reroom_view == spr_reno_reroomk and ra_inc <= tier) {
						
					if (current_kitchen == ra_inc) {
						cm_new_notif = true;
						if (kbought_room_upgrade) cm_notif_string = "already bought upgrade";
						else cm_notif_string = "already equipped";
						break;
					} else if (kbought_room_upgrade) {
						cm_new_notif = true;
						cm_notif_string = "already bought upgrade today";
						break;
					}
						
					with (obj_stats) {
						var cost = obj_catalogue.reroomk_array[other.ra_inc];
							
						piebucks -= cost;
						kitchen_bg = other.ra_inc;
							
						other.cm_new_notif = true;
						other.cm_notif_string = "bought upgrade for " + string(cost) + " piebucks";
						//show_debug_message("cost " + string(obj_catalogue.reroomk_array[other.ra_inc]));
					}
					kbought_room_upgrade = true;
				}
					
				break;
						
		}
	} //change view according to arrows
		
	reno_drawbuttond = true;
	reno_drawbuttonk = true;
		
	if (dbought_room_upgrade or ra_inc == current_dining or ra_inc > tier) reno_drawbuttond = false;
	if (kbought_room_upgrade or ra_inc == current_kitchen or ra_inc > tier) reno_drawbuttonk = false;
}

#endregion


#region subpage for pills
	
pills_homepage = function(mx, my) {
	if (set_clickboxes) {
		pl_clickicon = set_clickbox(pl_clickiconx, pl_clickicony, pl_clickicon_width, pl_clickicon_height, spr_pill_buypage);
		
		page_sprite = spr_pill_homepage;
		page_height = sprite_get_height(page_sprite);
		draw_page_function = pills_homepage_draw;
		set_clickboxes = false;
	}
	
	if (instance_place(mx, my, pl_clickicon) and mouse_check_button_pressed(mb_left)) {
		//set current page to buying page
		page_change(current_page, pills_buypage);
	}
}

pills_buypage = function(mx, my) {
	
	if (set_clickboxes) {
		page_sprite = spr_pill_buypage;
		page_height = (pl_region_height * pill_displaynum) + (sprite_get_height(spr_pill_buypage) - pl_region_height); //plus any other margins
		draw_page_function = pills_buypage_draw;
		set_clickboxes = false;
	}
	
	//------BUYING PILLS
		
	if (mouse_check_button_pressed(mb_left)) {
		//upper bound of region
		var pl_linenum = (my - cm_window_y + mouse_scroll) div pl_region_height; // which region mouse is in; starts from 0
		var mtor = (pl_linenum * pl_region_height) + cm_window_y - mouse_scroll;
		var pill_index = pl_linenum;		// location of pill on ds grid
			
		if (point_in_rectangle(mx, my, pl_purchasex, pl_py + mtor, pl_purchasex + pl_purchase_width, 
			mtor + pl_py + pl_purchase_height) and pl_linenum < pill_displaynum) {
				
				// clicked purchase button
				
			var pds = obj_catalogue.ds_clothing_pill;
			var _cost = pds[# 3, pill_index];
				
			if (obj_stats.piebucks >= _cost) {
					
				////////////////////////////////
				///PASS VARIABLES TO WARDROBE///
			////////////////////////////////
			#region passing variables
					
			//find y coordinate of ds grid that matches selected slot
						
			//WARDROBE ARGS								//CATALOGUE ARGS
			//arg 0: sprite								//arg 0: sprite
			//arg 1: name								//arg 1: name
			//arg 2: description						//arg 2: description
														//arg 3: cost
														//arg 4: already bought or false
					
				
			var wd = obj_wardrobe.ds_owned_pill;
			var wheight = ds_grid_height(wd);
			var wd_pill_info = obj_wardrobe.ds_pill_info;
			var _spr = pds[# 0, pill_index];
			var yy = wheight - 1;		// which index for wardrobe ds
			var already_exists = false;
			
				// loop through to check if pill already exists in wardrobe
				// change index if true
			for (var i = 0; i < wheight; i++) {
				if (wd[# 0, i] == _spr) {
					yy = i;
					already_exists = true;
					break;
				}
			}
			
				// resize ds grid if not empty and pill does not already exist in wardrobe
				// store data about the pill (position on catalogue ds grid, number)
			if (!already_exists) {
				
				if (wd[# 0, 0] != -1) {
					ds_grid_resize(wd, ds_grid_width(wd), wheight + 1);
					ds_grid_resize(wd_pill_info, 2, ds_grid_height(wd_pill_info) + 1);
				
					wheight += 1;
					yy = wheight - 1;
				
				}
								
					// store data about new pill
				wd_pill_info[# 0, yy] = pill_index;
				wd_pill_info[# 1, yy] = 0;
			}
				
			
			wd[# 0, yy] = pds[# 0, pill_index];
			wd[# 1, yy] = pds[# 1, pill_index];
			wd[# 2, yy] = pds[# 2, pill_index];
			
			wd_pill_info[# 1, yy] += 1;
				
			obj_stats.piebucks -= _cost
				
			//show_debug_message(" ");
					
			//show_debug_message("cloth id " + string(wd[# 0, yy]));
			//show_debug_message("clothing type enum " + string(wd[# 1, yy]));
			//show_debug_message("name " + string(wd[# 1, yy]));
				
			//show_debug_message(" ");
				
			cm_new_notif = true;
			cm_notif_string = "Pill purchased";
				
			show_purchase = false;
				
				
			#endregion
				
			} else {
				cm_new_notif = true;
				cm_notif_string = "Not enough piebucks";
					
			}
		}
	}
		
		
	tier = obj_stats.tier;
	pill_displaynum = 0;
	var ii = 0; repeat (tier) {
		pill_displaynum += pill_display_array[ii];
		ii += 1;
	}
	pill_displaynum = clamp(pill_displaynum, 0, pill_ds_height);
}
	
#endregion