if (place_meeting(x, y + wd_range, obj_player) and keyboard_check_pressed(vk_space) and !show_wardrobe) {
	
	visible = true;
	
	//-----------DEFAULT VARIABLES
	selected_cloth = -1;
	ds_selected = ds_owned_head;
	wd_grid_displaynum = ds_grid_height(ds_selected); //update continuously in step event
	wd_grid_displayarray = obj_catalogue.array_clothing_selectionh; //depedent on default ds grid
	wd_grid_descarray = obj_catalogue.array_descriptionh;

	equip_hat = obj_stats.player_hat;
	equip_clothes = obj_stats.player_clothes;
	equip_pill = obj_stats.player_pill;
	stats_pill = obj_stats.player_pill;
	
	show_wardrobe = true;
	global.no_moving = true;
	global.using_escape = true;
	
	//set default variables
	selected_cloth = -1;
	ds_selected = ds_owned_head;
	wd_grid_displaynum = ds_grid_height(ds_selected); //update continuously in step event
	wd_grid_displayarray = obj_catalogue.array_clothing_selectionh; //depedent on default ds grid
	wd_grid_descarray = obj_catalogue.array_descriptionh;
	
	#region recreate buttons
	var cb_depth = 100;
	var bsize = sprite_get_width(spr_clickbox);
	
	wd_icon1 = instance_create_depth(wd_icon_x + (wd_iconwidth * 0), wd_icon_y, cb_depth, obj_backbutton);
	wd_icon2 = instance_create_depth(wd_icon_x + (wd_iconwidth * 1), wd_icon_y, cb_depth, obj_backbutton);
	wd_icon3 = instance_create_depth(wd_icon_x + (wd_iconwidth * 2), wd_icon_y, cb_depth, obj_backbutton);
	
	with (obj_backbutton) {
		image_xscale = other.wd_iconwidth/bsize;
		image_yscale = other.wd_iconheight/bsize;
	}
	
	wd_arrow_left = instance_create_depth(wd_arrow_lx, wd_arrow_y, cb_depth, obj_backbutton);
	wd_arrow_right = instance_create_depth(wd_arrow_rx, wd_arrow_y, cb_depth, obj_backbutton);
	
	with (wd_arrow_left) {
		image_xscale = other.wd_arrow_width/bsize;
		image_yscale = other.wd_arrow_height/bsize;
	}

	with (wd_arrow_right) {
		image_xscale = other.wd_arrow_width/bsize;
		image_yscale = other.wd_arrow_height/bsize;
	}
	
	icon_equip = instance_create_depth(icon_equipx, icon_equipy, cb_depth, obj_backbutton);
	icon_equip.image_xscale = icon_equipwidth/bsize;
	icon_equip.image_yscale = icon_equipheight/bsize;


	icon_pic = instance_create_depth(wd_desc_iconx, wd_desc_icony, cb_depth, obj_backbutton);
	icon_pic.image_xscale = wd_desc_iconsize/bsize;
	icon_pic.image_yscale = wd_desc_iconsize/bsize;
	
	#endregion
}

