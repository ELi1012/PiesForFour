var nearby = false;
if (place_meeting(x, y, obj_pie)) {
	nearby = true;
	outline_start(1, c_white);
}

draw_self();

if (nearby) outline_end();
