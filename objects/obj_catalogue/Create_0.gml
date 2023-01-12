


renovating = false;
done_renovating = false;

gui_width = global.game_width;
gui_height = global.game_height;

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

//drawing to show
rrc_icon_tier = 1;

reno_new_notif = false;
reno_notif = false;
reno_notif_timer = 0;
reno_notif_max = 2;
reno_notif_string = " ";


reroom_confirm_purchase = false;

oven_can_upgrade = true;
oven_to_upgrade = -1;
show_icon_oven = false;

table_can_upgrade = true;
table_to_upgrade = -1;
show_icon_table = false;

notif_x = 30;
notif_y = 30;

comp_scroll = -1;
cur_page = -1;
px = -1;
py = -1;

//draw variables
pc_x = -1;
pc_y = -1;



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

//never set number greater than total amount of ovens - 1
upgraded_ovens = 0;


//-----WARDDROBE
ds_clothing_head = ds_grid_create(5, 1);
ds_clothing_body = ds_grid_create(5, 1);
ds_clothing_pill = ds_grid_create(5, 1);

ds_clothing_head[# 0, 0] = -1;
ds_clothing_body[# 0, 0] = -1;
ds_clothing_pill[# 0, 0] = -1;

enum cloth_type {
	head,
	body,
	pill //put empty cell for clothing spritesheet for no clothing
}

enum cloth_head {
	head1,
	head2,
	head3,
	head4,
	head5,
	head6,
	head7,
	head8,
	head9,
	head10,
	head11,
	head12,
	head13,
	head14,
	head15,
	head16,
	height
}

enum cloth_body {
	body1,
	body2,
	body3,
	height
}

enum cloth_pill {
	pill1,
	pill2,
	pill3,
	pill4,
	pill5,
	pill6,
	pill7,
	pill8,
	pill9,
	pill10,
	height
}


//array stores sprites for clothing
//second array stores description (shown once item is bought)
array_clothing_selectionh = [
	spr_head_1,
	spr_head_2,
	spr_head_3,
	spr_head_4,
	spr_head_5,
	spr_head_6,
	spr_head_7,
	spr_head_8,
	spr_head_9,
	spr_head_10,
	spr_head_11,
	spr_head_12,
	spr_head_13,
	spr_head_14,
	spr_head_15,
	spr_head_16
];

array_descriptionh = [
	"simple blue hat, for testing at first but its cool",
	"oops no description 2",
	"oops no description 3",
	"oops no description 4",
	"oops no description 5",
	"oops no description 6",
	"oops no description 7",
	"oops no description 8",
	"oops no description 9",
	"oops no description 10",
	"oops no description 11",
	"oops no description 12",
	"oops no description 13",
	"oops no description 14",
	"oops no description 15",
	"oops no description 16"
];

array_clothing_selectionb = [
	spr_body_1,
	spr_body_2,
	spr_body_3
	
	
];

array_descriptionb = [
	"desc 1",
	"desc 2",
	"desc 3",
	"desc 4",
	"desc 5",
	"desc 6",
	"desc 7",
	"desc 8",
	"desc 9",
	"desc 10",
	"desc 11",
	"desc 12",
	"desc 13",
	"desc 14",
	"desc 15",
	"desc 16"
	
];

array_clothing_selectionp = [
	spr_pill_1,
	spr_pill_2,
	spr_pill_3,
	spr_pill_4,
	spr_pill_5,
	spr_pill_6,
	spr_pill_7,
	spr_pill_8,
	spr_pill_9,
	spr_pill_10,
];

array_descriptionp = [
	"desc 1",
	"desc 2",
	"desc 3",
	"desc 4",
	"desc 5",
	"desc 6",
	"desc 7",
	"desc 8",
	"desc 9",
	"desc 10",
];

//array is to keep the pill type a mystery
//ARRAY LENGTH MUST ALWAYS BE EQUAL TO DS LENGTH
array_titlep = [
	"epic pill",
	"other pill",
	"something pill",
	"pill 4",
	"pill 5",
	"pill 6",
	"pill 7",
	"pill 8",
	"pill 9",
	"pill 10"
	
];








//ARGUMENTS != DS GRID WIDTH
//arg 1: cloth id
//arg 2: type
//arg 3: cost
//arg 4: name (string)
//arg 5: bought (true/false)



create_wardrobe(cloth_head.head1, cloth_type.head, 5, "Headgear 1");
create_wardrobe(cloth_head.head2, cloth_type.head, 8, "Headgear 2");
create_wardrobe(cloth_head.head3, cloth_type.head, 9, "Headgear 3");
create_wardrobe(cloth_head.head4, cloth_type.head, 10, "Headgear 4");
create_wardrobe(cloth_head.head5, cloth_type.head, 11, "Headgear 5");
create_wardrobe(cloth_head.head6, cloth_type.head, 3, "Headgear 6");
create_wardrobe(cloth_head.head7, cloth_type.head, 6, "Headgear 7");
create_wardrobe(cloth_head.head8, cloth_type.head, 2, "Headgear 8");
create_wardrobe(cloth_head.head9, cloth_type.head, 5, "Headgear 9");
create_wardrobe(cloth_head.head10, cloth_type.head, 8, "Headgear 10");
create_wardrobe(cloth_head.head11, cloth_type.head, 9, "Headgear 11");
create_wardrobe(cloth_head.head12, cloth_type.head, 10, "Headgear 12");
create_wardrobe(cloth_head.head13, cloth_type.head, 11, "Headgear 13");
create_wardrobe(cloth_head.head14, cloth_type.head, 3, "Headgear 14");
create_wardrobe(cloth_head.head15, cloth_type.head, 6, "Headgear 15");
create_wardrobe(cloth_head.head16, cloth_type.head, 2, "Headgear 16");



create_wardrobe(cloth_body.body1, cloth_type.body, 3, "Bodygear 1");
create_wardrobe(cloth_body.body2, cloth_type.body, 6, "Bodygear 2");
create_wardrobe(cloth_body.body3, cloth_type.body, 7, "Bodygear 3");

create_wardrobe(cloth_pill.pill1, cloth_type.pill, 5, "wha tis this");
create_wardrobe(cloth_pill.pill2, cloth_type.pill, 6, "the 2");
create_wardrobe(cloth_pill.pill3, cloth_type.pill, 6, "pie monster");
create_wardrobe(cloth_pill.pill4, cloth_type.pill, 7, "tomato man");
create_wardrobe(cloth_pill.pill5, cloth_type.pill, 9, "Michel");
create_wardrobe(cloth_pill.pill6, cloth_type.pill, 5, "Pill 6");
create_wardrobe(cloth_pill.pill7, cloth_type.pill, 6, "Pill 7");
create_wardrobe(cloth_pill.pill8, cloth_type.pill, 6, "Pill 8");
create_wardrobe(cloth_pill.pill9, cloth_type.pill, 7, "Pill 9");
create_wardrobe(cloth_pill.pill10, cloth_type.pill, 6, "Pill 10");