if (!show_wardrobe) exit;
mask_index = spr_smallmask;

	
//in grid
if (point_in_rectangle(mouse_x, mouse_y, wd_grid_x, wd_grid_y, wd_grid_x + wd_grid_width, wd_grid_y + wd_grid_height)) {
		
	var i_mousex = mouse_x - wd_grid_x; //position of mouse relative to grid
	var i_mousey = mouse_y - wd_grid_y;
		
	var nx = i_mousex div cell_withbuffx; //shows which slot the mouse is in
	var ny = i_mousey div cell_withbuffy;

	if (nx >= 0 and nx < wd_grid_hblocks and ny >= 0 and ny < wd_grid_vblocks) { //mouse is within bounds of UI
		//show_debug_message("within bounds")
		var sx = i_mousex - (nx * cell_withbuffx);
		var sy = i_mousey - (ny * cell_withbuffy);
	
		if (sx < cell_size and sy < cell_size) { //mouse is not in buffer zone//
			m_slot_x = nx;
			m_slot_y = ny;
				
			var y_spotcomparison = (m_slot_x + (m_slot_y * wd_grid_hblocks))
			var y_spotmax = wd_grid_displaynum - (wd_pageinc * wd_grid_cellnum); //dont have to subtract by 1 because of >
			var y_spot = y_spotcomparison + (wd_pageinc * wd_grid_cellnum); //location on ds grid
			
			//yspotmax should never be negative or 0 otherwise page is displaying empty cells
				
			if (mouse_check_button_pressed(mb_left) and y_spotcomparison < y_spotmax and ds_selected[# 0, 0] != -1) {
				
				//--------SELECTED CLOTHING
				selected_cloth = y_spot;
				cloth_id = ds_selected[# 0, y_spot];
				temp_pill_id = cloth_id;
				
				var ca = wd_grid_displayarray[cloth_id];
				
				if (ca == equip_pill or ca == equip_hat or ca == equip_clothes) already_equipped = true;	
				else if (ds_selected == ds_owned_pill and daycycle.hours > spawn_phase.first - 2) already_equipped = true;
				else if (stats_pill != spr_player) already_equipped = true;
				else already_equipped = false;
				
				icon_displayinc = 0;
				
				//show_debug_message("cloth selected " + string(selected_cloth));
			}
		}
	}
} //checks if in grid
	
//something selected
if (selected_cloth > -1) {
	
	
	//-------------EQUIP ITEM
	if (mouse_check_button_pressed(mb_left) and !already_equipped) {
		if (instance_place(mouse_x, mouse_y, icon_equip)) {
			already_equipped = true;
			
			
			if		(ds_selected == ds_owned_head)	{
				equip_hat		= wd_grid_displayarray[cloth_id];
				equip_pill		= spr_player;
			}
			
			else if (ds_selected == ds_owned_body)	{
				equip_clothes	= wd_grid_displayarray[cloth_id];
				equip_pill		= spr_player;
			}
			
			else if (ds_selected == ds_owned_pill and stats_pill == spr_player) {
				equip_pill		= wd_grid_displayarray[cloth_id];
				pill_id			= temp_pill_id;
				
				equip_hat		= -1;
				equip_clothes	= -1;
			}
			
			//show_debug_message("equipped thing");
			
		}
	}
	
} else { //nothing selected - show current attire
	
	if (mouse_check_button_pressed(mb_left)) {
		
		//----------clicked on unequip button
		if (instance_place(mouse_x, mouse_y, icon_equip)) {
			
			if		(icon_displayinc == 1 and equip_hat != -1) {
				equip_hat = -1;
				icon_displaycur = -1;
				//show_debug_message("unequipped hat");
			}
			else if (icon_displayinc == 2 and equip_clothes != -1) {
				equip_clothes = -1;
				icon_displaycur = -1;
				//show_debug_message("unequipped clothes");
			}
			else if (icon_displayinc == 0 and equip_pill != spr_player) {
				equip_pill	= spr_player;
				icon_displaycur = -1;
				//show_debug_message("unequipped pill");
			}
			
			
			
		}
	}
}

#region clicked on button
if (place_meeting(mouse_x, mouse_y, obj_backbutton) and mouse_check_button_pressed(mb_left)) {
	
	var inst = instance_place(mouse_x, mouse_y, obj_backbutton);
	
	//possible change of ds - ensure variables are updated
	
	switch (inst) {
		case wd_icon1:
			if (ds_selected != ds_owned_head) {
				ds_selected = ds_owned_head;
				wd_grid_displaynum = ds_grid_height(ds_selected);
				wd_grid_displayarray = obj_catalogue.array_clothing_selectionh;
				wd_grid_descarray = obj_catalogue.array_descriptionh;
				
				wd_pageinc = 0;
				selected_cloth = -1;
				icon_displayinc = 0;
				icon_displaycur = equip_pill;
			}
			break;
			
		case wd_icon2:
			if (ds_selected != ds_owned_body) {
				ds_selected = ds_owned_body;
				wd_grid_displaynum = ds_grid_height(ds_selected);
				wd_grid_displayarray = obj_catalogue.array_clothing_selectionb;
				wd_grid_descarray = obj_catalogue.array_descriptionb;
				wd_pageinc = 0;
				selected_cloth = -1;
				icon_displayinc = 0;
				icon_displaycur = equip_pill;
			}
			break;
			
		case wd_icon3:
			if (ds_selected != ds_owned_pill) {
				ds_selected = ds_owned_pill;
				wd_grid_displaynum = ds_grid_height(ds_selected);
				wd_grid_displayarray = obj_catalogue.array_clothing_selectionp;
				wd_grid_descarray = obj_catalogue.array_descriptionp;
				wd_pageinc = 0;
				selected_cloth = -1;
				icon_displayinc = 0;
				icon_displaycur = equip_pill;
			}
			break;
		
		case icon_pic:
			if (selected_cloth == -1) {
				icon_displayinc += 1;
				if (icon_displayinc >= icon_displaymax) icon_displayinc = 0;
				
				switch (icon_displayinc) {
					case 0:
						icon_displaycur = equip_pill;
						break;
					
					case 1:
						if (equip_hat != -1) icon_displaycur = equip_hat;
						else icon_displaycur = -1;
						break;
					
					case 2:
						if (equip_clothes != -1) icon_displaycur = equip_clothes;
						else icon_displaycur = -1;
						break;
				}
			}
			break;
		
		case wd_arrow_left:
			if (wd_grid_displaynum > 0) wd_pageinc -= 1;
			break;
		
		case wd_arrow_right:
			if (wd_grid_displaynum > wd_grid_cellnum) wd_pageinc += 1;
			break;
	}
	
	//double checking page inc is not out of bounds
	wd_pageinc = clamp(wd_pageinc, 0, wd_grid_displaynum div wd_grid_cellnum);
	
	
}

#endregion clicked on button


if (keyboard_check_pressed(vk_escape)) {
	
	//exit wardrobe
	if (selected_cloth = -1) {
		//pass variables to obj_stats
		
		with (obj_stats) {
			player_hat = other.equip_hat;
			player_clothes = other.equip_clothes;
			player_pill = other.equip_pill;
		}
		
		obj_player.spr_hat = equip_hat;
		obj_player.spr_blothes = equip_clothes;
		
		if (equip_pill != spr_player) {
			//loop through grid until cluster number matches current number
			var hh = ds_grid_height(ds_owned_pill);
				
			if (hh > 1) { //grid height is not one
				var i = 0; repeat (hh) {
					
					if (ds_owned_pill[# 0, i] = pill_id) {
						//show_debug_message("found pill id " + string(pill_id));
						//reset variables of all columns below current i
						i += 1;
						var leftofgrid = hh - i;
						repeat (leftofgrid) {
							
							//show_debug_message("replaced " + string(ds_owned_pill[# 0, i - 1]) + " with "
							//	+ string(ds_owned_pill[# 0, i]));
							
							ds_owned_pill[# 0, i - 1] = ds_owned_pill[# 0, i];
							ds_owned_pill[# 1, i - 1] = ds_owned_pill[# 1, i];
							ds_owned_pill[# 2, i - 1] = ds_owned_pill[# 2, i];
							
							i += 1;
							
						}
						
						//show_debug_message("old grid height " + string(ds_grid_height(ds_owned_pill)));
						ds_grid_resize(ds_owned_pill, 3, hh - 1);
						//show_debug_message("resized grid to " + string(ds_grid_height(ds_owned_pill)));
						break;
							
					}
					
					i += 1;
				}
					
			} else { //grid height = 1
				ds_grid_resize(ds_owned_pill, 3, 1);
				ds_grid_clear(ds_owned_pill, -1)
				//show_debug_message("grid height one - resized to 3, 1 and cleared -1");
				//show_debug_message(" ");
					
			}
		}
		
		
		with (obj_stats) event_perform(ev_alarm, 0);
		
		obj_player.spr_pill = spr_player;
		
		var ddh = ds_owned_head;
		var ddb = ds_owned_body;
		var ddp = ds_owned_pill;
		
		with (saver) {
			//save ds grids in savedata
			ds_map_replace(save_data, "owned hats", ds_grid_write(ddh));
			ds_map_replace(save_data, "owned clothes", ds_grid_write(ddb));
			ds_map_replace(save_data, "owned pills", ds_grid_write(ddp));
		}
	
		
		
		//reset wardrobe variables
		wd_pageinc = 0;
		icon_displayinc = 0;
		show_wardrobe = false;
		global.no_moving = false;
		global.using_escape = false;
		mask_index = spr_wardrobe;
		visible = false;
		
		if (instance_exists(obj_backbutton)) with (obj_backbutton) instance_destroy();
		
	} else { //deselect current clothing
		selected_cloth = -1;
		icon_displayinc = 0;
		icon_displaycur = equip_pill;
		//show_debug_message("deselected cloth");
	}
}





