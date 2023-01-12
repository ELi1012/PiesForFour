
event_inherited();

bbox_set = false;



w_spd = 2;
n_spd = 3;
r_spd = 6;
spd	  = w_spd;

moveX = 0;
moveY = 0;

move_to_x = true;

spawn_x = -1;
spawn_y = -1;

//SET BY SPAWNER DURING SPAWN EVENT
cluster = -1; //cluster # group in room
cluster_id = -1; //instance id of cluster
cluster_number = -1; //how many in cluster
customer_id = -1; //which customer in the cluster
leftmost_bbox = -1;
rightmost_bbox = -1;
is_leader = false;
pie_slice = -1; //100% is 240
c_slices_array = -1;

//SET TABLE SPOT
table_spot = -1;
top_of_table = false; //checks if customer is seated at the top of the table


c_box_width = bbox_right - bbox_left;
c_box_height = bbox_bottom - bbox_top;

//customer_objectindex = object_index;
collision_timer = 0;
collision_max = 5;
recent_collision_max = 1;
disable_collision = true;
goal_timer = 0;
goal_max = 10;
destination_x = 0;
destination_y = 0;
previous_state = 0;
//SET DISABLE COLLISION TO TRUE BY DEFAULT UNTIL CLEAR OF COLLISION OBJECT



//drawing
x_frame = 1;
y_frame = 0;
arrow_frame = 0;
arrow_width = 64;
arrow_height = 32;

x_offset = -1;
y_offset = -1;
character_sprite = -1;

frame_size = 64;

random_timer = 0;
random_anim = 5; //how many seconds pass until next random animation check
play_anim = false;
anim_to_play = spr_customer_anim1;
random_anim_len = sprite_get_number(anim_to_play);
r_frame = 0;
r_spd = 15;

non_idle_anim = [spr_customer_random1, spr_customer_random2];
non_idle_len = array_length_1d(non_idle_anim);


#region LINING

lining_x = 192;
lining_y = obj_spawn.y;
lineup_range = 30;
line_up_id = -1;


man_selected = false;
set_table = -1;
table_selected = false;


#endregion

#region ARRIVING
table_left_x = -1;
table_left_y = -1;

table_right_x = -1;
table_right_y = -1;

table_width = obj_table.table_width;
table_height = obj_table.table_height;

seated = false;
cluster_selected = false;
table_occupied = false;
move_to_table = false;
all_seated = false;

pie_wanted = -1;

dir = -1;

#endregion

#region ORDERING
c_timer = 0;

base_time = 3; //in minutes

var subtract_seconds = 10; //how many seconds to subtract for each subsequent day
var given_time = base_time - (daycycle.day * (subtract_seconds/60))


given_time = clamp(given_time, 1/2, 15);

time_given = given_time * 60; //in seconds
impatience = 0;
impatience_limit = (2/3) * time_given; //how long the customer waits before impatience penalties
impatience_penalty = 0.25 * time_given; //percentage of base time to subtract from total time


angered = false;
served = false;
table_clicked = false;
order_taken = false;
pie_given = -1;

checklist_assigned = false;

#endregion




#region EATING
eating_timer = 0;
eating_max = 1 * 60;
eating_sprite = spr_customer_anim1;
eating_framenum = sprite_get_number(eating_sprite);
eating_frame = 0;







#endregion EATING




#region LEAVING
near_spawn = false;
remove_from_checklist = false;


#endregion



enum c_states {
	lining,
	arriving,
	ordering,
	waiting,
	eating,
	leaving
	
}

state = c_states.lining;



