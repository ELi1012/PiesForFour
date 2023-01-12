
var spr_pp = tiermaster.pie_sprite;
var spr_pplen = 4;
var pie_xx = pie_type mod spr_pplen;
var pie_yy = pie_type div spr_pplen;

if (!has_been_cut) {
	draw_sprite_part(spr_pp, 0, pie_xx * pie_size, pie_yy * pie_size, pie_size, pie_size, x, y);
	
} else {
	draw_sprite_part(spr_pp, 1, pie_xx * pie_size, pie_yy * pie_size, pie_size, pie_size, x, y);
	
}
	


//draw_rectangle(bbox_right, bbox_top, bbox_left, bbox_bottom, true);