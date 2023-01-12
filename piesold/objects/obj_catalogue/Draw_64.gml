if (!renovating) exit;
	
	
	if (reroom_confirm_purchase) {
		if (show_icon_table) {
			var reno_confirm_icon = spr_table;
			var rrc_cost = table_upgrade[rrc_icon_tier - 1];
			
		} else if (show_icon_oven) {
			var reno_confirm_icon = spr_piemachine;
			var rrc_cost = oven_upgrade[rrc_icon_tier - 1];
			
		} else {
			var reno_confirm_icon = spr_piemachine;
			var rrc_cost = "your soul";
		}
		
		draw_sprite(spr_reno_confirm, 0, reroom_confirmx, reroom_confirmy);
		
		draw_sprite_ext(reno_confirm_icon, rrc_icon_tier, rrc_icon_x, rrc_icon_y, 2, 2, 0, c_white, 1)
		
		draw_set_font(fnt_beeg);
		draw_set_color(c_black);
		
		draw_text(rrc_text_x, rrc_text_y, "Cost: " + string(rrc_cost));
		draw_set_font(fnt_default);
		draw_set_color(c_white);
		
		
	}
	
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
	
	
	
