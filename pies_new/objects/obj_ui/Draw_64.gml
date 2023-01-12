
draw_sprite(spr_stats, 0, st_x, st_y);
draw_set_color(c_black);
draw_text(st_text_x, st_text_y, "Pie bucks: " + string(obj_stats.piebucks));



var inc = tiermaster.tier_inc;
var rating = obj_stats.rating + obj_stats.day_rating;
var rating_string = " ";

if (rating < tiermaster.max_rating) {
	
	if (rating < 0) rating = 0;
	
	var next_goal = (rating div inc) + 1;
	var points_needed = inc - round(rating mod inc);
	
	
	rating_string = string(points_needed) + " points needed to get to " + string(next_goal) + " stars";
	
} else rating_string = "Maximum rating achieved";

draw_text(st_text_x, st_text_y + 20, rating_string);

draw_set_color(c_white);



//draw clock
var hand_rot = (daycycle.hours/12) * 360;

draw_sprite(spr_clock, 0, clock_x, clock_y);
draw_sprite_ext(spr_clock_hand, 0, clock_x, clock_y, 1, 1, -hand_rot, c_white, 1);



if (global.game_pause) {
	draw_set_alpha(0.8);
	draw_set_color(c_black);
	draw_rectangle(0, 0, gui_width, gui_height, false)
	draw_set_color(c_white);
	draw_set_alpha(1);
	
	if (!pause_overlay) draw_sprite(spr_game_paused, 0, draw_pausex, draw_pausey);
	else draw_sprite_ext(spr_game_paused, 0, draw_pausex, draw_pausey, 1, 1, 0, c_gray, 1);
	
	if (pressed_exit) {
		draw_sprite(spr_exit_confirm, 0, ce_x, ce_y);
		
	} else if (view_tutorial) {
		
		draw_sprite(spr_tutorial_back, 0, vt_backx, vt_backy);
		draw_sprite(spr_tutorial, vt_inc, vt_tx, vt_ty);
	}
	
}