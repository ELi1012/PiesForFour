

if (!using_computer) exit;

var s = 1;
display_set_gui_size(gui_width, gui_height);

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

	

	// draw function
draw_page_function(mx, my);




	// draw browser window
if (current_page != desktop_page) {
	draw_sprite(cm_ie_window, 0, screen_x, screen_y);
	
		// draw scroll bar
	var h = sprite_get_height(spr_scroll_bar);
	var dist = scroll_bar_window_height - h;		// total distance top of bar can reach
	var fraction = mouse_scroll/(page_height - cm_window_height)		// what fraction of page has been scrolled through
	
	draw_sprite(spr_scroll_bar, 0, scroll_bar_x, scroll_bar_y + (fraction * dist));
}


if (instance_exists(obj_clickbox)) {
	var w = sprite_get_width(spr_clickbox);
	with (obj_clickbox) {
		draw_rectangle(x, y, x + (w*image_xscale), y + (w*image_yscale), true);
	}
}




draw_sprite(cm_lower_taskbar, 0, cm_tb_x, cm_tb_y);



//-------- draw outside of computer screen
draw_sprite_ext(cm_outsidescreen, 0, 0, 0, s, s, 0, c_white, 1);

//draw cat
var clen;
if (cat_blink) clen = cat_len + cat_extra;
else clen = cat_len;

frame += frame_spd;
blink_timer += 1;

if (frame/room_speed >= clen) {
	frame = 0;
	if (cat_blink) cat_blink = false;
	else {
		if (blink_timer/room_speed >= 5) {
			blink_timer = 0;
			var c = choose(1, 2);
			if (c == 1) cat_blink = true;
		}
	}
}

draw_sprite_ext(spr_luckycat, floor(frame/room_speed), catx, caty, s, s, 0, c_white, 1);


//draw daycycle
var c = daycycle.light_colour;
var dark = daycycle.darkness;


var x2 = (screen_x + screen_width);		// right of computer screen
var y1 = screen_y;						// top of computer screen
var y2 = screen_y + screen_height;		// bottom of computer screen

draw_set_alpha(dark);

////top rectangle
draw_rectangle_color(0, 0, gui_width, y1, c, c, c, c, false);
////bottom rectangle
draw_rectangle_color(0, y2, gui_width, gui_height, c, c, c, c, false);
////left rectangle
draw_rectangle_color(0, y1 + 1, screen_x, y2 - 1, c, c, c, c, false);
////right rectangle
draw_rectangle_color(x2, y1 + 1, gui_width, y2 - 1, c, c, c, c, false);



draw_set_alpha(1);




if (cm_new_notif) {
	cm_new_notif = false;
	cm_notif = true;
	//reset variables for notifications
	cm_notif_timer = 0;
}

if (cm_notif) {
	var notif_mx = 30;
	var notif_my = 30;
	
	cm_notif_timer += 1;
	
	var timer_current = cm_notif_timer/room_speed;
	var nd = 0.75; //fraction of max time to show notification at full opacity
	
	if (timer_current >= cm_notif_max * nd) {
		//fade out
		var sfo_max = cm_notif_max * 0.75;
		var text_alpha = (timer_current - sfo_max)/((1 - nd) * sfo_max);
		
		draw_set_alpha(1 - text_alpha);
	}
	
	if (cm_notif_timer/room_speed >= cm_notif_max) {
		cm_notif = false;
		cm_notif_timer = 0;
	}
	
	draw_text(notif_mx, notif_my, cm_notif_string);
	draw_set_alpha(1);
	
}






// reset gui
display_set_gui_size(gui_width, gui_height);