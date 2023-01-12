event_inherited();
event_user(0);

using_computer = false;
glow_timer = 0;
glow_spd = 15;
flicker = false;
fframe = 0;
c_len = sprite_get_number(spr_computer_glow);



// COMPUTER DEACTIVATES OBJ_UI WHEN DOING RENOVATIONS



//ui

var s = 1;
taskbar = 36;
upper_taskbar = sprite_get_height(cm_upper_taskbar);
taskbar_height = sprite_get_height(cm_lower_taskbar);
gui_width = global.game_width * s;		// game width: 832
gui_height = global.game_height * s;	// game height: 448

screen_width = gui_width/2;
screen_x = (gui_width - screen_width) / 2;
screen_y = 60 * s;
screen_bottomy = 50 * s;		// distance between bottom of screen and bottom of sprite
screen_height = gui_height - (screen_y + screen_bottomy) - taskbar_height;
mouse_scroll = 0;
scroll_speed = 20;

clickbox_depth = layer_create(-100);
set_clickboxes = false;


ds_prev_pages = ds_stack_create();

page_redirect = 1;

cm_notif = false;
cm_notif_timer = 0;
cm_notif_max = 2;
cm_notif_string = " ";
cm_new_notif = false;

catx = 18;
caty = 210;
cat_len = 7;
cat_extra = 6;

cat_blink = false;
blink_timer = 5;
frame = 0;
frame_spd = 8;




//------COMPUTER BACKGROUND
	
	computer_screen = {
		x1: screen_x,
		y1: screen_y,
		x2: screen_x + screen_width,
		y2: screen_y + screen_height + taskbar
	}
	
	cm_iconsize = sprite_get_width(cm_folders);
	clicked_once = false;
	dbclick_timer = 0;
	dbclick_max = 1/4;
	var icon_spacing = cm_iconsize + 30;
	var startx = 30 + screen_x;
	var starty = 30 + screen_y;
	
	//clothing icon
	cm_icon_cx = startx;
	cm_icon_cy = starty;
	//cm_icon_c = set_clickbox(cm_icon_cx, cm_icon_cy, cm_iconsize, cm_iconsize, spr_clothespage);
	
	// interior page
	cm_icon_ix = startx + icon_spacing;
	cm_icon_iy = starty;

	//renovations icon
	cm_icon_rx = startx + (icon_spacing * 2);
	cm_icon_ry = starty;
	//cm_icon_r = set_clickbox(cm_icon_rx, cm_icon_ry, cm_iconsize, cm_iconsize, spr_reno_homepage);
	
	
	//pill icon
	cm_icon_px = startx + (icon_spacing * 3);
	cm_icon_py = starty;
	//cm_icon_p = set_clickbox(cm_icon_px, cm_icon_py, cm_iconsize, cm_iconsize, spr_pill_homepage);
	
	//view statistics
	cm_icon_sx = startx;
	cm_icon_sy = starty + icon_spacing;
	
	// room editor
	cm_icon_ex = startx + icon_spacing;
	cm_icon_ey = starty + icon_spacing;
	
	

	//lower taskbar
	cm_tb_x = screen_x;
	cm_tb_y = sprite_get_height(cm_background) + screen_y - taskbar_height;
	
	// internet explorer window
	cm_addressbar_x = 210 + screen_x;
	cm_addressbar_y = 38 + screen_y;
	
	scroll_bar_x = 404 + screen_x;
	scroll_bar_y = 56 + screen_y;
	scroll_bar_window_height = 228;		// height of empty scrolling bar
	
	cm_window_width = 400;
	cm_window_height = 238;
	cm_window_y = screen_y + 56;		// y position of top left corner of window
	cm_window_x = screen_x + 4;




tier = obj_stats.tier;


	// state functions
event_user(1);
event_user(2);



current_page = desktop_page;
draw_page_function = desktop_page_draw;		// has to be set in step functions during page changes
page_sprite = cm_background;

page_width = sprite_get_width(page_sprite);
page_height = sprite_get_height(page_sprite);


page_marginx = screen_x + 4;
page_marginy = screen_y + 56;






var xx = 390 + screen_x;
var yy = 6 + screen_y;
var button_size = 20;
exit_browser_button = {
	x1: xx,
	y1: yy,
	x2: xx + button_size,
	y2: yy + button_size
}

