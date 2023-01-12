//STORE ALL IMPORTANT VARIABLES IN HERE

gold = 5000;
rating = 0;
day_rating = 0;

//clothes
player_hat = -1;
player_clothes = -1;
player_pill = spr_player;

//upgrades
tier = 1;

current_room = rm_main;
dining_bg = 0;
kitchen_bg = 0;



default_target_x = 1312;
default_target_y = 318;

ext_target_x = 1120;
ext_target_y = 508;



if (current_room == rm_main) {
	target_x = default_target_x;
	target_y = default_target_y;
} else if (current_room == rm_main_ext) {
	target_x = ext_target_x;
	target_y = ext_target_y;
}



//drawing variables
gui_width = global.game_width;
gui_height = global.game_height;

x_margin = gui_width - 30;
y_margin = 30;

new_notif = false;
notif = false;
notif_string = " ";
notif_timer = 0;
notif_max = 2;