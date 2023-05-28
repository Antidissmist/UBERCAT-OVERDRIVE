


var ww = applwidth;
var hh = applheight;
if !surface_exists(surf) {
	surf = surface_create(ww,hh);
}



surface_set_target(surf);
	draw_clear(c_black);
	
	
	gpu_set_blendmode(bm_subtract);
	var rad = animcurve_channel_evaluate(chan,timer);
	var dist = point_distance(0,0,ww/2,hh/2);
	draw_circle(ww/2,hh/2,dist*(1-rad),false);
	gpu_set_blendmode(bm_normal);


surface_reset_target();




draw_surface(surf,0,0);


if playing_animation {
	draw_animation();
}
