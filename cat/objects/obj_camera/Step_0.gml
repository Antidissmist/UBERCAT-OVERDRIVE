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
	
	window_mouse_set(window_get_width()/2,window_get_height()/2);
	window_set_cursor(cr_none);
	
	mousedx = (mousex-(window_get_width()/2));
	mousedy = (mousey-(window_get_height()/2));
	
}




if keyboard_check_pressed(ord("F")) {
	var f = window_get_fullscreen();
	window_set_fullscreen(!f);
}
if keyboard_check(vk_control) {
	
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
	if keyboard_check_pressed(ord("Y")) {
		screenshake(1);
	}
	if keyboard_check_pressed(ord("U")) {
		screenshake(5);
	}
}




yaw -= mousedx*yawscale;
pitch += mousedy*pitchscale;
shake = lerp(shake,0,.15);
fov = lerp(fov,fovtarg,.075);

pitch = clamp(pitch,-pitchlimit,pitchlimit);