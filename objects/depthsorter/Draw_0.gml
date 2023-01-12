//resize grid

var inst_num = instance_number(par_depthobject);
var dgrid = ds_depthgrid;

ds_grid_resize(dgrid, 2, inst_num);

//add instances to grid
var yy = 0; with (par_depthobject) {
	dgrid[# 0, yy] = id; //column 0 has id of objects
	dgrid[# 1, yy] = y;  //column 1 has y position of objects
	
	yy += 1;
}

//sort grid in ascending order
ds_grid_sort(dgrid, 1, true); //column 1 is y position

//loop through grid and draw all instances

var inst; yy = 0; repeat(inst_num) {
	//pull out ID
	inst = dgrid[# 0, yy];
	
	//draw yourself
	with (inst) {
		//can either draw using depthobject or manually draw it through another object
		if (inst.draw_using_depth) event_perform(ev_draw, 0); //object will not appear if it has no draw event
	}
	yy += 1;
}