xx = 10 + screen_x;
yy = 33 + screen_y;
button_size = 20;
back_page_button = {
	x1: xx,
	y1: yy,
	x2: xx + button_size,
	y2: yy + button_size
}



//statistics

st_viewst = 0;
st_viewst_width = 180;
st_viewst_height = 50;
st_viewst_x = 196 + page_marginx;
st_viewst_y = 164 + page_marginy;

//text
st_marginx = 30 + page_marginx;
st_marginx_rj = page_width - 30 + page_marginx;



spr_stars_width = sprite_get_width(spr_cmp_stars_full);
spr_stars_height = sprite_get_height(spr_cmp_stars_full);
st_starx = (page_width/2) - (spr_stars_width/2) + page_marginx;
st_stary = 200 + page_marginy;
star_num = 5;
st_starwidth = 44;
st_starmargin = 4; //distance between stars


st_tiertexty = st_stary + spr_stars_height + 20;
st_upgradetiery = st_tiertexty + 40;
st_upwidth = sprite_get_width(spr_cmp_icons);
st_upheight = sprite_get_height(spr_cmp_icons);


tier_upgrade = tiermaster.tier_upgrade;
tier_req = tiermaster.tier_req;

st_upgrade = 0;




#region //--------PILLS WEBSITE
	
	pl_clickiconx = 2 + page_marginx;
	pl_clickicony = 228 + page_marginy;
	pl_clickicon_width = 64;
	pl_clickicon_height = 20;
	
	pl_region_height = 96;
	pl_px = 1; //x distance from page margin x
	pl_py = 66; //y distance from page margin y
	
	pl_purchasex = pl_px + page_marginx; //x location relative to gui layer
	pl_purchasey = pl_py + page_marginy;
	pl_purchase_width = 54;
	pl_purchase_height = 14;
	
	pl_textx = 1;
	pl_texty = 81;
	
	pl_iconx = 1;
	pl_icony = 1;
	
	pl_sprsheet_hblocks = 4;
	
	
	pl_page_height = sprite_get_height(spr_pill_buypage);
	
	
	
	
	//set variables from obj catalogue
	pl_page_ds = obj_catalogue.ds_clothing_pill;
	pill_ds_height = ds_grid_height(pl_page_ds);
	
	pill_display_array = obj_catalogue.pill_length; //how many icons to display from sprite sheet
	
	
	
	
	tier = obj_stats.tier;
	pill_displaynum = 0;
	var ii = 0; repeat (tier) {
		pill_displaynum += pill_display_array[ii];
		ii += 1;
	}
	pill_displaynum = clamp(pill_displaynum, 0, pill_ds_height);
	
	
	
	
	
#endregion










