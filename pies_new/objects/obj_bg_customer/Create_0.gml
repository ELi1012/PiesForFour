spd = 2;

wandering = 1;
idle = 2;

state = wandering;
timer = 0;
timer_max = 3;
dir = 1;
size_scale = 1;
frame_size = 64;

moveX = 0;
moveY = 0;

x_offset = sprite_get_xoffset(spr_customer_mask);
y_offset = sprite_get_yoffset(spr_customer_mask);
x_frame = 0;
y_frame = 0;