if(draw_daylight) {
	var c = light_colour;
	draw_set_alpha(darkness);
	draw_rectangle_color(0, 0, guiWidth, guiHeight, c, c, c, c, false);
	draw_set_alpha(1);
	
}

//draws computer glow
if (instance_exists(obj_computer)) with (obj_computer) event_perform(ev_alarm, 0);








//draw_text_color(10, 50, string(seconds), c, c, c, c, 1);
//draw_text_color(10, 100, string(minutes), c, c, c, c, 1);
//draw_text(10, 300, string(hours));






