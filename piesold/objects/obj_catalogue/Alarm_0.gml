with (obj_computer) {
	
	visible = true;
	using_computer = true;
	mouse_scroll = other.comp_scroll;
		
	page_change = true;
	page_destination = other.cur_page;
	current_website = website.reno;
		
}

with (obj_player) {
	x = other.px;
	y = other.py;
}

done_renovating = false;
//dont set using escape back to false - computer is still using it


	
daycycle.visible = true;