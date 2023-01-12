
var piex = x + mmiddlex - pie_middle;
var piey = y - mmiddley - pie_middle + 10;
var spr_pp = tiermaster.pie_sprite;
var spr_pplen = 4;


draw_sprite(spr_piemachine, oven_tier - 1, x, y);


if (mstate = mstate_choosing) {
	var pie_xx = pie_scroll mod spr_pplen;
	var pie_yy = pie_scroll div spr_pplen;
	
	draw_sprite_part(spr_pp, 0, pie_xx*pie_size, pie_yy*pie_size, pie_size, pie_size, 
		piex, piey);
	
}

if (mstate = mstate_baking) {
	var pie_xx = pie_making mod spr_pplen;
	var pie_yy = pie_making div spr_pplen;
	
	draw_sprite_part(spr_pp, 0, pie_xx*pie_size, pie_yy*pie_size, pie_size, pie_size, 
		piex, piey);
	
	draw_sprite(spr_glow, 0, piex, piey + 20);
	
}






