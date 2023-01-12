event_inherited();


wd_range = 3;
show_wardrobe = false;

//define functions
event_user(0);



ds_owned_head = ds_grid_create(3, 1);
ds_owned_body = ds_grid_create(3, 1);
ds_owned_pill = ds_grid_create(3, 1);

ds_owned_head[# 0, 0] = -1;
ds_owned_body[# 0, 0] = -1;
ds_owned_pill[# 0, 0] = -1;

ds_pill_info = ds_grid_create(2, 1);		// arg 0: type of pill (sprite index on icon list)			arg 1: number of pills

ds_pill_info[# 0, 0] = -1;


			//WARDROBE ARGS								//CATALOGUE ARGS
			//arg 0: sprite								//arg 0: sprite
			//arg 1: name								//arg 1: name
			//arg 2: description						//arg 2: description
														//arg 3: cost
														//arg 4: already bought or false

//function add_to_wardrobe(_add_from, _add_to, _ind) {
//	var len = ds_grid_height(_add_to);
//	var _ind2 = len - 1;
		
//	_add_to[# 0, _ind2] = _add_from[# 0, _ind];		// sprite
//	_add_to[# 1, _ind2] = _add_from[# 1, _ind];		// name
//	_add_to[# 2, _ind2] = _add_from[# 2, _ind];		// description
	
//}


//var _add_to = ds_owned_head;
//var _add_from = obj_catalogue.ds_clothing_head;
//var len = ds_grid_height(_add_from);
//for (var ii = 0; ii < len; ii++) {
//	var len2 = ds_grid_height(_add_to);
//	if (ii >= len2) ds_grid_resize(_add_to, 3, len2 + 1);
		
//	add_to_wardrobe(_add_from, _add_to, ii);
//}


//var _add_to = ds_owned_body;
//var _add_from = obj_catalogue.ds_clothing_body;
//var len = ds_grid_height(_add_from);
//for (var ii = 0; ii < len; ii++) {
//	var len2 = ds_grid_height(_add_to);
//	if (ii >= len2) ds_grid_resize(_add_to, 3, len2 + 1);
		
//	add_to_wardrobe(_add_from, _add_to, ii);
//}

//var temp_array = [
//	spr_pill_1,
//	spr_pill_2,
//	spr_pill_3,
//	spr_pill_4,
//	spr_pill_5,
//	spr_pill_6,
//	spr_pill_7,
//	spr_pill_8,
//	spr_pill_9,
//	spr_pill_10
//];

//var len = array_length(temp_array);

//var _add_to = ds_owned_pill;
//var _add_from = obj_catalogue.ds_clothing_pill;
//var len = ds_grid_height(_add_from);
//for (var ii = 0; ii < len; ii++) {
//	var len2 = ds_grid_height(_add_to);
//	if (ii >= len2) {
//		ds_grid_resize(_add_to, 3, len2 + 1);
//		ds_grid_resize(ds_pill_info, 2, ds_grid_height(ds_pill_info) + 1);
//	}
		
//	add_to_wardrobe(_add_from, _add_to, ii);
	
//	ds_pill_info[# 1, ii] = choose(2, 7, 4);
	
//		// find pill type
//	for (var j = 0; j < len; j++) {
//		if (_add_from[# 0, ii] == temp_array[j]) {
//			ds_pill_info[# 0, ii] = j;
//			break;
//		}
//	}
//}



//-------------APPEARANCE
gui_width = global.game_width;
gui_height = global.game_height;

// background
wd_bg_width = sprite_get_width(spr_wd_background);
wd_bg_height = sprite_get_height(spr_wd_background);
wd_bg_x = (wd_bg_width/2) - (gui_width/2);
wd_bg_y = (wd_bg_height/2) - (gui_height/2);

// inner background
wd_innerbg_x = wd_bg_x + 128;
wd_innerbg_y = wd_bg_y + 64;
wd_innerbg_width = sprite_get_width(spr_wd_innerbg);
wd_innerbg_height = sprite_get_height(spr_wd_innerbg);

//icons

wd_iconwidth = sprite_get_width(spr_wd_icon)/3;
wd_iconheight = sprite_get_height(spr_wd_icon);

wd_icon_x = wd_innerbg_x;
wd_icon_y = wd_innerbg_y;

wd_icon1 = -1;
wd_icon2 = -1;
wd_icon3 = -1;

hat_offset = 16;		// hat sprite is slightly taller than player sprite



//ui grid
page_index = 0;
scroll_speed = 20;
cell_size = 64;
cell_xbuff = 6;
cell_ybuff = 6;
cell_withbuffx = cell_size + cell_xbuff;
cell_withbuffy = cell_size + cell_ybuff;

grid_hblocks = 3;	// how many blocks in a row
grid_vblocks = 3; // how many blocks in a column
grid_cellnum = grid_hblocks * grid_vblocks;


//-----------DEFAULT VARIABLES
selected_cloth = -1;	// sprite of selected cloth
cloth_index = 0;		// where it is on the ds list

ds_selected = ds_owned_head;
display_num = ds_grid_height(ds_selected); //update continuously in step event



equipped_hat = obj_stats.player_hat;
equipped_clothes = obj_stats.player_clothes;
equipped_pill = obj_stats.player_pill;
stats_pill = obj_stats.player_pill;


grid_x = wd_innerbg_x + 32;
grid_y = wd_innerbg_y + 64;
wd_grid_width = sprite_get_width(spr_wd_grid);
wd_grid_height = sprite_get_height(spr_wd_grid);

clickbox_depth = layer_create(-100);

//arrow icons
wd_arrow_width = sprite_get_width(spr_wd_arrow);
wd_arrow_height = sprite_get_height(spr_wd_arrow);

wd_arrow_lx = grid_x + 10;
wd_arrow_rx = (grid_x + wd_grid_width) - wd_arrow_width - 10;
wd_arrow_y = grid_y + wd_grid_height + 12;

wd_arrow_left = -1;
wd_arrow_right = -1;



//ui description box
wd_desc_x = wd_innerbg_x + 288;
wd_desc_y = wd_innerbg_y + 64;
wd_desc_width = sprite_get_width(spr_wd_descbox);
wd_desc_height = sprite_get_height(spr_wd_descbox);


desc_iconx = wd_desc_x + 16;
desc_icony = wd_desc_y + 16;
desc_iconsize = cell_size * 2;

//display 1: player/current pill
//display 2: hat
//display 3: clothes

icon_index = 0;
icon_displaymax = 3;
display_icon = spr_player;

	// KEEP THIESE NUMBERS EXACTLY
display_icons = {
	display_player: 0,
	display_hat: 1,
	display_clothes: 2
}


icon_equipwidth = sprite_get_width(spr_wd_equip);
icon_equipheight = sprite_get_height(spr_wd_equip);

icon_equipx = desc_iconx + desc_iconsize;
icon_equipy = ((desc_iconsize - icon_equipheight)/2) + desc_icony;
already_equipped = false;


icon_pic = -1;

equip_button = {
	x1: icon_equipx,
	y1: icon_equipy,
	x2: icon_equipx + icon_equipwidth,
	y2: icon_equipy + icon_equipheight
}

icon_square = {
	x1: desc_iconx,
	y1: desc_icony,
	x2: desc_iconx + desc_iconsize,
	y2: desc_icony + desc_iconsize
}



wd_desc_titlex = wd_desc_x + 16;
wd_desc_titley = (desc_icony + desc_iconsize) + 32;


wd_desc_textx = wd_desc_titlex;
wd_desc_texty = (desc_icony + desc_iconsize) + 32;
wd_desc_textwidth = wd_desc_width - (16 * 2);
wd_desc_textheight = (wd_desc_height - 32) - wd_desc_texty;


function dequip_clothing(_icon_index) {
	
	switch (_icon_index) {
		case display_icons.display_player:
			if (equipped_pill != spr_player) {
				equipped_pill	= spr_player;
				display_icon = -1;
			
				ds_pill_info[# 1, pill_index] += 1;
				stats_pill = spr_player;			// allows player to change mind and equip clothes instead of pill
			}
			break;
		
		case display_icons.display_hat:
			if (equipped_hat != -1) {
				equipped_hat = -1;
				display_icon = -1;
			}
			break;
			
		case display_icons.display_clothes:
			if (equipped_clothes != -1) {
				equipped_clothes = -1;
				display_icon = -1;
			}
			break;
	}
	
}


function change_clothing_display(_ds_selected, _display_num) {
	ds_selected = _ds_selected;
	display_num = _display_num;		// #problem show number of clothes depending on tier
				
	page_index = 0;
	selected_cloth = -1;
	cloth_index = 0;
	//pill_index = 0;		// need to keep a separate index for pills to keep it mysterious
	
	icon_index = 0;
	display_icon = equipped_pill;
	
	var equipped_in_category = false;		// is the player already wearing something of the current clothing type
	switch (ds_selected) {
		case ds_owned_head:
			if (equipped_hat != -1) equipped_in_category = true;
			break;
			
		case ds_owned_body:
			if (equipped_clothes != -1) equipped_in_category = true;
			break;
			
		case ds_owned_pill:
			if (equipped_pill != -1) equipped_in_category = true;
			break;
		
	}
	
	
		// change selected clothing to that of the player's
	if (equipped_in_category) {
		for (var i = 0; i < ds_grid_height(ds_selected); i++) {
			var _spr = ds_selected[# 0, i];		// sprite of clothing
			if (_spr == equipped_hat) {
				selected_cloth = _spr;
				cloth_index = i;
			}
		}
	}
}



clothing_type_array = [ds_owned_head, ds_owned_body, ds_owned_pill];










