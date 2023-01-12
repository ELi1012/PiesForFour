



//update minutes and hours according to what is set in the create event for seconds
minutes = seconds/60;
hours	= minutes/60;

event_perform(ev_step, 0);


if (room != rm_attic and !obj_catalogue.editing_room) {
	dday	= 24/(time_in_day/60);
} else dday = 1;

if (layer_exists("daycycle_instance") and !instance_exists(daycycle)) layer_add_instance("daycycle_instance", id);