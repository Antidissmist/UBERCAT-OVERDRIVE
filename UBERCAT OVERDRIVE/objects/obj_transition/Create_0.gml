


goesto = room;
timer = state*.5;
animmode = -1;
played_animation = false;
playing_animation = false;
animtimer = 0;

//state=0

countspeed = 1/50;
half_frames = 25;

onhalfway = do_nothing;
onfinish = do_nothing;

surf = -1;

chan = animcurve_get_channel(cr_transition,"x");


play_animation = function() {
	
	playing_animation = true;
	played_animation = true;
	
	if animmode=="catspin" {
		sfx_play(snd_catprint);
	}
	
}
draw_animation = function() {
	
	
	if animmode=="catspin" {
		
		animtimer += sprite_get_speed(sp_loading);
		var sc = .75;
		draw_sprite_ext(sp_loading,animtimer, gw/2,gh/2, sc,sc, 0,c_white,1);
		
		if animtimer>=sprite_get_number(sp_loading)-1 {
			playing_animation = false;
		}
		
	}
	
}
