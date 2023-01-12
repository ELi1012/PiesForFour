


editing_room = false;

gui_width = global.game_width;
gui_height = global.game_height;

	// variables passed from computer
	// pass back to computer once finished room editing

mouse_scroll = 0;
current_page_function = -1;
current_page_draw_function = -1;
px = -1;
py = -1;

//draw variables for piecutter
pc_x = -1;
pc_y = -1;


	// LOCATION OF TABLE ON DS GRID IS DETERMINED BY HOW FAR AWAY IT IS FROM 0, 0


furniture_inst = -1;
furniture_type = -1;
furniture_sprite = -1;
furniture_type_available = -1;

furniture_types = {
	table: 0,
	oven: 1
}

table_type_available = -1;

oven_type_available = -1;
ovens_to_extend = 2;

switch_furniture = false;
thing_index = 0;



event_user(0);


reroom_confirm_width = sprite_get_width(spr_reno_confirm);
reroom_confirm_height = sprite_get_height(spr_reno_confirm);

reroom_confirmx = (gui_width/2) - (reroom_confirm_width/2);
reroom_confirmy = (gui_height/2) - (reroom_confirm_height/2);

rrc_text_font = fnt_beeg;
rrc_icon_x = reroom_confirmx + 20;
rrc_icon_y = reroom_confirmy + 20 + (sprite_get_yoffset(spr_piemachine) * 2);
rrc_text_x = rrc_icon_x + (sprite_get_width(spr_piemachine) * 2) + 20;
rrc_text_y = reroom_confirmy + 20;
rrc_text_width = reroom_confirm_width - (rrc_icon_x + 20) + (20 * 2);


reno_new_notif = false;
reno_notif = false;
reno_notif_timer = 0;
reno_notif_max = 2;
reno_notif_string = " ";






//---------AVAILABE CLOTHING ACCORDING TO TIER
head_length = [3, 4, 2, 2];
body_length = [2, 2, 0, 0];
pill_length = [6, 1, 2, 1];



//----------ITEM COSTS
reroomd_array = [50, 350, 500, 750];
reroomk_array = [25, 175, 250, 375];

table_upgrade	= [150, 250, 350];
oven_upgrade	= [650, 750, 850];

room_upgrade = 2000;
oven_extension = 800;




//-----WARDDROBE
ds_clothing_head = ds_grid_create(5, 1);
ds_clothing_body = ds_grid_create(5, 1);
ds_clothing_pill = ds_grid_create(5, 1);

ds_clothing_head[# 0, 0] = -1;
ds_clothing_body[# 0, 0] = -1;
ds_clothing_pill[# 0, 0] = -1;




//ARGUMENTS != DS GRID WIDTH
//arg 0: ds id
//arg 1: sprite
//arg 2: name
//arg 3: description
//arg 4: cost
//arg 5: bought (true/false)


#region head
var _name = [
	"Glasses",
	"Bowlcut",
	"Froggy Hat",
	"Turtle Mask",
	"Pie Buddy",
	"bruh",
	"Orange Hat",
	"hat 7",
	"hat 8",
	"hat 9",
	"hat 10",
	"hat 11",
	"hat 12"
]

var _dsc = [
	"the better to see your pies with",
	"pairs well with glasses",
	"froggy hat",
	"wear with the shell",
	"where'd this guy come from",
	"ok",
	"might taste like orange too",
	"d7",
	"d8",
	"d9",
	"d10",
	"d11",
	"d12",
];


var ddd = ds_clothing_head;
create_wardrobe(ddd, spr_head_1, _name[0], _dsc[0], 5);
create_wardrobe(ddd, spr_head_2, _name[1], _dsc[1], 8);
create_wardrobe(ddd, spr_head_3, _name[2], _dsc[2], 9);
create_wardrobe(ddd, spr_head_4, _name[3], _dsc[3], 10);
create_wardrobe(ddd, spr_head_5, _name[4], _dsc[4], 11);
create_wardrobe(ddd, spr_head_6, _name[5], _dsc[5], 3);
create_wardrobe(ddd, spr_head_7, _name[6], _dsc[6], 6);
create_wardrobe(ddd, spr_head_8, _name[7], _dsc[7], 2);
create_wardrobe(ddd, spr_head_9, _name[8], _dsc[8], 5);
create_wardrobe(ddd, spr_head_10, _name[9], _dsc[9], 8);
create_wardrobe(ddd, spr_head_11, _name[10], _dsc[10], 9);
create_wardrobe(ddd, spr_head_12, _name[11], _dsc[11], 10);

#endregion



#region body
var _name = [
	"shirt",
	"shirt 2",
	"shirt 3",
];

var _dsc = [
	"dsc1",
	"desc2",
	"desc3",
];


var ddd = ds_clothing_body;
create_wardrobe(ddd, spr_body_1, _name[0], _dsc[0], 1);
create_wardrobe(ddd, spr_body_2, _name[1], _dsc[1], 2);
create_wardrobe(ddd, spr_body_3, _name[2], _dsc[2], 3);


#endregion

#region pill
var _name = [
	"olfactory enhancer",
	"beast pill",
	"rotund pill",
	"tomato pill",
	"protein pill",
	"pill 6",
	"pill 7",
	"pill 8",
	"pill 9",
	"pill 10"
]

var _dsc = [
	"the better to smell your pies with",
	"might cause itching",
	"to help you blend in",
	"accompany with a side of mozzarella and basil",
	"you are now better at climbing trees",
	"desc 6",
	"desc 7",
	"desc 8",
	"desc 9",
	"desc 10",
];


var ddd = ds_clothing_pill;
create_wardrobe(ddd, spr_pill_1, _name[0], _dsc[0], 15);
create_wardrobe(ddd, spr_pill_2, _name[1], _dsc[1], 8);
create_wardrobe(ddd, spr_pill_3, _name[2], _dsc[2], 7);
create_wardrobe(ddd, spr_pill_4, _name[3], _dsc[3], 8);
create_wardrobe(ddd, spr_pill_5, _name[4], _dsc[4], 8);
create_wardrobe(ddd, spr_pill_6, _name[5], _dsc[5], 3);
create_wardrobe(ddd, spr_pill_7, _name[6], _dsc[6], 6);
create_wardrobe(ddd, spr_pill_8, _name[7], _dsc[7], 2);
create_wardrobe(ddd, spr_pill_9, _name[8], _dsc[8], 5);
create_wardrobe(ddd, spr_pill_10, _name[9], _dsc[9], 8);


#endregion








