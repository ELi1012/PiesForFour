if (global.game_pause) exit;


#region move checklist
if (keyboard_check_pressed(ord("E"))) {
	in_view = !in_view;
	move_checklist = true;
	
	
}

//is relative to the room
if (in_view) goal_x = x_inview;
else goal_x = x_outview;


if (move_checklist) {
	x_pos = lerp(x_pos, goal_x, 0.1);
	
	if (abs(x_pos - goal_x) < 1) {
		move_checklist = false;
	}
}

#endregion move checklist

mousex = device_mouse_x_to_gui(0);
mousey = device_mouse_y_to_gui(0);

orderheight = ds_grid_height(ds_orders);



if (point_in_rectangle(mousex, mousey, x_pos, y_pos, x_pos + list_width, y_pos + list_height) 
	and mouse_check_button_pressed(mb_left) and tables_ordered > 0) {
	//show_debug_message(" ");
	//show_debug_message("grid height is " + string(orderheight));
	
	
	if (list_inc + 1 < orderheight) {
			
		//show_debug_message(string(list_inc) + " below grid height");
		list_inc += 1;
		
		
	} else {
		
		//show_debug_message("grid height is " + string(orderheight));
		//show_debug_message(string(list_inc) + " reset to 0");
		list_inc = 0;

		
	}
	
	//show_debug_message("list inc " + string(list_inc));
	
}





















