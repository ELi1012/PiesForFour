/// @desc draw over daycycle

function draw_glow(cx, cy) {
	
	var xx, yy, pscale, gx, gy, gw, gh, glow_sprite;
	glow_sprite = spr_player_glow;
	gw = sprite_get_width(glow_sprite);
	gh = sprite_get_height(glow_sprite);
	pscale = 2;
	
	xx = x - x_offset + sprite_get_width(mask_index)/2;
	yy = y - y_offset + sprite_get_height(mask_index)/2;
	gx = xx - (gw*pscale)/2;
	gy = yy - (gh*pscale)/2;
	
	draw_sprite_ext(glow_sprite, 0, gx - cx, gy - cy, pscale, pscale, 0, c_yellow, daycycle.glow_opacity);
	
}
