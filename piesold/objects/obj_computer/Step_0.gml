if (place_meeting(x, y + 10, obj_player) and keyboard_check_pressed(vk_space) and !using_computer) {
	
	using_computer = true;
	global.no_moving = true;
	global.using_escape = true;
	tier = obj_stats.tier;
	visible = true;
	
	#region computer defaults
	//computer defaults
	clicked_once = false;
	dbclick_timer = 0;
	dbclick_max = 1/4;
	
	cm_icon_c = set_clickbox(cm_icon_cx, cm_icon_cy, cm_iconsize, cm_iconsize, spr_clothespage);
	cm_icon_r = set_clickbox(cm_icon_rx, cm_icon_ry, cm_iconsize, cm_iconsize, spr_reno_homepage);
	cm_icon_p = set_clickbox(cm_icon_px, cm_icon_py, cm_iconsize, cm_iconsize, spr_pill_homepage);
	cm_icon_s = set_clickbox(cm_icon_sx, cm_icon_sy, cm_iconsize, cm_iconsize, spr_cmp_homepage);
	cm_ie = set_clickbox(cm_ie_x, cm_ie_y, cm_ie_width, cm_ie_height, spr_clothespage);
	
	current_website = website.pills;
	current_page = cm_background;
	
	//pill defaults
	pill_displaynum = 0;
	var ii = 0; repeat (tier) {
		pill_displaynum += pill_display_array[ii];
		ii += 1;
	}
	pill_displaynum = clamp(pill_displaynum, 0, pill_ds_height);
	
	//clothing defaults
	show_purchase = false;
	spr_draw_clothingtype = spr_clothing_head;
	cloth_page_ds = cloth_ds_head;
	cloth_ds_height = ds_grid_height(cloth_page_ds);
	clothing_display_array = head_array; //how many icons to display from sprite sheet
	clothing_selection_array = selection_array_head;
	clothing_description_array = description_array_head;
	wardrobe_ds = obj_wardrobe.ds_owned_head;
	
	m_slot_x = -1;
	m_slot_y = -1;
	
	//draw these
	cloth_displaysize = 64;
	cloth_displaynum = 0;
	cloth_pageinc = 0;
	
	var ii = 0; repeat (tier) {
		cloth_displaynum += clothing_display_array[ii];
		ii += 1;
	}
	cloth_displaynum = clamp(cloth_displaynum, 0, cloth_ds_height);
	selected_cloth = 0;
	
	//reno defaults
	reno_reroom_view = spr_reno_reroomd;
	ra_inc = 0;
	ra_max = tiermaster.max_tier - 1;
	
	current_dining = obj_stats.dining_bg;
	current_kitchen = obj_stats.kitchen_bg;
	
	#endregion computer defaults
	
	
			
	if (instance_exists(obj_backbutton)) with (obj_backbutton) instance_destroy();
	if (!ds_stack_empty(ds_backpages)) ds_stack_clear(ds_backpages);
	
}

if (!using_computer) exit;

//ALWAYS RESET MOUSE SCROLL TO 0 IF CHANGING PAGES

mask_index = spr_smallmask;

//change to if user clicks sign out button
if (keyboard_check_pressed(vk_escape)) {
	using_computer = false;
	global.no_moving = false;
	global.using_escape = false;
	mask_index = spr_computer;
	visible = false;
	
	mouse_scroll = 0;
	current_page = cm_background;
	
	//SAVE DATA
	//save ds grids in savedata
	with (obj_wardrobe) {
		ds_map_replace(saver.save_data, "owned hats", ds_grid_write(ds_owned_head));
		ds_map_replace(saver.save_data, "owned clothes", ds_grid_write(ds_owned_body));
		ds_map_replace(saver.save_data, "owned pills", ds_grid_write(ds_owned_pill));
	}
	
	
	
	
	
	with (obj_stats) event_perform(ev_alarm, 0);
	
	if (instance_exists(obj_clickbox)) with (obj_clickbox) instance_destroy();
	if (instance_exists(obj_backbutton)) with (obj_backbutton) instance_destroy();
	exit;
}







//update page marginy and screen height if changing to cm background

