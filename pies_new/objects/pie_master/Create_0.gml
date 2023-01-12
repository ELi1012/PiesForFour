enum pies_t1 {	
	//tier 1
	strawberry_t1,
	blueberry_t1,
	sus_meat,
	meat_t1,
	
	height
}
	
enum pies_t2 {
	//tier 2
	
	strawberry,
	blueberry,
	pineapple,
	meat,
	
	cherry,
	peach_cobbler,
	french_toast,
	
	height
}

enum pies_t3 {
	//tier 3
	
	lemon_meringue,
	key_lime,
	clafoutis,
	specialty_meat,
	
	sd_cinnamon,
	sf_cheesecake,
	
	height
}

enum pies_t4 {
	//tier 4
	matcha_mille_crepe,
	baked_alaska,
	tiramisu,
	
	sf_cheesecake,
	strawberry,
	lemon_meringue,
	specialty_meat,
	
	
	height
}




//CHECK DESTROY GRIDS
ds_pie_t1 = ds_grid_create(3, 1);
ds_pie_t1[# 0, 0] = -1;

ds_pie_t2 = ds_grid_create(3, 1);
ds_pie_t2[# 0, 0] = -1;

ds_pie_t3 = ds_grid_create(3, 1);
ds_pie_t3[# 0, 0] = -1;

ds_pie_t4 = ds_grid_create(3, 1);
ds_pie_t4[# 0, 0] = -1;

//FUNCTION IS NOT THE SAME AS THE DS GRID
//tier 1
create_pie_type(pies_t1.strawberry_t1,	5, ds_pie_t1, "Strawberry");
create_pie_type(pies_t1.blueberry_t1,	3, ds_pie_t1, "Blueberry");
create_pie_type(pies_t1.sus_meat,		2, ds_pie_t1, "Meat??");
create_pie_type(pies_t1.meat_t1,		7, ds_pie_t1, "Meat");

//tier 2
create_pie_type(pies_t2.strawberry,		10, ds_pie_t2, "Strawberry");
create_pie_type(pies_t2.blueberry,		8, ds_pie_t2,	"Blueberry");
create_pie_type(pies_t2.pineapple,		14, ds_pie_t2,	"Pineapple");
create_pie_type(pies_t2.meat,			16, ds_pie_t2, "Meat");

create_pie_type(pies_t2.cherry,			11, ds_pie_t2,  "Cherry");
create_pie_type(pies_t2.peach_cobbler,	15, ds_pie_t2, "Peach Cobbler");
create_pie_type(pies_t2.french_toast,	13, ds_pie_t2, "French Toast");

//tier 3
create_pie_type(pies_t3.lemon_meringue, 20, ds_pie_t3,	"Lemon Meringue");
create_pie_type(pies_t3.key_lime,		15, ds_pie_t3,	"Key Lime");
create_pie_type(pies_t3.clafoutis,		16, ds_pie_t3,	"Clafoutis");
create_pie_type(pies_t3.specialty_meat, 30, ds_pie_t3,	"Specialty Meat");

create_pie_type(pies_t3.sd_cinnamon,	28, ds_pie_t3,	"Sourdough Cinnamon");
create_pie_type(pies_t3.sf_cheesecake,	35, ds_pie_t3,	 "Souffle Cheesecake");

//tier 4
create_pie_type(pies_t4.matcha_mille_crepe,	45, ds_pie_t4,	"Matcha Mille Crepe");
create_pie_type(pies_t4.baked_alaska,		60, ds_pie_t4,	"Baked Alaska");
create_pie_type(pies_t4.tiramisu,			38, ds_pie_t4,	"Tiramisu");
create_pie_type(pies_t4.sf_cheesecake,		40, ds_pie_t4,	"Souffle Cheesecake");
create_pie_type(pies_t4.strawberry,			20, ds_pie_t4,	"Strawberry Pie");
create_pie_type(pies_t4.lemon_meringue,		20, ds_pie_t4,	"Lemon Meringue");
create_pie_type(pies_t4.specialty_meat,		30, ds_pie_t4,	"Specialty Meat Pie");











