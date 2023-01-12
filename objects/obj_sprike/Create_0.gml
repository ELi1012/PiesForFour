event_inherited();

moveX = 0;
moveY = 0;
spd = 3;
r = (sprite_get_width(spr_sprike)/2) + 3;

counter = 0;

state = 0;
frame = 0;
fInc = 0;
frameNum = 3;
frameSpd = 15;

flip = 1;

enum states {
	idle,
	wandering,
	alert,
}