/// @desc what to draw over daycycle
// runs inside daycycle draw event

function draw_glow(cx, cy) {
	
	if (daycycle.darkness > 0.7) {
	
		// cx and cy denote camera position
		// highlight light if mouse is hovering above it or is lit
	
		if (mouse_above or light_on) {
			draw_sprite_ext(spr_light, light_tier, x - cx, y - cy, 1, 1, 0, c_yellow, 1);
			if (mouse_above) mouse_above = false;
		}
	
		// draw glow
		if (light_on) {
			var glow_sprite = spr_player_glow;
			var pscale = 10;
			var rscale = 1; if (irandom(60) == 60) rscale = 1.01;
			var gw = sprite_get_width(glow_sprite);
			var gh = sprite_get_height(glow_sprite);
		
			gx = x - (gw * (pscale * rscale)/2);
			gy = y - (gh * (pscale * rscale)/2)/3;
			draw_sprite_ext(glow_sprite, 0, gx - cx, gy - cy, 
							pscale*rscale, pscale*rscale, 0, light_colour, 1);
		}
	}
}
