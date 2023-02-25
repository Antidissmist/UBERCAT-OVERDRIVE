/// @desc control


mxprev = mousex;
myprev = mousey;
mousex = window_mouse_get_x();
mousey = window_mouse_get_y();


if !mouselock {
	if mouse_check_button_pressed(mb_any) {
		mouselock = true;
	}
	
	window_set_cursor(cr_default);

	mousedx = 0;
	mousedy = 0;

}
else {
	if keyboard_check_pressed(vk_escape) {
		mouselock = false;
	}
	
	//window_mouse_set(window_get_width()/2,window_get_height()/2);
	window_set_cursor(cr_none);
	
	//mousedx = (mousex-(window_get_width()/2));
	//mousedy = (mousey-(window_get_height()/2));
	
	
	
	//var mx = device_mouse_x_to_gui(0)/gw*window_get_width();
	//var my = device_mouse_y_to_gui(0)/gh*window_get_height();
	
	var mx = window_mouse_get_x();
	var my = window_mouse_get_y();
	var winw = window_get_width();
	var winh = window_get_height();
	
	winw = round(winw/2)*2;
	winh = round(winh/2)*2;
	
	mousedx = ( mx - (winw/2) );
	mousedy = ( my - (winh/2) );
	window_mouse_set( winw/2, winh/2 );
	
	/*mousedx = ( display_mouse_get_x() - (display_get_width()/2) );
	mousedy = ( display_mouse_get_y() - (display_get_height()/2) );
	window_mouse_set( display_get_width()/2, display_get_height()/2 );*/
}




if keyboard_check(vk_control) && global.debug {
	
	if keyboard_check_pressed(ord("B")) {
		global.show_bboxes = !global.show_bboxes;
	}
	if keyboard_check_pressed(ord("R")) {
		game_restart();
	}
	if keyboard_check_pressed(ord("T")) {
		repeat (10) {
			instance_create_depth(obj_cat.x,obj_cat.y,0,obj_catfood);
		}
	}
}
if keyboard_check(vk_control) //shhh
&& keyboard_check(vk_shift) 
&& keyboard_check(ord("D")) && keyboard_check_pressed(ord("B")) {
	global.debug = !global.debug;
	audio_play_sound(snd_pickup,0,false)
}



yaw -= mousedx*yawscale;
pitch += mousedy*pitchscale;
shake = lerp(shake,0,.15);
controlshake = lerp(controlshake,0,.15);
fovtarg = min(fovtarg,fovmax);
fov = lerp(fov,fovtarg,.075);

pitch = clamp(pitch,-pitchlimit,pitchlimit);