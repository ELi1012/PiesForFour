

view_width = 832;
view_height = 448;

window_scale = 2;

window_set_size(view_width * window_scale, view_height * window_scale);
alarm[0] = 1;

surface_resize(application_surface, view_width * window_scale, view_height * window_scale);



//CHANGE TO VIEWPORT WIDTH
global.game_width = view_width;
global.game_height = view_height;
//change inventory variables if changing global variables

global.camerax = 0;
global.cameray = 0;

display_set_gui_size(global.game_width, global.game_height);



following = obj_player;
distance = 5;

//main room
sect_one = 928;
room_yoffset = (view_height - room_height) / 2;


//renovating
cam_speed = 10;
move_camx = 0;
move_camy = 0;





