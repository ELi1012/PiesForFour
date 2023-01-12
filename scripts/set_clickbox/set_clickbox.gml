///@desc create_clickbox
///@arg x
///@arg y
///@arg icon_width
///@arg icon_height
///@arg page_direct

var iix = argument0;
var iiy = argument1;
var iwidth = argument2;
var iheight = argument3;
var page_direct = argument4;
//if page direct is inapplicable it defaults to homepage



var inst = instance_create_layer(iix, iiy, clickbox_depth, obj_clickbox);

inst.initial_y = iiy;
inst.image_xscale = iwidth/clickbox_size;
inst.image_yscale = iheight/clickbox_size;
inst.redirect = page_direct;

return inst;