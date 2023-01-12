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


//store attic transition goal

default_trans_x = 1312;
default_trans_y = 318;

ext_trans_x = 1120;
ext_trans_y = 508;



if (current_room == rm_main) {
	trans_x = default_trans_x;
	trans_y = default_trans_y;
} else if (current_room == rm_main_ext) {
	trans_x = ext_trans_x;
	trans_y = ext_trans_y;
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