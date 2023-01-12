/*

//no longer necessary to restore variables - only obj catalogue changes them during furniture renovation

if (room == rm_main or room == rm_main_ext) {
	//show_debug_message("storing in end room");
	
	if (ds_exists(ds_table_tiers, ds_type_grid)) {
		//store table tier in ds grid
		var i;
		var table_num = ds_grid_height(ds_table_tiers);
		
		for (i = 0; i < table_num; i += 1) {
			var t_inst = ds_table_tiers[# 0, i];
			ds_table_tiers[# 1, i] = t_inst.table_tier;
			//show_debug_message("assigned tier  " + string(ds_table_tiers[# 1, i]) + "to " + string(t_inst));
		}
	}
	/*
	if (ds_exists(ds_oven_tiers, ds_type_grid)) {
		
		//store oven tier in ds grid
		var i;
		var oven_num = ds_grid_height(ds_oven_tiers);
		
		for (i = 0; i < oven_num; i += 1) {
			
			var px = ds_oven_tiers[# 0, i];
			var py = ds_oven_tiers[# 1, i];
			var o_inst = instance_position(px, py, obj_piemachine);
			if (o_inst == noone) {
				show_debug_message("nothing here");
				exit;
			}
			
			ds_oven_tiers[# 2, i] = o_inst.oven_tier;
			
			o_inst.oven_tier = ds_oven_tiers[# 2, i];
			
			show_debug_message("assigned tier  " + string(ds_oven_tiers[# 2, i]) + "to " + string(o_inst));
		}
		
		///////////////
		//store oven tier in ds grid
		var i;
		var oven_num = ds_grid_height(ds_oven_tiers);
		
		for (i = 0; i < oven_num; i += 1) {
			var o_inst = ds_oven_tiers[# 0, i];
			
			if (ds_oven_tiers[# 2, i] == -1) ds_oven_tiers[# 1, i] = o_inst.oven_tier;
			else ds_oven_tiers[# 2, i] = o_inst.oven_tier;
			show_debug_message("assigned tier  " + string(ds_oven_tiers[# 1, i]) + "to " + string(o_inst));
		}
		////////////////////
	//}
	
}