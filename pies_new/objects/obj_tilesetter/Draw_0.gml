// get colour to blend background with
// only works if background id is given as opposed to reference stored in bg_layer_outside 

var c;
with (daycycle) {
	// if darkness is close to 0, c should approach c_white (no blending)
	c = merge_color(c_white, light_colour, darkness);
}

//draw ground
layer_x(bg_layer_outside, (global.camerax * 0.9));
layer_y(bg_layer_outside, outsidey - 90);
layer_background_blend(bg_id_outside, c);	

//draw cloud layer
layer_x(bg_layer_clouds, (daycycle.hours * 5) + (global.camerax * 0.9));
layer_y(bg_layer_clouds, outsidey);
layer_background_blend(bg_id_clouds, c);


//draw other things



//draw wall
draw_sprite(diningroom_wall, bg_tier, 0, 0);

//draw floor
draw_sprite(diningroom_floor, bg_tier, 0, floor_y);


//draw kitchen
draw_sprite(kitchen_wall, bg_tier_kitchen, kitchen_x, 0);
draw_sprite(kitchen_floor, bg_tier_kitchen, kitchen_x, floor_y);

