


if keyboard_check_pressed(ord("F"))
|| keyboard_check_pressed(vk_f11) {
	var f = window_get_fullscreen();
	window_set_fullscreen(!f);
}

