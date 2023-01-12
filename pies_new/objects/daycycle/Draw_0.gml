// setup
var cam = view;
var cx = camera_get_view_x(cam);
var cy = camera_get_view_y(cam);
var w = camera_get_view_width(cam);
var h = camera_get_view_height(cam);


surface = surface_create_safe(surface, w, h);
surface_set_target(surface);

// ALL DRAWING TO THE SURFACE IS DONE FROM THE SURFACE ORIGIN (0, 0) nOT ROOM ORIGIN
// ADJUST SPRITE AS NECESSARY



//---------- draw daycycle overlay
if(draw_daylight) {
	var c = light_colour;
	draw_set_alpha(darkness);
	
	// draw lighting
	draw_rectangle_color(0, 0, w, h, c, c, c, c, false);
	
	draw_set_alpha(1);
}




#region make objects glow


gpu_set_blendmode(bm_subtract);


// DRAW GLOW
// for any object that needs to stand out during nighttime

// fade in/out glow
// fade in if light opacity is lesser than current darkness
// will fade in in one second
if (darkness > 0.6 and glow_opacity < max_darkness) {
	glow_opacity += max_darkness * (1/room_speed);
}

else if (darkness <= 0.6 and glow_opacity > 0) {
	glow_opacity -= max_darkness * (1/room_speed);
	if (glow_opacity < 0) glow_opacity = 0;
}



if (darkness > 0.6) {
	// loop through objects in ds grid and perform their daycycle-specific draw functions
	
	var dd = ds_glow;
	var len = ds_grid_height(dd);
	for (var i = 0; i < len; i++) {
		var inst = dd[# 0, i];
		if (instance_exists(inst)) {
			// use with (inst) instead of inst.draw_glow
			// in case there are multiple objects (eg. lights)
				// cx, cy are position of camera in room
				// necessary if drawing to the surface
				// drawing coordinates are given relative to position of surface in room
			with (inst) {
				
				draw_glow(cx, cy);
				
			}
		}
	}
	
	// highlight light if mouse is over it by changing mouse_above = true
	if (place_meeting(mouse_x, mouse_y, obj_light)) {
		var inst = instance_place(mouse_x, mouse_y, obj_light);
		if (inst != noone) {
			with (inst) {
				mouse_above = true;
				if (mouse_check_button_pressed(mb_left)) light_on = !light_on;
			}
		}
	}
}

gpu_set_blendmode(bm_normal);

surface_reset_target();
draw_surface(surface, cx, cy);

#endregion


