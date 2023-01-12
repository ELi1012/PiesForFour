event_inherited();


wd_range = 3;
show_wardrobe = false;

//ds grid
//arg 0: clothing id
//arg 1: clothing type
//arg 2: spritesheet
//arg 3: title
//arg 4: description





ds_owned_head = ds_grid_create(3, 1);
ds_owned_body = ds_grid_create(3, 1);
ds_owned_pill = ds_grid_create(3, 1);

ds_owned_head[# 0, 0] = -1;
ds_owned_body[# 0, 0] = -1;
ds_owned_pill[# 0, 0] = -1;

/*
ds_owned_head[# 0, 0] = 0;
ds_owned_head[# 1, 0] = 0;
ds_owned_head[# 2, 0] = spr_head_1;
ds_owned_head[# 3, 0] = "Headgear 1";
ds_owned_head[# 4, 0] = "desc 1";


			//WARDROBE ARGS								//CATALOGUE ARGS
			//arg 0: cloth id							//arg 0: cloth id
			//arg 1: name								//arg 1: type
			//arg 2: clothing type						//arg 2: cost
														//arg 3: name (string)
														//arg 4: already bought or false

var dh = obj_catalogue.ds_clothing_head;
var ii = 0; repeat (obj_catalogue.dsheight_head) {
	var h = ds_grid_height(ds_owned_head);
	if (ii != obj_catalogue.dsheight_head - 1) ds_grid_resize(ds_owned_head, 3, h + 1);
	
	ds_owned_head[# 0, ii] = dh[# 0, ii];
	ds_owned_head[# 1, ii] = dh[# 3, ii];
	ds_owned_head[# 2, ii] = dh[# 1, ii];
	ii += 1;
}

var db = obj_catalogue.ds_clothing_body;
var ii = 0; repeat (obj_catalogue.dsheight_body) {
	var h = ds_grid_height(ds_owned_body);
	if (ii != obj_catalogue.dsheight_body - 1) ds_grid_resize(ds_owned_body, 3, h + 1);
	
	ds_owned_body[# 0, ii] = db[# 0, ii];
	ds_owned_body[# 1, ii] = db[# 3, ii];
	ds_owned_body[# 2, ii] = db[# 1, ii];
	ii += 1;
}

var dp = obj_catalogue.ds_clothing_pill;
var ii = 0; repeat (obj_catalogue.dsheight_pill) {
	var h = ds_grid_height(ds_owned_pill);
	if (ii != obj_catalogue.dsheight_pill - 1) ds_grid_resize(ds_owned_pill, 3, h + 1);
	
	ds_owned_pill[# 0, ii] = dp[# 0, ii];
	ds_owned_pill[# 1, ii] = dp[# 3, ii];
	ds_owned_pill[# 2, ii] = dp[# 1, ii];
	ii += 1;
}

*/

//pill sprites
temp_pill_id = 0;
pill_id = -1;
pill_hcells = 4;



//-------------APPEARANCE
gui_width = global.game_width;
gui_height = global.game_height;

//big boy background
wd_bg_width = sprite_get_width(spr_wd_background);
wd_bg_height = sprite_get_height(spr_wd_background);
wd_bg_x = (wd_bg_width/2) - (gui_width/2);
wd_bg_y = (wd_bg_height/2) - (gui_height/2);

//inner background
wd_innerbg_x = wd_bg_x + 128;
wd_innerbg_y = wd_bg_y + 64;
wd_innerbg_width = sprite_get_width(spr_wd_innerbg);
wd_innerbg_height = sprite_get_height(spr_wd_innerbg);

//icons
wd_iconwidth = sprite_get_width(spr_wd_icon);
wd_iconheight = sprite_get_height(spr_wd_icon);

wd_icon_x = wd_innerbg_x;
wd_icon_y = wd_innerbg_y;

wd_icon1 = -1;
wd_icon2 = -1;
wd_icon3 = -1;





//ui grid
wd_pageinc = 0;
scroll_speed = 20;
cell_size = 64;
cell_xbuff = 6;
cell_ybuff = 6;
cell_withbuffx = cell_size + cell_xbuff;
cell_withbuffy = cell_size + cell_ybuff;

wd_grid_hblocks = 3;
wd_grid_vblocks = 3; //ceil(ds_selected_height/wd_grid_hblocks);
wd_grid_cellnum = wd_grid_hblocks * wd_grid_vblocks;


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


wd_grid_x = wd_innerbg_x + 32;
wd_grid_y = wd_innerbg_y + 64;
wd_grid_width = sprite_get_width(spr_wd_grid);
wd_grid_height = sprite_get_height(spr_wd_grid);

//arrow icons
wd_arrow_width = sprite_get_width(spr_wd_arrow);
wd_arrow_height = sprite_get_height(spr_wd_arrow);

wd_arrow_lx = wd_grid_x + 10;
wd_arrow_rx = (wd_grid_x + wd_grid_width) - wd_arrow_width - 10;
wd_arrow_y = wd_grid_y + wd_grid_height + 12;

wd_arrow_left = -1;
wd_arrow_right = -1;



//ui description box
wd_desc_x = wd_innerbg_x + 288;
wd_desc_y = wd_innerbg_y + 64;
wd_desc_width = sprite_get_width(spr_wd_descbox);
wd_desc_height = sprite_get_height(spr_wd_descbox);


wd_desc_iconx = wd_desc_x + 16;
wd_desc_icony = wd_desc_y + 16;
wd_desc_iconsize = cell_size * 2;

//display 1: player/current pill
//display 2: hat
//display 3: clothes

icon_displayinc = 0;
icon_displaymax = 3;
icon_displaycur = spr_player;


icon_equipwidth = sprite_get_width(spr_wd_equip);
icon_equipheight = sprite_get_height(spr_wd_equip);

icon_equipx = wd_desc_iconx + wd_desc_iconsize;
icon_equipy = ((wd_desc_iconsize - icon_equipheight)/2) + wd_desc_icony;
already_equipped = false;

icon_equip = -1;
icon_pic = -1;


wd_desc_titlex = wd_desc_x + 16;
wd_desc_titley = (wd_desc_icony + wd_desc_iconsize) + 32;


wd_desc_textx = wd_desc_titlex;
wd_desc_texty = (wd_desc_icony + wd_desc_iconsize) + 32;
wd_desc_textwidth = wd_desc_width - (16 * 2);
wd_desc_textheight = (wd_desc_height - 32) - wd_desc_texty;

//run if setting show wardrobe as true in create event
/*

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

















