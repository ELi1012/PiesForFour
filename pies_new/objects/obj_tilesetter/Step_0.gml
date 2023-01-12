if (!daycycle.time_pause and !global.game_pause) {
	var an_check = daycycle.hours;
	
	// spawn background npcs
	if (an_check mod an_biker == 0) {
		var cc = choose(1, 2);
		if (cc == 1) {
			var dir = choose(0, 1);
			var spawnplace = 0;
			var bk_dir = 1;
			
			if (dir == 0) {
				spawnplace = room_width;
				bk_dir = -1;
			}
		
			var bbb = instance_create_layer(spawnplace, an_by, bg_instance, obj_biker);
			bbb.dir = bk_dir;
		
			//show_debug_message("biker created");
		}
	} else if (an_check mod an_customer == 0) {
		var cc = choose(1, 2);
		if (cc == 1) {
			var dir = choose(0, 1);
			var spawnplace = 0;
			var bk_dir = 1;
			
			if (dir == 0) {
				spawnplace = room_width;
				bk_dir = -1;
			}
		
			var an_cy = irandom_range(an_ccy - 10, an_ccy);
		
			var bbb = instance_create_layer(spawnplace, an_cy, bg_instance, obj_bg_customer);
			var scale = (an_cy * (an_cy/an_ccy))/an_ccy;
		
			bbb.dir = bk_dir;
			bbb.size_scale = scale;
			bbb.spd = 2 * (scale * scale);
		
			//show_debug_message("customer bg created");
		
		}
		
	} else if (an_check mod an_car == 0) {
		var cc = choose(1, 2);
		if (cc == 1) {
			var dir = choose(0, 1);
			var spawnplace = 0;
			var bk_dir = 1;
			
			if (dir == 0) {
				spawnplace = room_width - (global.camerax * 0.9);
				bk_dir = -1;
			}
		
			var bbb = instance_create_layer(spawnplace, an_cary, bg_instance, obj_bg_car);
			bbb.dir = bk_dir;
			bbb.car_type = choose(0, 1);
		
		}
	}
}




