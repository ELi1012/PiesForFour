if (!using_computer and keyboard_check_pressed(vk_space) and place_meeting(x, y + 10, obj_player)) {
	
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
	
	
	set_clickboxes = true;
	
	//current_page = desktop_page;
	//draw_page_function = desktop_page_draw;
	//page_sprite = spr_clothespage;
	
	current_page = interior_page;
	draw_page_function = interior_page_draw;
	page_sprite = spr_interior_page;
	
	//pill defaults
	pill_displaynum = 0;
	var ii = 0; repeat (tier) {
		pill_displaynum += pill_display_array[ii];
		ii += 1;
	}
	pill_displaynum = clamp(pill_displaynum, 0, pill_ds_height);
	
	//clothing defaults
	show_purchase = false;
	clothing_display_page = spr_clothing_head;
	ds_selected = ds_head;
	display_array = obj_catalogue.head_length;					// how many clothing to show depending on tier
	wardrobe_ds = obj_wardrobe.ds_owned_head;
	
	m_slot_x = -1;
	m_slot_y = -1;
	
	//draw these
	cloth_displaysize = 64;
	cloth_displaynum = 0;
	cloth_pageinc = 0;
	
	var ii = 0; repeat (tier) {
		cloth_displaynum += display_array[ii];
		ii += 1;
	}
	cloth_displaynum = clamp(cloth_displaynum, 0, ds_grid_height(ds_selected));
	selected_cloth_index = 0;
	
	//reno defaults
	reno_reroom_view = spr_reno_reroomd;
	ra_inc = 0;
	ra_max = tiermaster.max_tier - 1;
	
	current_dining = obj_stats.dining_bg;
	current_kitchen = obj_stats.kitchen_bg;
	
	#endregion computer defaults
	
	
	if (!ds_stack_empty(ds_prev_pages)) ds_stack_clear(ds_prev_pages);
	
}

if (!using_computer) exit;

//ALWAYS RESET MOUSE SCROLL TO 0 IF CHANGING PAGES

mask_index = spr_smallmask;
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);


#region extend room cheat

//if (keyboard_check_pressed(vk_printscreen)) extend_room();


#endregion


//change to if user clicks sign out button
if (keyboard_check_pressed(vk_escape)) {
	using_computer = false;
	global.no_moving = false;
	global.using_escape = false;
	mask_index = spr_computer;
	visible = false;
	
	
	mouse_scroll = 0;
	current_page = desktop_page;
	
	//SAVE DATA
	//save ds grids in savedata
	//with (obj_wardrobe) {
	//	ds_map_replace(saver.save_data_map, "owned hats", ds_grid_write(ds_owned_head));
	//	ds_map_replace(saver.save_data_map, "owned clothes", ds_grid_write(ds_owned_body));
	//	ds_map_replace(saver.save_data_map, "owned pills", ds_grid_write(ds_owned_pill));
	//}
	
	
	if (instance_exists(obj_clickbox)) with (obj_clickbox) instance_destroy();
	exit;
}




//update page marginy and screen height if changing to cm background

if (mouse_over_button(computer_screen, mx, my)) {


// run step function for page
current_page(mx, my);


//run this if page changes
if (current_page != pills_buypage and current_page != interior_page) page_height = sprite_get_height(page_sprite);


//scrolling mouse
if (page_height > cm_window_height and current_page != desktop_page) {
	if (mouse_wheel_up()) mouse_scroll -= scroll_speed;
	if (mouse_wheel_down()) mouse_scroll += scroll_speed;
	mouse_scroll = clamp(mouse_scroll, 0, page_height - cm_window_height);
} else mouse_scroll = 0;

// obj_clickbox.y scrolls with mouse scroll
if (instance_exists(obj_clickbox)) {
	with (obj_clickbox) y = initial_y - other.mouse_scroll;
}


//IF CHANGING PAGES ALWAYS USE PAGE CHANGE AND PAGE DESTINATION OR ELSE CLICKBOXES WONT SPAWN


// go back one page or exit browser
if (mouse_check_button_pressed(mb_left) and current_page != desktop_page) {
	
	if (mouse_over_button(back_page_button, mx, my)) {
			// go back one page
		if (!ds_stack_empty(ds_prev_pages) and ds_stack_top(ds_prev_pages) != current_page) {
				//switch page back to last entry in ds prev pages
			var last_pg = ds_stack_top(ds_prev_pages);
			ds_stack_pop(ds_prev_pages);
			page_change(current_page, last_pg, true);
		}
	
	} else if (mouse_over_button(exit_browser_button, mx, my)) {
		// exit browser
		page_change(current_page, desktop_page);
	}
}






} // if mouse is over computer screen












