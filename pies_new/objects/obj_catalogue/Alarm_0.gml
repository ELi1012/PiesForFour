/// @description pass variables back to computer

with (obj_computer) {
	
	// this runs after the create event for obj_computer and before the step event
	visible = true;
	using_computer = true;
	mouse_scroll = other.mouse_scroll;
		
	page_change(current_page, other.current_page_function);
	draw_page_function = other.current_page_draw_function;
		
}

with (obj_player) {
	x = other.px;
	y = other.py;
}


//dont set using escape back to false - computer is still using it


	
daycycle.visible = true;