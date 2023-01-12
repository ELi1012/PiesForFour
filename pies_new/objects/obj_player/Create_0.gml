
event_inherited();



w_spd = 2;
n_spd = 5;
r_spd = 8;
spd = n_spd;

w_spd = n_spd;

x_frame = 1;
y_frame = 0;
alpha = 1;

player_mask = spr_player_mask;

x_offset = sprite_get_xoffset(player_mask);
y_offset = sprite_get_yoffset(player_mask);

ds_pie_carry = ds_list_create();
max_pie_carry = 3;
pie_carry_height = 32;

piex_offset = 16;
piey_offset = 0;


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
spr_clothes = -1;

hat_offset = 16;		// hat sprite is slightly taller than actual player sprite

pill_transform = false;
transform_counter = 0;
transform_done = 3;

event_user(0);
