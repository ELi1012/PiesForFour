event_inherited();

bed_range = 6;
bed_width = sprite_get_width(spr_bed) - (bed_range*2);
bed_height = sprite_get_height(spr_bed);


might_sleep = true;
sleeping = false;
sleep_option = false;
is_morning = false;

//draw black screen
sleep_duration = 2; //in seconds
alpha_inc = sleep_duration/10; //increment it by a tenth of the sleep duration
sleep_alpha = 1;
sleep_counter = 0;

gui_width = global.game_width;
gui_height = global.game_height;





