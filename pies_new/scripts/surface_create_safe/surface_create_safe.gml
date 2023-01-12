// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function surface_create_safe(surface_id, width, height){
	if (surface_exists(surface_id)) {
		return surface;
	}
	else							{
		return surface_create(width, height);
	}
}