event_inherited();

using_computer = false;
glow_timer = 0;
glow_spd = 15;
flicker = false;
fframe = 0;
c_len = sprite_get_number(spr_computer_glow);




//ui
taskbar = 36;
upper_taskbar = sprite_get_height(cm_upper_taskbar);
gui_width = global.game_width;
gui_height = global.game_height;

screen_width = gui_width/2;
screen_x = (gui_width - screen_width) / 2;
screen_y = 60;
screen_bottomy = 50;
screen_height = gui_height - (screen_y + screen_bottomy) - taskbar;
mouse_scroll = 0;
scroll_speed = 20;

clickbox_depth = layer_create(-100);
clickbox_size = sprite_get_width(spr_clickbox);

pl_homepage = spr_pill_homepage;

page_change = false;
page_destination = cm_background;
ds_backpages = ds_stack_create();

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
	cm_iconsize = sprite_get_width(cm_folders);
	clicked_once = false;
	dbclick_timer = 0;
	dbclick_max = 1/4;
	
	//clothing icon
	cm_icon_cx = 30 + screen_x;
	cm_icon_cy = 30 + screen_y;
	//cm_icon_c = set_clickbox(cm_icon_cx, cm_icon_cy, cm_iconsize, cm_iconsize, spr_clothespage);

	//renovations icon
	cm_icon_rx = (cm_iconsize + 30) + 30 + screen_x;
	cm_icon_ry = 30 + screen_y;
	//cm_icon_r = set_clickbox(cm_icon_rx, cm_icon_ry, cm_iconsize, cm_iconsize, spr_reno_homepage);
	
	
	//pill icon
	cm_icon_px = ((cm_iconsize + 30) * 2) + 30 + screen_x;
	cm_icon_py = 30 + screen_y;
	//cm_icon_p = set_clickbox(cm_icon_px, cm_icon_py, cm_iconsize, cm_iconsize, spr_pill_homepage);
	
	//view statistics
	cm_icon_sx = 30 + screen_x;
	cm_icon_sy = screen_y + (cm_iconsize + 30) + 30;
	

	//lower taskbar
	cm_tb_width = sprite_get_width(cm_lower_taskbar);
	cm_tb_height = sprite_get_height(cm_lower_taskbar);
	cm_tb_x = screen_x;
	cm_tb_y = sprite_get_height(cm_background) - cm_tb_height + screen_y;
	
	//internet explorer
	cm_ie_width = 83;
	cm_ie_height = cm_tb_height;
	cm_ie_x = 249 + cm_tb_x;
	cm_ie_y = cm_tb_y;
	//cm_ie = set_clickbox(cm_ie_x, cm_ie_y, cm_ie_width, cm_ie_height, spr_clothespage);
	
	
	




enum website {
	clothes,
	reno,
	pills,
	company
	
}




tier = obj_stats.tier;

//SET CURRENT PAGE OF WEBSITE AS 0 BY DEFAULT WHEN SWITCHING WEBSITES
current_website = website.pills;
current_page = cm_background;
page_width = sprite_get_width(current_page);
page_height = sprite_get_height(current_page);
page_marginx = screen_x;
page_marginy = screen_y + upper_taskbar;



bbutton_x = 16 + page_marginx;
bbutton_y = 0 + screen_y;
bbutton_size = 32;
back_page = -1;

xbutton_x = 386 + screen_x;
xbutton_y = 2 + screen_y;
x_button_width = 26;
x_button_height = 25;



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
	
	pl_title_array = obj_catalogue.array_titlep;
	clothing_selection_array = obj_catalogue.array_clothing_selectionp;
	pill_display_array = obj_catalogue.pill_length; //how many icons to display from sprite sheet
	pl_desc_array = obj_catalogue.array_descriptionp;
	pl_wardrobe_ds = obj_wardrobe.ds_owned_pill;
	
	
	
	
	tier = obj_stats.tier;
	pill_displaynum = 0;
	var ii = 0; repeat (tier) {
		pill_displaynum += pill_display_array[ii];
		ii += 1;
	}
	pill_displaynum = clamp(pill_displaynum, 0, pill_ds_height);
	
	
	
	
	
#endregion










