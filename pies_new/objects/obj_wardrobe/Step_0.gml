if (keyboard_check_pressed(vk_space) and place_meeting(x, y + wd_range, obj_player) and !show_wardrobe and obj_stats.player_pill == spr_player) {
	
	visible = true;
	
	//-----------DEFAULT VARIABLES
	
	//set default variables
	selected_cloth = -1;
	ds_selected = ds_owned_head;
	display_num = ds_grid_height(ds_selected); // how many items of clothing to display
	
	equipped_hat = obj_stats.player_hat;
	equipped_clothes = obj_stats.player_clothes;
	equipped_pill = obj_stats.player_pill;
	stats_pill = obj_stats.player_pill;
	
	show_wardrobe = true;
	global.no_moving = true;
	global.using_escape = true;
	
	#region recreate buttons
	
	wd_icon1 = set_clickbox(wd_icon_x + (wd_iconwidth * 0), wd_icon_y, wd_iconwidth, wd_iconheight);
	wd_icon2 = set_clickbox(wd_icon_x + (wd_iconwidth * 1), wd_icon_y, wd_iconwidth, wd_iconheight);
	wd_icon3 = set_clickbox(wd_icon_x + (wd_iconwidth * 2), wd_icon_y, wd_iconwidth, wd_iconheight);
	
	wd_arrow_left = set_clickbox(wd_arrow_lx, wd_arrow_y, wd_arrow_width, wd_arrow_height);
	wd_arrow_right = set_clickbox(wd_arrow_rx, wd_arrow_y, wd_arrow_width, wd_arrow_height);
	
	icon_pic = set_clickbox(desc_iconx, desc_icony, desc_iconsize, desc_iconsize);
	
	
	#endregion
}

