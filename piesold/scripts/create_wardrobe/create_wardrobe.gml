///@description create_clothing_type
///@arg name
///@arg body_part
///@arg cost
function create_wardrobe(argument0, argument1, argument2, argument3) {

	var cloth_id = argument0;
	var type = argument1;
	var cost = argument2;
	var name = argument3;


	switch (type) {
		case cloth_type.head:
			var height = ds_grid_height(ds_clothing_head);
			if (ds_clothing_head[# 0, 0] != -1) {
				ds_grid_resize(ds_clothing_head, ds_grid_width(ds_clothing_head), height + 1);
				height += 1;
			}
		
			var yy = height - 1;
			ds_clothing_head[# 0, yy] = cloth_id;
			ds_clothing_head[# 1, yy] = type;
			ds_clothing_head[# 2, yy] = cost;
			ds_clothing_head[# 3, yy] = name;
			ds_clothing_head[# 4, yy] = false;
			break;
		
		case cloth_type.body:
			var height = ds_grid_height(ds_clothing_body);
			if (ds_clothing_body[# 0, 0] != -1) {
				ds_grid_resize(ds_clothing_body, ds_grid_width(ds_clothing_body), height + 1);
				height += 1;
			}
		
			var yy = height - 1;
			ds_clothing_body[# 0, yy] = cloth_id;
			ds_clothing_body[# 1, yy] = type;
			ds_clothing_body[# 2, yy] = cost;
			ds_clothing_body[# 3, yy] = name;
			ds_clothing_body[# 4, yy] = false;
			break;
		
		case cloth_type.pill:
			var height = ds_grid_height(ds_clothing_pill);
			if (ds_clothing_pill[# 0, 0] != -1) {
				ds_grid_resize(ds_clothing_pill, ds_grid_width(ds_clothing_pill), height + 1);
				height += 1;
			}
		
			var yy = height - 1;
			ds_clothing_pill[# 0, yy] = cloth_id;
			ds_clothing_pill[# 1, yy] = type;
			ds_clothing_pill[# 2, yy] = cost;
			ds_clothing_pill[# 3, yy] = name;
			ds_clothing_pill[# 4, yy] = false;
			break;
		
	}





}
