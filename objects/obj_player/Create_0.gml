
event_inherited();



w_spd = 2;
n_spd = 5;
r_spd = 8;
spd = n_spd;

w_spd = n_spd;

x_frame = 1;
y_frame = 0;

x_offset = sprite_get_xoffset(mask_index);
y_offset = sprite_get_yoffset(mask_index);

piex_offset = 16;
piey_offset = 0;

pie_selected = -1;

moveX = 0;
moveY = 0;

frame = 0;
frame_num = 3;
frameSpd = 15;

//clothing
//setting clothing one step after creation ensures that clothes stored in save data are put on
alarm[0] = 1;

spr_pill = spr_player;
spr_hat = -1;
spr_blothes = -1;

pill_transform = false;
transform_counter = 0;
transform_done = 3;

