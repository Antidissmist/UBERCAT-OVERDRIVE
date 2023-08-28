/// @desc control


/*
if !mouselock {
	
	window_mouse_set_locked(false);
	
}
else {
	
	//window_mouse_set(window_get_width()/2,window_get_height()/2);
	
	
	//mousedx = (mousex-(window_get_width()/2));
	//mousedy = (mousey-(window_get_height()/2));
	
	
	
	//var mx = device_mouse_x_to_gui(0)/gw*window_get_width();
	//var my = device_mouse_y_to_gui(0)/gh*window_get_height();
	
	/*var mx = window_mouse_get_x();
	var my = window_mouse_get_y();
	var winw = window_get_width();
	var winh = window_get_height();
	
	winw = round(winw/2)*2;
	winh = round(winh/2)*2;
	
	mousedx = ( mx - (winw/2) );
	mousedy = ( my - (winh/2) );
	window_mouse_set( winw/2, winh/2 );*/
	
	/*mousedx = ( display_mouse_get_x() - (display_get_width()/2) );
	mousedy = ( display_mouse_get_y() - (display_get_height()/2) );
	window_mouse_set( display_get_width()/2, display_get_height()/2 );*/
	
if !PAUSED {
	window_mouse_set_locked(true);
}

if window_mouse_get_locked() {
	mousedx = window_mouse_get_delta_x();
	mousedy = window_mouse_get_delta_y();
	
	beenlocked = true;
	
	if !showed_keys {
		announce("WASD + mouse to move").lifetimer = 240;
		showed_keys = true;
	}
	
}
else {
	mousedx = 0;
	mousedy = 0;
	
	if beenlocked && !PAUSED { //for some reason i cant check vk_escape
		pause_game(true);
	}
	beenlocked = false;
}
	
//}



if !window_has_focus() && !PAUSED {
	pause_game(true);
}

if key_pressed(vk_escape) && can_interact() {
	pause_game(!PAUSED);
}


if keyboard_check(vk_control) && global.debug {
	
	if keyboard_check_pressed(ord("N")) {
		global.show_bboxes = !global.show_bboxes;
	}
	if keyboard_check_pressed(ord("R")) {
		game_restart();
	}
	if keyboard_check_pressed(ord("Y")) {
		repeat (10) {
			instance_create(obj_cat.x,obj_cat.y,obj_cat.z,obj_catfood);
		}
	}
	if keyboard_check_pressed(ord("U")) {
		global.show_ui = !global.show_ui;
	}
	if keyboard_check_pressed(ord("M")) {
		global.mastergain = !global.mastergain;
		audio_set_master_gain(0,global.mastergain);
	}
}



yaw -= mousedx*yawscale;
pitch += mousedy*pitchscale;
shake = lerp(shake,0,.15);
controlshake = lerp(controlshake,0,.15);
fovtarg = min(fovtarg,fovmax);
fov = lerp(fov,fovtarg,.075);

pitch = clamp(pitch,-pitchlimit,pitchlimit);