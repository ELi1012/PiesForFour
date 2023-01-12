///@description create_pie_type
///@arg pie_type
///@arg cost
///@arg pie_tier
///@arg name
///@arg description
function create_pie_type(argument0, argument1, argument2, argument3) {

	var pie_type = argument0;
	var cost = argument1;
	var pie_tier = argument2;
	var pie_name = argument3;

	var argNum = 3;
	var height = ds_grid_height(pie_tier);

	if (pie_tier[# 0, 0] != -1) {
		ds_grid_resize(pie_tier, argNum, height + 1);
		height += 1;
	}

	var yy = height - 1;

	switch (pie_tier) {
		case ds_pie_t1:
			ds_pie_t1[# 0, yy] = pie_type;
			ds_pie_t1[# 1, yy] = cost;
			ds_pie_t1[# 2, yy] = pie_name
			break;
		
		case ds_pie_t2:
			ds_pie_t2[# 0, yy] = pie_type;
			ds_pie_t2[# 1, yy] = cost;
			ds_pie_t2[# 2, yy] = pie_name
			break;
		
		case ds_pie_t3:
			ds_pie_t3[# 0, yy] = pie_type;
			ds_pie_t3[# 1, yy] = cost;
			ds_pie_t3[# 2, yy] = pie_name
			break;
	
		case ds_pie_t4:
			ds_pie_t4[# 0, yy] = pie_type;
			ds_pie_t4[# 1, yy] = cost;
			ds_pie_t4[# 2, yy] = pie_name;
	
	}





}
