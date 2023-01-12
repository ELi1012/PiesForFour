

//assign tier variables to furniture
if (instance_exists(obj_table) and !has_tables) {
	
	if (!ds_exists(ds_table_tiers, ds_type_grid)) {
		
		//--------TABLE
		ds_table_tiers = ds_grid_create(3, 1);
		
		var i;
		var table_num = instance_number(obj_table);
		
		for (i = 0; i < table_num; i += 1) {
			var t_inst = instance_find(obj_table, i);
			ds_table_tiers[# 0, i] = t_inst.x;
			ds_table_tiers[# 1, i] = t_inst.y;
			ds_table_tiers[# 2, i] = tier;
			t_inst.table_tier = tier;
			
			//show_debug_message("stored " + string(ds_table_tiers[# 1, i]) + " in " + string(t_inst));
			
			if (i != table_num - 1) ds_grid_resize(ds_table_tiers, ds_grid_width(ds_table_tiers), ds_grid_height(ds_table_tiers) + 1);
		}
		
		//---------OVEN
		ds_oven_tiers = ds_grid_create(4, 1);
		//0: x
		//1: y
		//2: tier
		//3: ext (true/false)
		
		//EXT SET TO FALSE BY DEFAULT - DO NOT USE PAR OVEN UNLESS STARTING WITH AN EXT OVEN
		
		var i;
		var oven_num = instance_number(obj_piemachine);
		
		for (i = 0; i < oven_num; i += 1) {
			var o_inst = instance_find(obj_piemachine, i);
			ds_oven_tiers[# 0, i] = o_inst.x;
			ds_oven_tiers[# 1, i] = o_inst.y;
			ds_oven_tiers[# 2, i] = tier;
			ds_oven_tiers[# 3, i] = false;
			o_inst.oven_tier = tier;
			
			
			//show_debug_message("x " + string(ds_oven_tiers[# 0, i]));
			//show_debug_message("y " + string(ds_oven_tiers[# 1, i]));
			//show_debug_message("tier " + string(ds_oven_tiers[# 2, i]));
			//show_debug_message("ext " + string(ds_oven_tiers[# 3, i]));
			
			if (i != oven_num - 1) ds_grid_resize(ds_oven_tiers, ds_grid_width(ds_oven_tiers), ds_grid_height(ds_oven_tiers) + 1);
		}
		
		var ii = 0; repeat (obj_catalogue.upgraded_ovens) {
			//show_debug_message("assigned oven at x " + string(ds_oven_tiers[# 0, ii]) + " y " + string(ds_oven_tiers[# 1, ii]) + " ext");
			ds_oven_tiers[# 3, ii] = true;
			ii += 1;
		}
		
		
	} else { //pass tier variables to furniture
		
		#region //---------IF ROOM HAS BEEN EXTENDED RUN THIS ONCE
		if (room_extendus) {
			if (room == rm_main_ext) {
				//show_debug_message(" ");
				//show_debug_message(" ");
				//show_debug_message("pass variables to extended room");
				//REPLACES OLD XY POSITIONS WITH NEW ONES
				//TIER VARIABLES REMAIN INTACT
				
				
				
				//---------TABLE
				//show_debug_message("pass tier variables to tables");
				var i;
				var table_num = instance_number(obj_table);
				var table_grid_height = ds_grid_height(ds_table_tiers);
				
				//find tables and store their xy coordinates
		
				for (i = 0; i < table_num; i += 1) {
					//show_debug_message("//////////////////////////");
					//show_debug_message("i = " + string(i));
					//DONT WRITE ANYTHING ACCESSING THE DS GRID BEFORE RESIZING IT
					
					var t_inst = instance_find(obj_table, i);
					
					//no need to stop resizing at any point - ds grid is already initialized
					if (i >= table_grid_height) {
						ds_grid_resize(ds_table_tiers, ds_grid_width(ds_table_tiers), ds_grid_height(ds_table_tiers) + 1);
						//show_debug_message("resized grid");
						
						ds_table_tiers[# 2, i] = tier;
						t_inst.table_tier = tier;
						//show_debug_message("assigned default tier 1 to table");
						
					} else {
						//show_debug_message("still in old grid - assigned old tier");
						t_inst.table_tier = ds_table_tiers[# 2, i];
						
					}
					
					
					
					ds_table_tiers[# 0, i] = t_inst.x;
					ds_table_tiers[# 1, i] = t_inst.y;
					
					//show_debug_message(" ");
				}
				//show_debug_message("/////////////////////////")
				
				
				
		
				//---------OVEN
				var i;
				var oven_num = instance_number(par_oven);
				var oven_grid_height = ds_grid_height(ds_oven_tiers);
		
				for (i = 0; i < oven_num; i += 1) {
					//show_debug_message("i = " + string(i));
					//WRITE ALL DS GRID ACCESSING AFTER THE RESIZING
			
					//find machines and store their xy coordinates
					var o_inst = instance_find(par_oven, i);
					
					
					if (i >= oven_grid_height) {
						ds_grid_resize(ds_oven_tiers, ds_grid_width(ds_oven_tiers), ds_grid_height(ds_oven_tiers) + 1);
						//show_debug_message("resized grid");
						
						ds_oven_tiers[# 2, i] = tier;
						o_inst.oven_tier = tier;
						//show_debug_message("assigned default tier 1 to oven");
						
					} else {
						//show_debug_message("still in old grid - assigned old tier");
						o_inst.oven_tier = ds_oven_tiers[# 2, i];
						
					}
					
					ds_oven_tiers[# 0, i] = o_inst.x;
					ds_oven_tiers[# 1, i] = o_inst.y;
					//show_debug_message(" ");
				}
				
				//show_debug_message("/////////////////////////")
				//show_debug_message(" ");
			
			
			}
			
				room_extendus = false;
				exit;
		}
		#endregion room extendus
		
		
		
		//---------TABLE
		//show_debug_message("pass tier variables to tables");
		var i;
		var table_num = ds_grid_height(ds_table_tiers);
		
		for (i = 0; i < table_num; i += 1) {
			
			//check for table at xy position
			var px = ds_table_tiers[# 0, i];
			var py = ds_table_tiers[# 1, i];
			var t_inst = instance_position(px, py, obj_table);
			if (t_inst == noone) {
				show_debug_message("nothing here");
			}
			
			t_inst.table_tier = ds_table_tiers[# 2, i];
			
			//show_debug_message("gave back table tier  " + string(ds_table_tiers[# 2, i]) + "to " + string(t_inst));
		}
		
		//---------OVEN
		//show_debug_message("pass tier variables to ovens");
		var i;
		var oven_num = ds_grid_height(ds_oven_tiers);
		
		for (i = 0; i < oven_num; i += 1) {
			
			//check for pie machine at position
			var px = ds_oven_tiers[# 0, i];
			var py = ds_oven_tiers[# 1, i];
			var o_inst = instance_position(px, py, par_oven);
			
			
			if (o_inst == noone) show_debug_message("nothing here");
			
			
			var o_tier = ds_oven_tiers[# 2, i];
			
			with (o_inst) {
				oven_tier = o_tier;
				making_done = base_cooking_time - ((base_cooking_time/tiermaster.max_tier) * (o_tier - 1));
			}
			
			
			if (ds_oven_tiers[# 3, i] == true) {
				//show_debug_message("replace current instance with upgraded");
				var o_ext = instance_create_layer(o_inst.x, o_inst.y, "Instances", obj_piemachine_ext);
				var o_tier = ds_oven_tiers[# 2, i];
				
				with (o_ext) {
					oven_tier = o_tier;
					making_done = base_cooking_time - ((base_cooking_time/tiermaster.max_tier) * (o_tier - 1));
				}
				
				with (o_inst) instance_destroy();
				
			}
			
		}
	}
	
	has_tables = true;
} else if (!instance_exists(obj_table)) has_tables = false;

	

if (increase_tier) {
	increase_tier = false;
	
	with (obj_stats) {
		tier += 1;
		
		//SET TIER FOR ALL OBJECTS IN CREATE EVENT ONCE FINISHED DEBUGGING
		if (tier > other.max_tier) tier = 1;
	}
	
	switch (obj_stats.tier) {
		case 1:
			tier_ds = pie_master.ds_pie_t1;
			pielist_height = pies_t1.height;
			pie_sprite = spr_pies_t1;
			piecut_sprite = spr_pietocut1;
			break;
			
		case 2:
			tier_ds = pie_master.ds_pie_t2;
			pielist_height = pies_t2.height;
			pie_sprite = spr_pies_t2;
			piecut_sprite = spr_pietocut2;
			break;
			
		case 3:
			tier_ds = pie_master.ds_pie_t3;
			pielist_height = pies_t3.height;
			pie_sprite = spr_pies_t3;
			piecut_sprite = spr_pietocut3;
			break;
			
		case 4:
			tier_ds = pie_master.ds_pie_t4;
			pielist_height = pies_t4.height;
			pie_sprite = spr_pies_t4;
			piecut_sprite = spr_pietocut4;
			break;
			
			
	}
}