#region //------CLOTHES WEBSITE
	clot_marginx = 32 + cm_window_x;
	clot_marginy = 144 + cm_window_y;
	
	clot_page_width = 352 + cm_window_x;
	clot_page_height = 440 + cm_window_y;
	
	hat_offset = 16;
	
	//icons
	clot_icon_hx = 32 + cm_window_x;
	clot_icon_hy = 80 + cm_window_y;
	clot_icon_hwidth = 96;
	clot_icon_hheight = 16;
	icon_head = 0;
	//set_clickbox(clot_icon_hx, clot_icon_hy, clot_icon_hwidth, clot_icon_hheight, spr_clothing_head);
	
	
	clot_icon_bx = 128 + cm_window_x;
	clot_icon_by = 80 + cm_window_y;
	clot_icon_bwidth = 96;
	clot_icon_bheight = 16;
	icon_body = 0;
	//set_clickbox(clot_icon_bx, clot_icon_by, clot_icon_bwidth, clot_icon_bheight, spr_clothing_body);
	
	
	var xx = 32 + cm_window_x;
	var yy = 80 + cm_window_y;
	var w = 96;
	var h = 16;
	head_tab = {
		x1: xx,
		y1: yy,
		x2: xx + w,
		y2: yy + h
	}
	
	xx = 128 + cm_window_x;
	yy = 80 + cm_window_y;
	w = 96;
	h = 16;
	body_tab = {
		x1: xx,
		y1: yy,
		x2: xx + w,
		y2: yy + h
	}
	
	
	clot_pageinc_rx = 216 + cm_window_x;
	clot_pageinc_lx = 288 + cm_window_x;
	clot_pageinc_y = 576 + cm_window_y;
	
	clot_pageinc_width = 64;
	clot_pageinc_height = 32;
	
	icon_head_tab = 0;
	icon_body_tab = 0;
	icon_r_arrow = 0;
	icon_l_arrow = 0;
	
	//set_clickbox(clot_pageinc_rx, clot_pageinc_y, clot_pageinc_width, clot_pageinc_height, 420);
	//set_clickbox(clot_pageinc_lx, clot_pageinc_y, clot_pageinc_width, clot_pageinc_height, -420);
	
	show_purchase = false;
	
	//show purchase
	cloth_spwidth = sprite_get_width(spr_clothes_confirm);
	cloth_spheight = sprite_get_height(spr_clothes_confirm);
	cloth_spx = (screen_width/2) - (cloth_spwidth/2) + cm_window_x;
	cloth_spy = (screen_height/2) - (cloth_spheight/2) + cm_window_y;
	
	var xx = (screen_width/2) - (cloth_spwidth/2) + cm_window_x;
	var yy = (screen_height/2) - (cloth_spheight/2) + cm_window_y;
	var w = sprite_get_width(spr_clothes_confirm);
	var h = sprite_get_height(spr_clothes_confirm);
	show_purchase_screen = {
		x1: xx,
		y1: yy,
		x2: xx + w,
		y2: yy + h
	}
	
	//purchase button
	cloth_pbx = 188 + cloth_spx;
	cloth_pby = 128 + cloth_spy;
	cloth_pbwidth = 128;
	cloth_pbheight = 24;
	
	var xx = 188 + cloth_spx;
	var yy = 128 + cloth_spy;
	var w = 128;
	var h = 24;
	clothes_purchase_button = {
		x1: xx,
		y1: yy,
		x2: xx + w,
		y2: yy + h
	}
	
	var pp = clothes_purchase_button;
	xx = pp.x1 + 20;
	yy = pp.y1 - 20;
	w = 128 - (20 * 2);
	h = 12;
	clothes_exit_button = {
		x1: xx,
		y1: yy,
		x2: xx + w,
		y2: yy + h
	}
	
	//continue shopping
	cloth_ksx = cloth_pbx + 20;
	cloth_ksy = cloth_pby - 20;
	cloth_kswidth = cloth_pbwidth - (20 * 2);
	cloth_ksheight = 12;
	
	
	ds_head = obj_catalogue.ds_clothing_head;
	ds_body = obj_catalogue.ds_clothing_body;
	
	
	//set defaults
	clothing_display_page = spr_clothing_head;
	ds_selected = ds_head;
	display_array = obj_catalogue.head_length;					// how many clothing to show depending on tier
	//clothing_selection_array = selection_array_head;
	//clothing_description_array = description_array_head;
	
	wardrobe_ds = obj_wardrobe.ds_owned_head;
	
	
	
	cell_size = 64;
	desc_size = 40;
	x_buffer = 8;
	y_buffer = 48;

	page_rows = 5;
	page_columns = 2;
	page_icon_num = page_rows * page_columns;
	
	//WILL NOT APPEAR IF THERE ARE NOT ENOUGH SPRITES
	
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

#endregion clothes website




#region //------INTERIOR WEBSITE
	
	// for id purposes
interior_tabs = {
	table: 0,
	table_x: 250 + cm_window_x,
	table_y: 46 + cm_window_y,
	
	oven: 1,
	oven_x: 304 + cm_window_x,
	oven_y: 46 + cm_window_y,
	
	arrow_left: 2,
	arrow_right: 3,
	
	buy_button: 4,
	buy_furniture_x: 210 + cm_window_x,
	buy_ext_x: 210 + 64 + 16 + cm_window_x,
	buy_button_y: 170 + cm_window_y
}

current_tab = interior_tabs.table;
current_tab_x = interior_tabs.table_x;

int_index = 1;		// use to cycle through tables; start from 1

#endregion