if (!show_wardrobe) exit;
mask_index = spr_smallmask;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

	
//in grid
if (point_in_rectangle(mx, my, grid_x, grid_y, grid_x + wd_grid_width, grid_y + wd_grid_height)) {
		
	var i_mousex = mx - grid_x; //position of mouse relative to grid
	var i_mousey = my - grid_y;
		
	var nx = i_mousex div cell_withbuffx; //shows which slot the mouse is in
	var ny = i_mousey div cell_withbuffy;

	if (nx >= 0 and nx < grid_hblocks and ny >= 0 and ny < grid_vblocks) { //mouse is within bounds of UI
		//show_debug_message("within bounds")
		var sx = i_mousex - (nx * cell_withbuffx);
		var sy = i_mousey - (ny * cell_withbuffy);
	
		if (sx < cell_size and sy < cell_size) { //mouse is not in buffer zone//
			m_slot_x = nx;
			m_slot_y = ny;
				
			var y_spotcomparison = (m_slot_x + (m_slot_y * grid_hblocks))
			var y_spotmax = display_num - (page_index * grid_cellnum); //dont have to subtract by 1 because of >
			var y_spot = y_spotcomparison + (page_index * grid_cellnum); //location on ds grid
			
			//yspotmax should never be negative or 0 otherwise page is displaying empty cells
				
			if (mouse_check_button_pressed(mb_left) and y_spotcomparison < y_spotmax and ds_selected[# 0, 0] != -1) {
				
				//--------SELECTED CLOTHING
				selected_cloth = ds_selected[# 0, y_spot];		// sprite of clothing
				cloth_index = y_spot;							// index of clothing in ds grid
				
				
				if (selected_cloth == equipped_pill or 
					selected_cloth == equipped_hat or 
					selected_cloth == equipped_clothes) {
						already_equipped = true;
					}
				
					else if (ds_selected == ds_owned_pill and daycycle.hours > spawn_phase.first - 2 or stats_pill != spr_player) {
						already_equipped = true;
					}
					
				else already_equipped = false;
				
				icon_index = 0;
				
			}
		}
	}
} //checks if in grid
	
//something selected
if (selected_cloth != -1) {
	
	
	//-------------EQUIP ITEM
	if (mouse_check_button_pressed(mb_left) and mouse_over_button(equip_button, mx, my))
		if (!already_equipped) {
			
			
				if		(ds_selected == ds_owned_head)	{
					equipped_hat		= ds_selected[# 0, cloth_index];
					equipped_pill		= spr_player;
				}
			
				else if (ds_selected == ds_owned_body)	{
					equipped_clothes	= ds_selected[# 0, cloth_index];
					equipped_pill		= spr_player;
				}
			
				else if (ds_selected == ds_owned_pill and ds_pill_info[# 1, cloth_index] > 0) {
					equipped_pill		= ds_selected[# 0, cloth_index];
					pill_index = cloth_index;
					ds_pill_info[# 1, pill_index] -= 1;
				
					// dequip hat and clothes if taking pill
					equipped_hat		= -1;
					equipped_clothes	= -1;
				}
			
				already_equipped = true;
				selected_cloth = -1;
			
		} else if (already_equipped) {
				// dequip selected item
			var thing = -1;
			switch (selected_cloth) {
				case equipped_pill:
					thing = display_icons.display_player;
					break;
				case equipped_hat:
					thing = display_icons.display_hat;
					break;
				case equipped_clothes:
					thing = display_icons.display_clothes;
					break;
			}
			
			if (thing != -1) {
				icon_index = thing;
				dequip_clothing(icon_index);
				already_equipped = false;
				selected_cloth = -1;
				
			}
		}
	
} else { //nothing selected - show current attire
	
	if (mouse_check_button_pressed(mb_left) and mouse_over_button(equip_button, mx, my)) {
		
		//----------DEQUIP ITEM
		
		selected_cloth = -1;
		dequip_clothing(icon_index);		// checks if there is anything to dequip
		// #problem pill is not returning to wardrobe when dequipped if remaning pills = 0
	}
}

#region clicked on button
if (place_meeting(mx, my, obj_clickbox) and mouse_check_button_pressed(mb_left)) {
	
	var inst = instance_place(mx, my, obj_clickbox);
	
	//possible change of ds - ensure variables are updated
	
	switch (inst) {
		case wd_icon1:
			if (ds_selected != ds_owned_head) change_clothing_display(ds_owned_head, ds_grid_height(ds_owned_head));
			break;
			
		case wd_icon2:
			if (ds_selected != ds_owned_body) change_clothing_display(ds_owned_body, ds_grid_height(ds_owned_body));
			break;
			
		case wd_icon3:
			if (ds_selected != ds_owned_pill) change_clothing_display(ds_owned_pill, ds_grid_height(ds_owned_pill));
			
			break;
		
		case icon_pic:
				// change icon pic if no clothes are selected
			if (selected_cloth == -1) {
				icon_index += 1;
				if (icon_index >= icon_displaymax) icon_index = 0;
				
				switch (icon_index) {
					case display_icons.display_player:
						display_icon = spr_player;
						if (equipped_pill != spr_player) display_icon = spr_pill_icons;
						break;
					
					case display_icons.display_hat:
						if (equipped_hat != -1) display_icon = equipped_hat;
						else display_icon = -1;
						break;
					
					case display_icons.display_clothes:
						if (equipped_clothes != -1) display_icon = equipped_clothes;
						else display_icon = -1;
						break;
				}
			}
			break;
		
		case wd_arrow_left:
			if (display_num > 0) page_index -= 1;
			break;
		
		case wd_arrow_right:
			if (display_num > grid_cellnum) page_index += 1;
			break;
	}
	
	//double checking page inc is not out of bounds
	page_index = clamp(page_index, 0, display_num div grid_cellnum);
	
	
}

#endregion clicked on button


if (keyboard_check_pressed(vk_escape)) {
	
		// deselect cloth
	if (selected_cloth != -1) {
		selected_cloth = -1;
		cloth_index = 0;
		
		icon_index = 0;
		display_icon = equipped_pill;
		//show_debug_message("deselected cloth");
		
	}
	
	
	//exit wardrobe
	else if (selected_cloth == -1) {
		
		//pass variables to obj_stats
		
		with (obj_stats) {
			player_hat = other.equipped_hat;
			player_clothes = other.equipped_clothes;
			player_pill = other.equipped_pill;
		}
		
		obj_player.spr_hat = equipped_hat;
		obj_player.spr_clothes = equipped_clothes;
		
		var s_pill = obj_stats.player_pill;
		if (s_pill != spr_player) {
			
			var hh = ds_grid_height(ds_owned_pill);
			var _pill_num = 0;
			
				// loop through to find pill index
			for (var i = 0; i < hh; i++) {
				if (ds_owned_pill[# 0, i] == s_pill) {
					_pill_num  = ds_pill_info[# 1, i];
					break;
				}
			}
			
				// remove pill from grid if none left and grid height is greater than 1
			if (_pill_num == 0) {
				if (hh > 1) {
					var i = 0; repeat (hh) {
					
						if (ds_owned_pill[# 0, i] == equipped_pill) {
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
								
								ds_pill_info[# 0, i - 1] = ds_pill_info[# 0, i];
								ds_pill_info[# 1, i - 1] = ds_pill_info[# 1, i];
							
								i += 1;
							
							}
						
							//show_debug_message("old grid height " + string(ds_grid_height(ds_owned_pill)));
							ds_grid_resize(ds_owned_pill, 3, hh - 1);
							//show_debug_message("resized grid to " + string(ds_grid_height(ds_owned_pill)));
							break;
							
						}
					
						i += 1;
					}
					
				} else if (hh <= 1) { //grid height = 1
					ds_grid_resize(ds_owned_pill, 3, 1);
					ds_grid_clear(ds_owned_pill, -1)
					//show_debug_message("grid height one - resized to 3, 1 and cleared -1");
					//show_debug_message(" ");
					
				}
			}
		}
		
		//obj_player.spr_pill = equipped_pill;
		
		//reset wardrobe variables
		page_index = 0;
		cloth_index = 0;
		pill_index = 0;
		icon_index = 0;
		
		show_wardrobe = false;
		global.no_moving = false;
		global.using_escape = false;
		mask_index = spr_wardrobe;
		visible = false;
		
		if (instance_exists(obj_clickbox)) with (obj_clickbox) instance_destroy();
		
	}
}





