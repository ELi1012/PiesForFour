

bg_tier = obj_stats.dining_bg;
bg_tier_kitchen = obj_stats.kitchen_bg;

bg_layer_outside = layer_get_id("background_grass");
bg_layer_clouds = layer_get_id("background_clouds");

bg_id_outside = layer_background_get_id("background_grass"); // has to be separately referenced
bg_id_clouds = layer_background_get_id("background_clouds");

bg_instance = layer_get_id("bg_instance");



//random animations
//how often to check whether to make new animations in terms of hours from daycycle
an_biker = 1;
an_customer = 1;
an_car = 0.5;


if (obj_stats.room_extended == false) {
	kitchen_x = 960;
	floor_y = 144;
	
	diningroom_wall = spr_bg_wall;
	kitchen_wall = spr_k_wall;
	
	diningroom_floor = spr_bg_floor;
	kitchen_floor = spr_k_floor;
	
	
	an_by = 50;
	an_ccy = 128;
	an_cary = 40;
	
	outsidey = 0;
	
	ext_marginy = 0;
	
	
} else if (obj_stats.room_extended == true) {
	kitchen_x = 1024;
	floor_y = 256;
	
	diningroom_wall = spr_bg_wall_ext;
	kitchen_wall = spr_k_wall_ext;
	
	diningroom_floor = spr_bg_floor_ext;
	kitchen_floor = spr_k_floor_ext;
	
	
	an_by = 192;
	an_ccy = 254;
	an_cary = 100;
	
	outsidey = 70;
	ext_marginy = 20;
	
}

var fy = an_ccy;


var bb = instance_create_layer(100, fy - 5 - ext_marginy, bg_instance, par_bg_furniture);
bb.spr_type = spr_bench;

var bb = instance_create_layer(170, fy + 5 - ext_marginy, bg_instance, par_bg_furniture);
bb.spr_type = spr_firehydrant;

var bb = instance_create_layer(400, fy - ext_marginy, bg_instance, obj_bg_tree);
bb.spr_type = spr_bush;
bb.frame_len = sprite_get_number(spr_bush);

var bb = instance_create_layer(300, fy - 10 - ext_marginy, bg_instance, obj_bg_tree);
bb.spr_type = spr_tree1;
bb.frame_len = sprite_get_number(spr_tree1);

var bb = instance_create_layer(500, fy - 20 - ext_marginy, bg_instance, obj_bg_tree);
bb.spr_type = spr_tree2;
bb.frame_len = sprite_get_number(spr_tree2);

var bb = instance_create_layer(800, fy + 10 - ext_marginy, bg_instance, obj_bg_tree);
bb.spr_type = spr_tree1;
bb.frame_len = sprite_get_number(spr_tree1);