//COORDINATES REFER TO TOP LEFT
#region //-------RENO WEBSITE
	
	//pages
	website_reno = [spr_reno_homepage, spr_reno_furniture, spr_reno_reroom];
	
	reno_icon_size = 64;
	
	//home page
	reno_furnx = 70 + page_marginx;
	reno_furny = 164 + page_marginy;
	
	reno_furn = 0;
	reno_reroom = 0;
	reno_roomext = 0;

	reno_reroomx = 70 + page_marginx;
	reno_reroomy = 250 + page_marginy;
	
	reno_roomextx = 30 + page_marginx;
	reno_roomexty = 200 + page_marginy;
	reno_confirm_roomext = false;
	
	rcre_x = ((screen_width/2) - (sprite_get_width(spr_reno_confirm_ext)/2)) + page_marginx;
	rcre_y = ((screen_height/2) - (sprite_get_height(spr_reno_confirm_ext)/2)) + page_marginy;
	
	rcre_yesx = rcre_x + 64;
	rcre_yesy = rcre_y + 160;
	
	rcre_nox = rcre_x + 192;
	rcre_noy = rcre_y + 160;
	
	rcre_yn_width = 64;
	rcre_yn_height = 32;
	
	
	//furniture page
	reno_bx = 192 + page_marginx;
	reno_by = 128 + page_marginy;
	reno_bwidth = 192;
	reno_bheight = 64;
	
	//reroom page
	// variables are set in function
	
	var xx = 16 + page_marginx;
	var yy = 320 + page_marginy;
	var w = 16;
	var h = 64;
	
	reno_buttons = {
		right_arrow: 0,
		left_arrow: 1,
		dining_button: 2,
		kitchen_button: 3,
		buy_button: 4
	}
	
	reno_reroom_view = spr_reno_reroomd;
	ra_inc = 0;
	ra_max = tiermaster.max_tier - 1;
	
	
	dbought_room_upgrade = false;
	kbought_room_upgrade = false;
	current_dining = obj_stats.dining_bg;
	current_kitchen = obj_stats.kitchen_bg;
	reno_drawbuttond = true;
	reno_drawbuttonk = true;
	
	
#endregion reno website




function page_change(_old_page, _new_page, _go_back = false) {
	set_clickboxes = true;
	mouse_scroll = 0;
	current_page = _new_page;
	
	if (instance_exists(obj_clickbox)) with (obj_clickbox) instance_destroy();
	
		// update ds stack	
	if (_new_page == desktop_page) ds_stack_clear(ds_prev_pages);
	
		// add old page to previous pages if back button has not been pressed
	if (_old_page != desktop_page and !_go_back) {
		
			// add new page to stack
		ds_stack_push(ds_prev_pages, _old_page);
	}
}


	// called from within computer
function begin_room_edit() {
	
	with (obj_catalogue) {
		editing_room = true;
		mouse_scroll = other.mouse_scroll;
		current_page_function = other.current_page;
		current_page_draw_function = other.draw_page_function;
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

function extend_room() {
	////////////////////////////////
	//----------CHANGE MAIN ROOM
	////////////////////////////////
	with (obj_stats) {
		room_extended = true;
		piebucks -= obj_catalogue.room_upgrade;
	}
				
	with (obj_game) {
		target_x = ext_target_x;
		target_y = ext_target_y;
	}
					
	with (obj_tilesetter) {
		kitchen_x = 1024;
		floor_y = 256;
						
		diningroom_wall = spr_bg_wall_ext;
		kitchen_wall = spr_k_wall_ext;
						
		diningroom_floor = spr_bg_floor_ext;
		kitchen_floor = spr_k_wall_ext;
	}
	
	with (furniture_handler) {
		var tablenum = room_upgrade_furniture.table_num;
		var ovennum = room_upgrade_furniture.oven_num;
		
		with (furniture_data) {
			
				// new tables
			var len = array_length(table_types);
			var new_table_num = tablenum - len;
			var new_table_type = 1;
			
			repeat (new_table_num) {
				array_push(table_types, new_table_type);
				table_types_purchased[new_table_type] += 1;
			}
			
				// new ovens
			var len = array_length(oven_types);
			var new_oven_num = ovennum - len;
			var new_oven_type = 1;
			
			repeat (new_oven_num) {
				array_push(oven_types, new_oven_type);
				array_push(ovens_extended, false);
				oven_types_purchased[new_oven_type] += 1;
			}
			
			
		}
	}
					
					
	show_debug_message("room extended");
	
}