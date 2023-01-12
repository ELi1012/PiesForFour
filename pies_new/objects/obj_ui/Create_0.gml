gui_width = global.game_width;
gui_height = global.game_height;



//clock
clock_width = sprite_get_width(spr_clock);
clock_height = sprite_get_height(spr_clock);
clock_x = gui_width - (clock_width/2) - 20;		// origin at center
clock_y = 60;





//show statistics
st_width = sprite_get_width(spr_stats);
st_height = sprite_get_height(spr_stats);
st_x = 16;
st_y = 16;

st_text_x = st_x + 15;
st_text_y = st_y + 15;


pause_width = sprite_get_width(spr_game_paused);
pause_height = sprite_get_height(spr_game_paused);
draw_pausex = (gui_width/2) - (pause_width/2);
draw_pausey = (gui_height/2) - (pause_height/2);
pause_overlay = false;


press_exitx = 50 + draw_pausex;
press_exity = 152 + draw_pausey;
press_exit_width = 170;
press_exit_height = 44;
pressed_exit = false;

ce_width = sprite_get_width(spr_exit_confirm);
ce_height = sprite_get_height(spr_exit_confirm);
ce_x = (press_exit_width/2) - (ce_width/2) + press_exitx;
ce_y = (press_exit_height/2) - (ce_height/2) + press_exity;


//view tutorial

vt_x = 50 + draw_pausex;
vt_y = 226 + draw_pausey;
vt_width = 190;
vt_height = 44;
view_tutorial = false;




vt_backwidth = sprite_get_width(spr_tutorial_back);
vt_backheight = sprite_get_height(spr_tutorial_back);
vt_backx = (gui_width/2) - (vt_backwidth/2);
vt_backy = (gui_height/2) - (vt_backheight/2);

vt_inc = 0;
vt_length = sprite_get_number(spr_tutorial);

vt_twidth = sprite_get_width(spr_tutorial);
vt_theight = sprite_get_height(spr_tutorial);
vt_tx = vt_backx + (vt_backwidth/2) - (vt_twidth/2);
vt_ty = vt_backy + 30;