#region //------CLOTHES WEBSITE
	clot_marginx = 32 + page_marginx;
	clot_marginy = 144 + page_marginy;
	
	clot_page_width = 352 + page_marginx;
	clot_page_height = 440 + page_marginy;
	
	//icons
	clot_icon_hx = 32 + page_marginx;
	clot_icon_hy = 80 + page_marginy;
	clot_icon_hwidth = 96;
	clot_icon_hheight = 16;
	clot_icon_head = 0;
	//set_clickbox(clot_icon_hx, clot_icon_hy, clot_icon_hwidth, clot_icon_hheight, spr_clothing_head);
	
	
	clot_icon_bx = 128 + page_marginx;
	clot_icon_by = 80 + page_marginy;
	clot_icon_bwidth = 96;
	clot_icon_bheight = 16;
	clot_icon_body = 0;
	//set_clickbox(clot_icon_bx, clot_icon_by, clot_icon_bwidth, clot_icon_bheight, spr_clothing_body);
	
	clot_pageinc_rx = 216 + page_marginx;
	clot_pageinc_lx = 288 + page_marginx;
	clot_pageinc_y = 576 + page_marginy;
	
	clot_pageinc_width = 64;
	clot_pageinc_height = 32;
	
	clot_icon_rarrow = 0;
	clot_icon_larrow = 0;
	
	//set_clickbox(clot_pageinc_rx, clot_pageinc_y, clot_pageinc_width, clot_pageinc_height, 420);
	//set_clickbox(clot_pageinc_lx, clot_pageinc_y, clot_pageinc_width, clot_pageinc_height, -420);
	
	show_purchase = false;
	
	//show purchase
	cloth_spwidth = sprite_get_width(spr_clothes_confirm);
	cloth_spheight = sprite_get_height(spr_clothes_confirm);
	cloth_spx = (screen_width/2) - (cloth_spwidth/2) + page_marginx;
	cloth_spy = (screen_height/2) - (cloth_spheight/2) + page_marginy;
	
	//purchase button
	cloth_pbx = 188 + cloth_spx;
	cloth_pby = 128 + cloth_spy;
	cloth_pbwidth = 128;
	cloth_pbheight = 24;
	
	//continue shopping
	cloth_ksx = cloth_pbx + 20;
	cloth_ksy = cloth_pby - 20;
	cloth_kswidth = cloth_pbwidth - (20 * 2);
	cloth_ksheight = 12;
	
	
	
	cloth_ds_head = obj_catalogue.ds_clothing_head;
	cloth_ds_body = obj_catalogue.ds_clothing_body;
	head_array = obj_catalogue.head_length;
	body_array = obj_catalogue.body_length;
	selection_array_head = obj_catalogue.array_clothing_selectionh;
	selection_array_body = obj_catalogue.array_clothing_selectionb;
	description_array_head = obj_catalogue.array_descriptionh;
	description_array_body = obj_catalogue.array_descriptionb;
	
	//set defaults
	spr_draw_clothingtype = spr_clothing_head;
	cloth_page_ds = cloth_ds_head;
	cloth_ds_height = ds_grid_height(cloth_page_ds);
	clothing_display_array = head_array; //how many icons to display from sprite sheet
	clothing_selection_array = selection_array_head;
	clothing_description_array = description_array_head;
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
		cloth_displaynum += clothing_display_array[ii];
		ii += 1;
	}
	cloth_displaynum = clamp(cloth_displaynum, 0, cloth_ds_height);
	selected_cloth = 0;

#endregion clothes website







//COORDINATES REFER TO TOP LEFT
#region //-------RENO WEBSITE
	
	//pages
	website_reno = [spr_reno_homepage, spr_reno_furniture, spr_reno_reroom];
	
	reno_icon_size = 64;
	
	//home page
	reno_furnx = 30 + page_marginx;
	reno_furny = 500 + page_marginy;
	
	reno_furn = 0;
	reno_reroom = 0;
	reno_roomext = 0;

	reno_reroomx = screen_width - 30 - reno_icon_size + page_marginx;
	reno_reroomy = 500 + page_marginy;
	
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
	reno_arrowlx = 16 + page_marginx;
	reno_arrowrx = 384 + page_marginx;
	reno_arrow_y = 320 + page_marginy;
	
	reno_arrowwidth = 16;
	reno_arrowheight = 64;
	
	reno_dx = 64 + page_marginx;
	reno_dy = 512 + page_marginy;
	reno_dwidth = 96;
	reno_dheight = 64;
	
	reno_kx = 256 + page_marginx;
	reno_ky = 512 + page_marginy;
	reno_kwidth = 96;
	reno_kheight = 64;
	
	reno_selx = 48 + page_marginx;
	reno_sely = 240 + page_marginy;
	reno_selwidth = sprite_get_width(spr_reno_reroomd);
	reno_selheight = sprite_get_height(spr_reno_reroomd);
	
	reno_buyx = 200 + page_marginx;
	reno_buyy = 400 + page_marginy;
	reno_buywidth = sprite_get_width(spr_reno_reroomb);
	reno_buyheight = sprite_get_height(spr_reno_reroomb);
	
	
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





