

global.mastergain = 1;
global.music = -1;

global.gain_def = {};
function gaindef(sound,gain) {
	global.gain_def[$ sound] = gain;
}
gaindef(snd_carcrash,.81);
gaindef(snd_unlock,.71);
gaindef(snd_takeoff,.71);
gaindef(snd_pickup,.8);
gaindef(snd_grounded,.52);
gaindef(snd_flight,.61);
gaindef(snd_explosion2,.69);
gaindef(snd_charge,.56);
gaindef(snd_carcrash,.81);


function sound_set_gain(ind,g,frames=0) {
	audio_sound_gain(ind,struct_get(global.gain_def,audio_get_name(ind),1)*g,frames/30*1000);
}
function adjust_volume(gain=global.mastergain) {
	
	global.mastergain = clamp(gain,0,1);
	
	audio_set_master_gain(0,global.mastergain);
	
	/*
	try {
		for(var i=0; audio_exists(i); i++) {
			sound_set_gain(i,global.mastergain);
		}
	}
	catch (e) {
		log(e);	
	}*/
	
}


function sfx_play(snd,pit=1,interrupt=true) {
	
	if interrupt || !audio_is_playing(snd) {
		var a = audio_play_sound(snd,0,false);
		audio_sound_pitch(a,pit);
	}
	
}

global.listener_speedmult = 4;
global.falloff_dist = 50
global.falloff_max = 100
global.falloff_factor = 1;
audio_falloff_set_model(audio_falloff_exponent_distance);

function sfx_play_3d(snd,xx,yy,zz,pit=1,interrupt=true) {
	
	if interrupt || !audio_is_playing(snd) {
		var a = audio_play_sound_at(snd,xx,yy,zz,global.falloff_dist,global.falloff_max,global.falloff_factor,false,0);
		audio_sound_pitch(a,pit);
	}
	
}