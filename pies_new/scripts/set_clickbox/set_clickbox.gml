function set_clickbox(_x, _y, _icon_width, _icon_height, _optional = cm_background, _redirect_to = obj_computer.current_page) {
	
	//if page direct is inapplicable it defaults to homepage

	var inst = instance_create_layer(_x, _y, clickbox_depth, obj_clickbox);
	var cwidth = sprite_get_width(spr_clickbox);
	
	with (inst) {
		initial_y = _y;
		image_xscale = _icon_width/cwidth;
		image_yscale = _icon_height/cwidth;
		optional_variable = _optional;
		page_redirect = _redirect_to;
	}

	return inst;


}
