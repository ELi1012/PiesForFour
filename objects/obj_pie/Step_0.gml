//CONSIDER MAKING THE MASK INDEX BIG WHEN GIVING TO CUSTOMER

if (position_meeting(obj_player.x, obj_player.y, id) and keyboard_check_pressed(vk_space) and !is_selected) {
	obj_pie.is_selected = false;
	is_selected = true;
	visible = false;
	draw_using_depth = false;
	
	obj_player.pie_selected = other.id;
	
} else if (is_selected) {
	
	//place on pie_cutter if clicked on it
	if (place_meeting(x, y, obj_piecutter) and keyboard_check_pressed(vk_space)) {
		var trashing = false;
		with (obj_garbage) if (instance_place(x, y, other.id)) trashing = true;
		if (!trashing) {
			
			if (obj_piecutter.cutting_pie = false and !has_been_cut) {
		
				is_selected = false;
				has_been_cut = true;
				daycycle.draw_daylight = false;
				
				//pass own variables to piecutter
				with (obj_piecutter) {
					spr_pie = tiermaster.piecut_sprite;
					spr_pie_index = other.pie_type;
					cutting_pie = true;
					inst_pie = other.id;
					visible = true;
		
				}
			}
		}
	}
	
	//give to customer if clicked on table
	//sets table leader pie_given variable to pie inst
	else if (place_meeting(x, y, obj_table) and keyboard_check_pressed(vk_space)) {
		 var table_inst = instance_place(x, y, obj_table);
		 
		 if (table_inst.claimed) {
			 var linst = table_inst.leader_inst;
			 linst.pie_given = id;
			 
		 }
		
	}
	
	//delete instance if put in garbage
	if (place_meeting(x, y, obj_garbage) and keyboard_check_pressed(vk_space)) {
		if (pie_trash) {
			obj_player.pie_selected = -1;
			instance_destroy();
		}
		pie_trash = true;
	}
	
	if (pie_trash) {
		trashed_timer += 1;
		if (trashed_timer/room_speed >= trashed_max) {
			trashed_timer = 0;
			pie_trash = false;
		}
		
	}
	
		
	//deselect if not colliding with anything
	if (keyboard_check_pressed(vk_space)) {
		pie_colliding = false;
		near_oven = false;
		
		with (obj_collision) {
			//if any instance of a pie is colliding with obj collision pie colliding is always set to true
			if (instance_place(x, y, other.id)){
				if (id != obj_player.id) other.pie_colliding = true;
				
			}
		}
		
		if (!pie_colliding) {
			is_selected = false;
		}
	}
	
	if (!is_selected) {
		obj_player.pie_selected = -1;
		visible = true;
		draw_using_depth = true;
	}
	
}





