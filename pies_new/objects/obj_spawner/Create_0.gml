//CUSTOMER SPAWNING
lined_up = 0;
cluster_count = 0;
cluster_count_max = 4;
whole_pie = 240;
leftmost = room_width;
eating_framenum = sprite_get_number(spr_customer_anim1);


//ALWAYS PUT SMALLEST VALUE AT POSITION 0
array_possible_slices[4] = whole_pie/1;
array_possible_slices[3] = whole_pie/2;
array_possible_slices[2] = whole_pie/4;
array_possible_slices[1] = whole_pie/8;
array_possible_slices[0] = whole_pie/16;


//ALWAYS CREATE SPAWNER AFTER DAYCYCLE
spawn_these = 0; //spawn x amount of customers throughout the day
endofday = false;
not_serving = false;
intint = 0;


var sf_rating = obj_stats.rating;
var sf_rating_div = sf_rating div tiermaster.tier_inc

switch (sf_rating_div) {
	
	case 0:
		spawn_frequency = [2, 3, 1, 4, 2];
		break;
	
	case 1:
		spawn_frequency = [3, 4, 2, 5, 2];
		break;
	
	case 2:
		spawn_frequency = [5, 7, 3, 8, 4];
		break;
	
	default:
		spawn_frequency = [5, 10, 4, 13, 6];
		break;
	
}








done_spawned = false;
spawn_number = 0;
spawn_random = 1; //sets max number of possible random groups spawned with each toggle
spawn_count = 1;
pp = -1;

//LINING UP
total_spawned = 0; //total amount of clusters spawned
lineline = 192;
//lineline_group = 5;
//lineline_og = 192;
//lineline_dist = 100;


spawn_clusters = false;

pstart = spawn_phase.fifth;
pend = 0;












