


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


