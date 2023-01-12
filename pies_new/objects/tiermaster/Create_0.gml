tier = 1;
max_tier = 4;
max_rating = 960; //original was 120 - should be divisible by any note value
base_rating = 3;


split_into = 5;
tier_inc = max_rating/split_into;

tier_ds = pie_master.ds_pie_t1;
pielist_height = pies_t1.height;
pie_sprite = spr_pies_t1;
piecut_sprite = spr_pietocut1;



increase_tier = false;

//cost to upgrade tiers
tier_upgrade = [0, 70, 140, 280, 42069];
tier_req = [0, tier_inc * 2, tier_inc * 3, tier_inc * 4, 42069];

//if index 4 on each array is not a number error will be given

