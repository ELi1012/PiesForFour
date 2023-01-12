///@desc chooses a pie slice from remaining pie
///@arg pie_left
///@arg customer_number
///@arg smallest_slice
///@arg array_possible_slices

//function only runs if customer is not the last one
//cannot have anything greater than smallest slice * (cluster_count - 1)

var pie_left = argument0;
var th_customer = argument1;
var random_slices = argument2; //replace with another array if making a flexible system
var smallest_slice = random_slices[0];
var s_length = array_length_1d(random_slices);
var slice_chosen = -1;

//DO NOT SET RANDOM SLICES TO ARGUMENT_COUNT - ANYTHING ABOVE 1 IF PUTTING SMALLEST SLICE AT THE LAST OF THE LIST
//if making an array to store possible slices put smallest slice first in case

//chooses between 1 and number of possible slices
pie_left = pie_left - (smallest_slice * (cluster_number - (th_customer + 1))); //quarter when customer = 2 and clustercount 4
slice_chosen = random_slices[irandom_range(0, s_length - 1)];

if (pie_left != 0) {
	
	// avoid sixteenths if cluster count is only 2
	if (cluster_number = 2) {
		while (slice_chosen > pie_left or slice_chosen = smallest_slice) {
			slice_chosen = random_slices[irandom_range(0, s_length - 1)];
			//show_debug_message("slice greater or equal to pie left");
		}
	}
	
	
	while (slice_chosen > pie_left) { //keep choosing a random slice if slice chosen is greater than or equal to pie left
		slice_chosen = random_slices[irandom_range(0, s_length - 1)];
		//show_debug_message("slice greater or equal to pie left");
	}
	
	
	
} else {
	slice_chosen = 0;
	show_debug_message("CUSTOMER GIVEN 0 PIE");
	
}

//show_debug_message(string(pie_left) + " pie left from before");
//show_debug_message(string(slice_chosen) + " slice chosen for customer (script)");

return slice_chosen;
