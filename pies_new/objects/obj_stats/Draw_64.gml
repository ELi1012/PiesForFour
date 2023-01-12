
//draw_text(x_margin, gui_height - y_margin, string(piebucks) + " piebucks");
//draw_text(x_margin, gui_height - (y_margin*2), string(rating) + " rating");
//draw_text(x_margin, gui_height - (y_margin*3), string(day_rating) + " day rating");

if (new_notif) {
	new_notif = false;
	notif = true;
	notif_timer = 0;
}

if (notif) {
	notif_timer += 1;
	
	var timer_current = notif_timer/room_speed;
	var nd = 0.75; //fraction of max time to show notification at full opacity
	
	if (timer_current >= notif_max * nd) {
		//fade out
		var sfo_max = notif_max * 0.75;
		var text_alpha = (timer_current - sfo_max)/((1 - nd) * sfo_max);
		
		draw_set_alpha(1 - text_alpha);
	}
	
	if (timer_current >= notif_max) {
		notif = false;
		notif_timer = 0;
	}
	
	var str_len = string_width(string(notif_string));
	
	draw_text(x_margin - str_len, y_margin, notif_string);
	draw_set_alpha(1);
	
}