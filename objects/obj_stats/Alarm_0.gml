//save obj stats to savedata map
var _map = saver.save_data;
	
ds_map_replace(_map, "gold", gold);
ds_map_replace(_map, "rating", rating);
ds_map_replace(_map, "hat", player_hat);
ds_map_replace(_map, "clothes", player_clothes);
ds_map_replace(_map, "pill", player_pill);

ds_map_replace(_map, "day", daycycle.day);
ds_map_replace(_map, "seconds", daycycle.seconds);
	
ds_map_replace(_map, "tier", tier);
ds_map_replace(_map, "current room", current_room);
ds_map_replace(_map, "dining bg", dining_bg);
ds_map_replace(_map, "kitchen bg", kitchen_bg);
	
ds_map_replace(_map, "trans x", trans_x);
ds_map_replace(_map, "trans y", trans_y);