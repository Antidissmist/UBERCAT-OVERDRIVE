

global.music = audio_play_sound(mus_calm,10,true);
sound_set_gain(global.music,1,25);

announce("WASD + mouse to move").lifetimer = 240;



if global.speedrun_timer && !global.debug {
	global.speedrun.running = true;
	global.speedrun.start = cur_time;
	global.speedrun.finish = undefined;
}

