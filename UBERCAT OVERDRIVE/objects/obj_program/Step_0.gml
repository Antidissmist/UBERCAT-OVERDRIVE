


if keyboard_check_pressed(ord("F"))
|| keyboard_check_pressed(vk_f11) {
	var f = window_get_fullscreen();
	window_set_fullscreen(!f);
}


if keyboard_check(vk_control) //shhh
&& keyboard_check(vk_shift) 
&& keyboard_check(ord("D")) && keyboard_check_pressed(ord("B")) {
	global.debug = !global.debug;
	audio_play_sound(snd_pickup,0,false)
	
	global.speedrun.running = false;
	global.speedrun.finish = undefined;
	
}



if !PAUSED {
	curtime += current_time-curtime_prev;
}
curtime_prev = current_time;


if !window_has_focus() {
	window_mouse_set_locked(false);
}

//window_set_cursor( window_mouse_get_locked() ? cr_none : cr_default );


