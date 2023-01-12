//STORE ALL IMPORTANT VARIABLES IN HERE


piebucks = 5000;
rating = 0;
day_rating = 0;

//clothes
player_hat = -1;
player_clothes = -1;
player_pill = spr_player;

//upgrades
tier = 3;			// current tier of player; first tier starts from 1

room_extended = false;
dining_bg = 0;
kitchen_bg = 0;





event_user(0);





// to be used in saver during saving
// this is here because there is a lot of data in obj_stats
data_store = function() {
	var _data = {
		piebucks: piebucks,
		rating: rating,
		tier: tier,
		room_extended: room_extended,
	
		player_hat: player_hat,
		player_clothes: player_clothes,
		player_pill: player_pill,
		
	
	}
	
	return _data;
}

data_load = function(_struct) {
	piebucks = _struct.piebucks;
	rating = _struct.rating;
	tier = _struct.tier;
	room_extended = _struct.room_extended;
	
	player_hat = _struct.player_hat;
	player_clothes = _struct.player_clothes;
	player_pill = _struct.player_pill;
	
}



if (room_extended) {
	with (obj_game) {
		target_x = ext_target_x;
		target_y = ext_target_y;
	}
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