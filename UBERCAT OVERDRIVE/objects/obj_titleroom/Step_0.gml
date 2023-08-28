if !startedmusic && !audio_is_playing(mus_title) {
	global.music = audio_play_sound(mus_title,10,true);
	sound_set_gain(global.music,1,25);
	startedmusic = true;
}