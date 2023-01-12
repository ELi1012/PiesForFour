if (mouse_above) outline_start(1, c_white, spr_piecutter);

draw_self();

if (mouse_above) {
	outline_end();
	mouse_above = false;
}
