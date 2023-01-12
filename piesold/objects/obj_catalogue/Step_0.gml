//if (!show_catalogue) exit;


if (renovating) {
	
	//destroy unneeded objects
	if (instance_exists(obj_player)) {
		with (obj_player) {
			instance_destroy();
			//show_debug_message("destroyed player");
		}
		
		with (obj_piecutter) {
			other.pc_x = x;
			other.pc_y = y;
			instance_destroy();
		}
		
		instance_destroy(obj_checklist);
		instance_destroy(obj_spawner);
		
	}
	
	//check for clicking
	var mx = mouse_x;
	var my = mouse_y;
	
	
	if (place_meeting(mx, my, obj_table) and mouse_check_button_pressed(mb_left) and !reroom_confirm_purchase) {
		reroom_confirm_purchase = true;
		table_can_upgrade = true;
		show_icon_table = true;
		
		
		var table_inst = instance_place(mx, my, obj_table);
		var inst_tier = table_inst.table_tier;
		var current_tier = obj_stats.tier;
		
		//drawing variables
		rrc_icon_tier = inst_tier;
		rrc_icon_tier = clamp(rrc_icon_tier, 1, array_length_1d(table_upgrade));
		//show_debug_message("table rrc icon tier " + string(rrc_icon_tier));
		
		if (inst_tier = tiermaster.max_tier) {
			table_can_upgrade = false;
			reno_notif_string = "Reached maximum upgrade";
			exit;
		}
		
		if (inst_tier > current_tier) {
			table_can_upgrade = false;
			reno_notif_string = "Upgrade to next tier to unlock this upgrade";
		} else if (obj_stats.gold < table_upgrade[current_tier - 1]) {
			table_can_upgrade = false;
			reno_notif_string = "Not enough gold - you need " + string(table_upgrade[current_tier - 1]) + " gold";
		}
		
		
		
		
		oven_can_upgrade = false;
		show_icon_oven = false;
		table_to_upgrade = table_inst;
		
	}
	
	if (place_meeting(mx, my, par_oven)) {
		if (mouse_check_button_pressed(mb_left) and !reroom_confirm_purchase) {
			
			reroom_confirm_purchase = true;
			oven_can_upgrade = true;
			show_icon_oven = true;
		
			//if (place_meeting(mx, my, obj_piemachine)) var oven_inst = instance_place(mx, my, obj_piemachine);
			//else if (place_meeting(mx, my, obj_piemachine_ext)) var oven_inst = instance_place(mx, my, obj_piemachine_ext);
			
			var oven_inst = instance_place(mx, my, par_oven);
		
			var inst_tier = oven_inst.oven_tier;
			var current_tier = obj_stats.tier;
			
			//drawing variables
			rrc_icon_tier = inst_tier;
			rrc_icon_tier = clamp(rrc_icon_tier, 1, array_length_1d(oven_upgrade));
			
			if (inst_tier = tiermaster.max_tier) {
				oven_can_upgrade = false;
				reno_notif_string = "Reached maximum upgrade";
				exit;
			}
		
			if (inst_tier > current_tier) {
				oven_can_upgrade = false;
				reno_notif_string = "Upgrade to next tier to unlock this upgrade";
			}
		
			else if (obj_stats.gold < oven_upgrade[current_tier - 1]) {
				oven_can_upgrade = false;
				reno_notif_string = "Not enough gold - you need " + string(oven_upgrade[current_tier - 1]) + " gold"
			}
			
			
		
			table_can_upgrade = false;
			show_icon_table = false;
			oven_to_upgrade = oven_inst;
			
		}
	}
	
	//confirming a purchase
	if (reroom_confirm_purchase and keyboard_check_pressed(vk_enter)) {
		if (show_icon_oven) {
			if (oven_can_upgrade) {
				var gold_needed = oven_upgrade[rrc_icon_tier - 1];
				var dbdb = tiermaster.ds_oven_tiers;
				
				obj_stats.gold -= gold_needed;
				oven_to_upgrade.oven_tier += 1;
			
				//find oven to store variables in
				var ii = 0; repeat (ds_grid_height(dbdb)) {
					
					var cx = oven_to_upgrade.x;
					var cy = oven_to_upgrade.y;
					
					var px = dbdb[# 0, ii];
					var py = dbdb[# 1, ii];
					
					if (cx == px and cy == py) {
						var extension_added = dbdb[# 3, ii];
						
						dbdb[# 2, ii] = oven_to_upgrade.oven_tier;
						//show_debug_message("stored tier in machine with coordinates " + string(px) + " " + string(py));
						
						if (oven_to_upgrade.oven_tier >= 3 and !extension_added) {
							
							dbdb[# 3, ii] = true;
							upgraded_ovens += 1;
							
							
							
							reno_new_notif = true;
							reno_notif_string = "extension added";
							
						}
						break;
					}
					ii += 1;	
				}
				//show_debug_message("oven upgraded to tier " + string(oven_to_upgrade.oven_tier) + " with" + string(gold_needed));
				reroom_confirm_purchase = false;
			
			} else reno_new_notif = true;
			
		} else if (show_icon_table) {
			if (table_can_upgrade) {
				var gold_needed = table_upgrade[rrc_icon_tier - 1];
				var dbdb = tiermaster.ds_table_tiers;
				
				obj_stats.gold -= gold_needed;
				table_to_upgrade.table_tier += 1;
			
				//find oven to store variables in
					var ii = 0; repeat (ds_grid_height(dbdb)) {
					
						var cx = table_to_upgrade.x;
						var cy = table_to_upgrade.y;
					
						var px = dbdb[# 0, ii];
						var py = dbdb[# 1, ii];
					
						if (cx == px and cy == py) {
							dbdb[# 2, ii] = table_to_upgrade.table_tier;
							//show_debug_message("stored tier in table with coordinates " + string(px) + " " + string(py));
							break;
						}
						ii += 1;	
					}
				//show_debug_message("table upgraded to tier " + string(table_to_upgrade.table_tier) + " with" + string(gold_needed));
				reroom_confirm_purchase = false;
				
			} else reno_new_notif = true;
		}
	}
	
	
	
	if (keyboard_check_pressed(vk_escape)) {
		if (reroom_confirm_purchase) {
			reroom_confirm_purchase = false;
			
		} else {
			
			
			//WAS NOT WORKING
			with (tiermaster) {
				ds_map_replace(saver.save_data, "table tiers", ds_grid_write(ds_table_tiers));
				ds_map_replace(saver.save_data, "oven tiers", ds_grid_write(ds_oven_tiers));
		
			}
			
			renovating = false;
			done_renovating = true;
			room_goto(rm_attic);
			
			alarm[0] = 1;
		}
	}
}

//if (room == rm_attic and done_renovating) { //set variables back to original
	
	
	
	//sets things back to original variables after create events are run
	//ensures objects exist before setting variables
	
//}












