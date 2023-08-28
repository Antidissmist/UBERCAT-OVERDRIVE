
//show_debug_overlay(true)

global.debug = false;
global.version = "version 1.1";
global.changelog_link = "https://antidissmist.itch.io/ubercat-overdrive/devlog/537742/update-11";

global.paused = false;
#macro PAUSED global.paused



global.speedrun = { running: false, start: -infinity, finish: undefined };
global.speedrun_timer = false;


#macro c_text_darkred #7e2553

#macro cur_time obj_program.curtime
#macro mgx device_mouse_x_to_gui(0)
#macro mgy device_mouse_y_to_gui(0)
#macro applwidth surface_get_width(application_surface)
#macro applheight surface_get_height(application_surface)


function do_nothing(){}
draw_set_circle_precision(32);

#macro struct_get struct_get_safe
function struct_get_safe(str,name,def=undefined) {
	return variable_struct_exists(str,name) ? str[$ name] : def;
}


global.noclicking = false;
function key_pressed(key) {
	return !global.noclicking && keyboard_check_pressed(key);
}

global.pause_exclude = [
	obj_program,
	obj_camera,
	obj_transition,
];
global.pausesprite = noone;
function pause_game(state) {
	if !instance_exists(obj_camera) {
		return;
	}
	with obj_cat {
		if won {
			return;
		}
	}
	
	var prev = PAUSED;
	PAUSED = state;
	menumode = 0;
	global.noclicking = true;
	
	if PAUSED {
		unlock_camera();
		
		audio_pause_all();
		
		//var sw = surface_get_width(application_surface);
		//var sh = surface_get_height(application_surface);
		//global.pausesprite = sprite_create_from_surface(application_surface,0,0,sw,sh,0,0,0,0);
		
		
		
		
		instance_deactivate_all(false);
		var len = alen(global.pause_exclude);
		for(var i=0; i<len; i++) {
			instance_activate_object(global.pause_exclude[i]);
		}
		
	}
	else {
		lock_camera();
		
		audio_resume_all();
		
		instance_activate_all();
		
		
	}
	
	if sprite_exists(global.pausesprite) {
		//sprite_delete(global.pausesprite);
	}
	//global.pausesprite = noone;
	
	keyboard_key_release(ord("W"));
	keyboard_key_release(ord("S"));
	keyboard_key_release(ord("A"));
	keyboard_key_release(ord("D"));
	//keyboard_key_release(vk_space);
	
	if PAUSED!=prev {
		sfx_play(PAUSED ? snd_pause : snd_unpause);
	}
	
	
}



function transition(rm=room,onhalfway=do_nothing,onfinish=do_nothing,animmode=-1) {
	var t = instance_create_depth(0,0,0,obj_transition);
	t.goesto = rm;
	t.state = 0;
	t.onhalfway = onhalfway;
	t.onfinish = onfinish;
	if !global.debug {
		t.animmode = animmode;
	}
	return t;
}
function transition_restart() {
	var t = transition(,function(){
		pause_game(false);
		game_restart();
	});
	sound_set_gain(global.music,0,t.half_frames);
}

function can_interact() {
	return !instance_exists(obj_transition);
}
function button(xx,yy,label,sc=2) {
	
	
	var sw = string_width(label)*sc;
	var sh = string_height(label)*sc;
	var b = 8;
	var hover = false;
	var ret = false;
	var col = #BE1250;
	
	
	if point_in_rectangle( mgx,mgy, xx-sw/2-b,yy-sh/2-b, xx+sw/2+b,yy+sh/2+b ) && can_interact() {
		hover = true;
		b += 2;
		col = #ffa300;
		
		if mouse_check_button_pressed(mb_left) {
			ret = true;
			sfx_play(snd_button);
		}
	}
	
	
	draw_sprite_stretched(sp_button_back,0, xx-sw/2-b,yy-sh/2-b, sw+b*2,sh+b*2);
	
	draw_center(1,1);
	dtext(xx,yy, label,sc,,col);
	draw_center();
	
	
	return ret;
}



function draw_settings() {
	
	
	var i=0;
	var spc = 70;
	var tx = gw/2;
	var ty = gh*.125;
	var sc = 2;
	
	
	var ret = button(90,40, "Back", sc) || key_pressed(vk_escape);
	
	
	draw_center(1,1);
	
	dtext_outlined(tx,ty+spc*i++, "SETTINGS", sc );
	
	i++
	
	//if button(tx,ty+spc*i++, "Settings", sc) {
		
	//}
	
	
	var w = 210;
	draw_center(1,1);
	dtext(tx,ty+spc*i, "Volume:"+string(round(global.mastergain*100))+"%", sc ,,c_text_darkred);
	if button(tx-w,ty+spc*i, "-", sc) { adjust_volume(global.mastergain-.1) }
	if button(tx+w,ty+spc*i, "+", sc) { adjust_volume(global.mastergain+.1) }
	i++
	
	if button(tx,ty+spc*i++, "Speedrun timer: "+(global.speedrun_timer ? "ON" : "OFF"), sc) {
		global.speedrun_timer = !global.speedrun_timer;
		
		if !global.speedrun_timer {
			global.speedrun.running = false;
		}
		
	}
	
	draw_center();
	
	
	
	return ret;
}





