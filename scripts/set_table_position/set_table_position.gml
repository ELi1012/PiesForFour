///@desc set_table_position
///@arg customer_being_created
///@arg cluster_number
//being accessed from customer object

var dd = argument0;
var count = argument1;

switch (dd) { //sets table position depending on order that it created in
	case 0: //first spawned - set to left
		table_spot = table_pos.table_left;
		break;
					
	case 1: //set to right
		table_spot = table_pos.table_right;
		break;
	
	case 2: //set to middle if cluster count = 3
		if (count = 3) {
			table_spot = table_pos.table_middle;
		} else {
			table_spot = table_pos.table_topleft
		}
		break;
		
	case 3: //fourth customer
		table_spot = table_pos.table_topright;
		break;
		
	default:
		table_spot = table_pos.table_left;
		break;
}