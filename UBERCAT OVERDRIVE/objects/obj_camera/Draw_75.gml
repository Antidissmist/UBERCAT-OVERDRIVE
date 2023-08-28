


if PAUSED && !sprite_exists(global.pausesprite) {
	//global.pausesprite = sprite_create_from_surface(application_surface,0,0,applwidth,applheight,0,0,0,0);
}

if keyboard_check_pressed(ord("C")) {
	global.pausesprite = sprite_create_from_surface(application_surface,0,0,applwidth,applheight,0,0,0,0);
}

if sprite_exists(global.pausesprite) {
	gpu_set_blendenable(false);
	draw_sprite_ext(global.pausesprite,0,0,0,1/5,1/5,0,c_white,1);
	gpu_set_blendenable(true);
}