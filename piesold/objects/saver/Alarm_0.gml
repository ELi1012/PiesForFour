//save data to a string
with (obj_stats) event_perform(ev_alarm, 0);
var _string = json_encode(save_data);
save_string_to_file("savefile.dingus", _string);