if (point_in_rectangle(mouse_x, mouse_y, screen_x, screen_y, screen_x + screen_width, screen_y + screen_height + taskbar)) {


//IF CHANGING PAGES ALWAYS USE PAGE CHANGE AND PAGE DESTINATION OR ELSE CLICKBOXES WONT SPAWN




if (current_page == cm_background) {
	var doexit = true;
	
	if (place_meeting(mouse_x, mouse_y, obj_clickbox) and mouse_check_button_pressed(mb_left)) {
		inst = instance_place(mouse_x, mouse_y, obj_clickbox)
		
		if (inst.clicked_once = true and dbclick_timer/room_speed < dbclick_max) {
			dbclick_timer = 0;
			clicked_once = false;
			inst.clicked_once = false;
			
			//----------CLICKED ICON
			
			page_change = true;
			page_destination = inst.redirect;
			doexit = false;
			
			
		} else {
			
			if (inst != cm_ie) {
				inst.clicked_once = true;
				clicked_once = true;
				
			} else {
				page_change = true;
				page_destination = spr_clothespage;
				
				doexit = false;
				
			}
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
	
	if (doexit) exit;
	
}

#region save game
/*
else if (current_page == spr_savegame_confirm) {
	var go_back = false;
	
	if (mouse_check_button_pressed(mb_left)) {
		if (instance_place(mouse_x, mouse_y, cm_icon_s)) go_back = true;
	}
	
	if (keyboard_check_pressed(vk_escape)) go_back = true;
	
	if (keyboard_check_pressed(vk_enter)) {
		//save game
		show_debug_message("game saved");
		go_back = true;
		
		//with (saver) event_perform(ev_alarm, 0);
		
	}
	
	if (go_back) {
		page_change = true;
		page_destination = cm_background;
	}
}
*/

#endregion save game

//run this if page changes
page_height = sprite_get_height(current_page);
if (current_page == spr_pill_buypage) page_height = (pl_region_height * pill_displaynum) + (page_height - pl_region_height); //plus any other margins

//scrolling mouse
if (page_height > gui_height) {
	if (mouse_wheel_up()) mouse_scroll -= scroll_speed;
	if (mouse_wheel_down()) mouse_scroll += scroll_speed;
	mouse_scroll = clamp(mouse_scroll, 0, page_height - screen_height);
} else mouse_scroll = 0;



if (current_website = website.company) {
	
	if (current_page = spr_cmp_homepage) {
		if (place_meeting(mouse_x, mouse_y, obj_clickbox) and mouse_check_button_pressed(mb_left)) {
			var inst = instance_place(mouse_x, mouse_y, obj_clickbox);
			
			if (inst == st_viewst) {
				page_change = true;
				page_destination = inst.redirect;
			}
		}
	} else if (current_page == spr_cmp_statistics) {
		if (place_meeting(mouse_x, mouse_y, obj_clickbox) and mouse_check_button_pressed(mb_left)) {
			var inst = instance_place(mouse_x, mouse_y, obj_clickbox);
			
			if (inst == st_upgrade) {
				var t = obj_stats.tier;
				var can_upgrade = true;
				
				if (tier_req[t] > obj_stats.rating or tier_upgrade[t] > obj_stats.gold or t >= tiermaster.max_tier) can_upgrade = false;
				
				if (can_upgrade) tiermaster.increase_tier = true;
			}
		}
	}
	
} else if (current_website = website.reno) { //CHANGE TARGET COORDINATES IF GETTING ROOM UPGRADE
	#region renovations
	
	//HOME PAGE
	if (current_page == website_reno[0]) {
		
		if (place_meeting(mouse_x, mouse_y, obj_clickbox) and mouse_check_button_pressed(mb_left)) {
			var inst = instance_place(mouse_x, mouse_y, obj_clickbox);
			
			if (inst == reno_furn or inst == reno_reroom) {
				page_change = true;
				page_destination = inst.redirect;
			} else if (inst == reno_roomext and obj_stats.current_room != rm_main_ext) reno_confirm_roomext = true;
		}
		
		
		if (reno_confirm_roomext and mouse_check_button_pressed(mb_left)) {
			if (point_in_rectangle(mouse_x, mouse_y, rcre_yesx, rcre_yesy, rcre_yesx + rcre_yn_width, rcre_yesy + rcre_yn_height)) {
				if (obj_stats.gold >= obj_catalogue.room_upgrade) {
					////////////////////////////////
					//----------CHANGE MAIN ROOM
					////////////////////////////////
					with (obj_stats) {
						current_room = rm_main_ext;
						target_x = ext_target_x;
						target_y = ext_target_y;
						gold -= obj_catalogue.room_upgrade;
					}
					
					with (obj_tilesetter) {
						kitchen_x = 1024;
						floor_y = 256;
						
						diningroom_wall = spr_bg_wall_ext;
						kitchen_wall = spr_k_wall_ext;
						
						diningroom_floor = spr_bg_floor_ext;
						kitchen_floor = spr_k_wall_ext;
					}
					
					tiermaster.room_extendus = true;
					
					show_debug_message("room extended");
					reno_confirm_roomext = false;
					
				} else {
					//not enough gold
					cm_new_notif = true;
					cm_notif_string = "not enough gold";
					
				}
			} else if (point_in_rectangle(mouse_x, mouse_y, rcre_nox, rcre_noy, rcre_nox + rcre_yn_width, rcre_noy + rcre_yn_height)) {
				reno_confirm_roomext = false;
			}
		}
	}
	
	if (current_page == website_reno[1]) {
		
		if (place_meeting(mouse_x, mouse_y, obj_clickbox) and mouse_check_button_pressed(mb_left)) {
			var inst = instance_place(mouse_x, mouse_y, obj_clickbox);
			
			if (inst.redirect == "furn") {
				with (obj_catalogue) {
					renovating = true;
					comp_scroll = other.mouse_scroll;
					cur_page = other.current_page;
					px = obj_player.x;
					py = obj_player.y;
					
				}
				
				daycycle.visible = false;
				global.using_escape = true;
		
				camera.x = 0;
				camera.y = 0;
				
				room_goto(obj_stats.current_room);
			}
		}
		
	} else if (current_page == website_reno[2]) {
		
		//change view according to arrows
		if (place_meeting(mouse_x, mouse_y, obj_clickbox) and mouse_check_button_pressed(mb_left)) {
			var inst = instance_place(mouse_x, mouse_y, obj_clickbox);
			switch (inst.redirect) {
				case reno_arrowrx:
					ra_inc += 1;
					if (ra_inc > ra_max) ra_inc = 0;
					//show_debug_message("ra inc " + string(ra_inc));
					break;
						
				case reno_arrowlx:
					ra_inc -= 1;
					if (ra_inc < 0) ra_inc = ra_max;
					//show_debug_message("ra inc " + string(ra_inc));
					break;
					
				case reno_dx:
					reno_reroom_view = spr_reno_reroomd;
					ra_inc = 0;
					break;
						
				case reno_kx:
					reno_reroom_view = spr_reno_reroomk;
					ra_inc = 0;
					break;
				
				case reno_buyx:
					
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
							
							gold -= cost;
							dining_bg = other.ra_inc;
							
							other.cm_new_notif = true;
							other.cm_notif_string = "bought upgrade for " + string(cost) + " gold";
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
							
							gold -= cost;
							kitchen_bg = other.ra_inc;
							
							other.cm_new_notif = true;
							other.cm_notif_string = "bought upgrade for " + string(cost) + " gold";
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
	#endregion renovations
	
} else if (current_website = website.clothes) {
	
	#region clothing
	//clicked icon
	if (place_meeting(mouse_x, mouse_y, obj_clickbox) and mouse_check_button_pressed(mb_left)) {
		var inst = instance_place(mouse_x, mouse_y, obj_clickbox);
		var inst_redirect = inst.redirect;
		
		if (abs(inst_redirect) == 420) { //increment page inc
			cloth_pageinc += sign(inst_redirect);
			if (cloth_pageinc >= cloth_displaynum div page_icon_num) cloth_pageinc = 0;
			else if (cloth_pageinc < 0) cloth_pageinc = cloth_displaynum div page_icon_num;
			
			
		} else { //CHANGE VARIABLES ACCORDING TO SELECTED TAB
			if (inst_redirect != spr_draw_clothingtype) spr_draw_clothingtype = inst.redirect;
			if (inst_redirect = spr_clothing_head) {
				cloth_page_ds = cloth_ds_head;
				cloth_ds_height = ds_grid_height(cloth_page_ds);
				clothing_display_array = head_array;
				clothing_selection_array = selection_array_head;
				clothing_description_array = description_array_head;
				wardrobe_ds = obj_wardrobe.ds_owned_head;
				show_purchase = false;
				
			} else if (inst_redirect = spr_clothing_body) {
				cloth_page_ds = cloth_ds_body;
				cloth_ds_height = ds_grid_height(cloth_page_ds);
				clothing_display_array = body_array;
				clothing_selection_array = selection_array_body;
				clothing_description_array = description_array_body;
				wardrobe_ds = obj_wardrobe.ds_owned_body;
				show_purchase = false;
			}
		}
	}
	
	tier = obj_stats.tier;
	cloth_displaynum = 0;
	var ii = 0; repeat (tier) {
		cloth_displaynum += clothing_display_array[ii];
		ii += 1;
	}
	cloth_displaynum = clamp(cloth_displaynum, 0, cloth_ds_height);
	
	#region mouse slot
	
	var i_mousex = mouse_x - clot_marginx; //position of mouse relative to page sprite
	var i_mousey = mouse_y - clot_marginy + mouse_scroll;
	
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
					selected_cloth = y_spot;
				}
			}
		}
	} //check if mouse is within grid
	
	//show purchase only set to true if mouse is within bounds of above code
	if (show_purchase and mouse_check_button_pressed(mb_left)) {
					
		if (point_in_rectangle(mouse_x, mouse_y, cloth_pbx, cloth_pby, cloth_pbx + cloth_pbwidth,
		cloth_pby + cloth_pbheight)) { //pb clicked
			  ////////////////////////////////
			 ///PASS VARIABLES TO WARDROBE///
			////////////////////////////////
			#region passing variables
					
			//find y coordinate of ds grid that matches selected slot
						
			//WARDROBE ARGS								//CATALOGUE ARGS
			//arg 0: cloth id							//arg 0: cloth id
			//arg 1: name								//arg 1: type
			//arg 2: clothing type						//arg 2: cost
														//arg 3: name (string)
														//arg 4: already bought or false
					
			var cds = cloth_page_ds;
				
			if (cds[# 4, selected_cloth] == false and obj_stats.gold >= cds[# 2, selected_cloth]) {
				var wd = wardrobe_ds;
				var wheight = ds_grid_height(wd);
					
				if (wd[# 0, 0] != -1) {
					ds_grid_resize(wd, ds_grid_width(wd), wheight + 1);
					wheight += 1;
					show_debug_message("resized grid");
				}
				
				var yy = wheight - 1;
				var cloth_id = cds[# 0, selected_cloth];
						
				wd[# 0, yy] = cloth_id;
				wd[# 1, yy] = cds[# 3, selected_cloth];
				wd[# 2, yy] = cds[# 1, selected_cloth];
				
				obj_stats.gold -= cds[# 2, selected_cloth];
				cds[# 4, selected_cloth] = true;
				show_debug_message(" ");
					
				show_debug_message("cloth id " + string(wd[# 0, yy]));
				show_debug_message("clothing type enum " + string(wd[# 1, yy]));
				show_debug_message("name " + string(wd[# 1, yy]));
				show_debug_message("current gold " + string(obj_stats.gold));
						
				show_debug_message(" ");
				show_purchase = false;
					
			} else if (cds[# 4, selected_cloth] == true) {
				cm_new_notif = true;
				cm_notif_string = "Already purchased this item";
			} else if (obj_stats.gold >= cds[# 2, selected_cloth]) {
				cm_new_notif = true;
				cm_notif_string = "Not enough gold";
				
			}
			
			
			
			#endregion
			
		} else if (point_in_rectangle(mouse_x, mouse_y, cloth_ksx, cloth_ksy, cloth_ksx + cloth_kswidth,
		cloth_ksy + cloth_ksheight)) { //continue shopping
			show_purchase = false;
		} else if (!point_in_rectangle(mouse_x, mouse_y, cloth_spx, cloth_spy, cloth_spx + cloth_spwidth, cloth_spy + cloth_spheight)) {
			show_purchase = false;
		}
	}

	#endregion
	
	#endregion clothing
	
} else if (current_website = website.pills) {
	
	#region pills
	if (current_page == pl_homepage) {
		
		if (instance_place(mouse_x, mouse_y, pl_clickicon) and mouse_check_button_pressed(mb_left)) {
			//set current page to buying page
			
			page_change = true;
			page_destination = spr_pill_buypage;
			
		}
	} else if (current_page == spr_pill_buypage) {
		
		//------BUYING PILLS
		
		if (mouse_check_button_pressed(mb_left)) {
			//upper bound of region
			var pl_linenum = (mouse_y - page_marginy + mouse_scroll) div pl_region_height; //starts from 0
			var mtor = (pl_linenum * pl_region_height) + page_marginy - mouse_scroll;
			
			if (point_in_rectangle(mouse_x, mouse_y, pl_purchasex, pl_py + mtor, pl_purchasex + pl_purchase_width, 
				mtor + pl_py + pl_purchase_height) and pl_linenum < pill_displaynum) {
				
				
				
				var pds = pl_page_ds;
				
				if (obj_stats.gold >= pds[# 2, pl_linenum]) {
					
				  ////////////////////////////////
				 ///PASS VARIABLES TO WARDROBE///
				////////////////////////////////
				#region passing variables
					
				//find y coordinate of ds grid that matches selected slot
						
				//WARDROBE ARGS								//CATALOGUE ARGS
				//arg 0: cloth id							//arg 0: cloth id
				//arg 1: name								//arg 1: type
				//arg 2: clothing type						//arg 2: cost
															//arg 3: name (string)
															//arg 4: already bought or false
					
				
				var wd = obj_wardrobe.ds_owned_pill;
				var wheight = ds_grid_height(wd);
					
				if (wd[# 0, 0] != -1) {
					ds_grid_resize(wd, ds_grid_width(wd), wheight + 1);
					wheight += 1;
				}
				
				var yy = wheight - 1;
				var pill_id = pds[# 0, pl_linenum];
						
				wd[# 0, yy] = pill_id;
				wd[# 1, yy] = pds[# 3, pl_linenum];
				wd[# 2, yy] = pds[# 1, pl_linenum];
				
				obj_stats.gold -= pds[# 2, pl_linenum];
				
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
					cm_notif_string = "Not enough gold";
					
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
	
	
	#endregion pills
}

#region //------check for back button press - ONLY RUN IF PAGE IS NOT DESKTOP BACKGROUND
if (place_meeting(mouse_x, mouse_y, obj_backbutton) and mouse_check_button_pressed(mb_left) and current_page != cm_background) {
	var inst = instance_place(mouse_x, mouse_y, obj_backbutton);
	
	if (inst == back_inst) {
		if (!ds_stack_empty(ds_backpages)) {
			//switch page back to last entry in ds backpages
			page_change = true;
			page_destination = ds_stack_top(ds_backpages);
		}
		
	} else if (inst == x_button) {
		page_change = true;
		page_destination = cm_background;
		
		
	}
}

}

//check for page change
//spawn clickbox instances and destroy old ones
if (page_change) {
	
	//show_debug_message("page change");
	
	if (instance_exists(obj_clickbox)) with (obj_clickbox) instance_destroy();
	
	if (current_page = cm_background) {
		back_inst = instance_create_layer(bbutton_x, bbutton_y, clickbox_depth, obj_backbutton);
		back_inst.image_xscale = bbutton_size/clickbox_size;
		back_inst.image_yscale = bbutton_size/clickbox_size;
		
		x_button = instance_create_layer(xbutton_x, xbutton_y, clickbox_depth, obj_backbutton);
		x_button.image_xscale = x_button_width/clickbox_size;
		x_button.image_yscale = x_button_height/clickbox_size;
		
	} else {
		
		if (!ds_stack_empty(ds_backpages)) {
			if (page_destination != ds_stack_top(ds_backpages)) {
		
				//add current page to list of backpages
				ds_stack_push(ds_backpages, current_page);
				//show_debug_message("put page and ds stack is now size " + string(ds_stack_size(ds_backpages)));
		
				//show_debug_message("ds stack size previous " + string(ds_stack_size(ds_backpages)));
				ds_stack_pop(ds_backpages);
				//show_debug_message("ds stack size current " + string(ds_stack_size(ds_backpages)));
			}
		} else {
			
			//add current page to list of backpages
			ds_stack_push(ds_backpages, current_page);
			//show_debug_message("page pushed onto empty stack");
		}
		
	}
	
	
	switch (page_destination) {
		//computer background
		case cm_background:
			cm_icon_c = set_clickbox(cm_icon_cx, cm_icon_cy, cm_iconsize, cm_iconsize, spr_clothespage);
			cm_icon_r = set_clickbox(cm_icon_rx, cm_icon_ry, cm_iconsize, cm_iconsize, spr_reno_homepage);
			cm_icon_p = set_clickbox(cm_icon_px, cm_icon_py, cm_iconsize, cm_iconsize, spr_pill_homepage);
			cm_icon_s = set_clickbox(cm_icon_sx, cm_icon_sy, cm_iconsize, cm_iconsize, spr_cmp_homepage);
			cm_ie = set_clickbox(cm_ie_x, cm_ie_y, cm_ie_width, cm_ie_height, spr_clothespage);
			
			if (instance_exists(obj_backbutton)) with (obj_backbutton) instance_destroy();
			if (!ds_stack_empty(ds_backpages)) ds_stack_clear(ds_backpages);
			//show_debug_message("cleared ds stack");
			
			break;
		
		//company site
		case spr_cmp_homepage:
			current_website = website.company;
			st_viewst = set_clickbox(st_viewst_x, st_viewst_y, st_viewst_width, st_viewst_height, spr_cmp_statistics);
			break;
			
		case spr_cmp_statistics:
			var inmargin = 15;
			st_upgrade = set_clickbox(st_marginx + inmargin, st_upgradetiery, st_upwidth, st_upheight, "upgrade");
			break;
		
		
		//clothes
		case spr_clothespage:
			current_website = website.clothes;
			spr_draw_clothingtype = spr_clothing_head;
			
			clot_icon_head = set_clickbox(clot_icon_hx, clot_icon_hy, clot_icon_hwidth, clot_icon_hheight, spr_clothing_head);
			clot_icon_body = set_clickbox(clot_icon_bx, clot_icon_by, clot_icon_bwidth, clot_icon_bheight, spr_clothing_body);
			
			clot_icon_rarrow = set_clickbox(clot_pageinc_rx, clot_pageinc_y, clot_pageinc_width, clot_pageinc_height, 420);
			clot_icon_larrow = set_clickbox(clot_pageinc_lx, clot_pageinc_y, clot_pageinc_width, clot_pageinc_height, -420);
			break;
		
		//pills
		case spr_pill_homepage:
			current_website = website.pills;
			pl_clickicon = set_clickbox(pl_clickiconx, pl_clickicony, pl_clickicon_width, pl_clickicon_height, spr_pill_buypage);
			
			break;
		
		//renovations
		case spr_reno_homepage:
			current_website = website.reno;
			reno_furn = set_clickbox(reno_furnx, reno_furny, reno_icon_size, reno_icon_size, website_reno[1]);
			reno_reroom = set_clickbox(reno_reroomx, reno_reroomy, reno_icon_size, reno_icon_size, website_reno[2]);
			reno_roomext = set_clickbox(reno_roomextx, reno_roomexty, reno_icon_size, reno_icon_size, website_reno[0]);
			
			break;
			
		case spr_reno_furniture:
			set_clickbox(reno_bx, reno_by, reno_bwidth, reno_bheight, "furn");
			break;
					
		case spr_reno_reroom:
			set_clickbox(reno_arrowlx, reno_arrow_y, reno_arrowwidth, reno_arrowheight, reno_arrowlx);	
			set_clickbox(reno_arrowrx, reno_arrow_y, reno_arrowwidth, reno_arrowheight, reno_arrowrx);
					
			set_clickbox(reno_dx, reno_dy, reno_dwidth, reno_dheight, reno_dx);		
			set_clickbox(reno_kx, reno_ky, reno_kwidth, reno_kheight, reno_kx);
			set_clickbox(reno_buyx, reno_buyy, reno_buywidth, reno_buyheight, reno_buyx);
					
			break;
		
		
	}
	
	mouse_scroll = 0;
	current_page = page_destination;
	
	page_change = false;
}















#endregion











