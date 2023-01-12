if (!editing_room) exit;
	

if (switch_furniture) draw_edit_room();
	
if (reno_new_notif) {
	reno_new_notif = false;
	reno_notif = true;
	//reset variables for notifications
	reno_notif_timer = 0;
}

if (reno_notif) {
	var notif_mx = 30;
	var notif_my = 30;
	
	reno_notif_timer += 1;
	
	var timer_current = reno_notif_timer/room_speed;
	var nd = 0.75; //fraction of max time to show notification at full opacity
	
	if (reno_notif_timer/room_speed >= reno_notif_max * nd) {
		//fade out
		var sfo_max = reno_notif_max * 0.75;
		var timer_current = reno_notif_timer/room_speed;
		var text_alpha = (timer_current - sfo_max)/((1 - nd) * sfo_max);
		
		draw_set_alpha(1 - text_alpha);
	}
	
	if (reno_notif_timer/room_speed >= reno_notif_max) {
		reno_notif = false;
		reno_notif_timer = 0;
	}
	
	draw_text(notif_mx, notif_my, reno_notif_string);
	draw_set_alpha(1);
	
}
	
	
	
