


canmeow = false;
canjump = false;
jumplevel = 0;
jumpspd = .42;
meowpower = 0;
walkspeed = .075;
walklevel = 0;
flight = false;
lasering = false;
laserx = 0;
lasery = 0;
laserz = 0;
won = false;
wintimer = 0;
fadeout = 0;
firstlaunch = true;
riding = noone;

scalepostoroom();

unlocks = [];
unlocks[5] = {
	get: function(){
		canmeow = true;
		obj_camera.controlshake = 5;
	},
	text: "meowing unlocked",
};
unlocks[9] = {
	get: function(){
		canjump = true;
		obj_camera.controlshake = 5;
	},
	text: "jumping unlocked",
};
unlocks[17] = {
	get: function(){
		meowpower = 1;
	},
	text: "powerful meowing",
};
unlocks[25] = {
	get: function(){
		walkspeed = .15;
		walklevel = 1;
	},
	text: "faster running",
};
unlocks[40] = {
	get: function(){
		meowpower = 2;
	},
	text: "thunderous meowing",
};
unlocks[50] = {
	get: function(){
		jumplevel = 1;
		jumpspd = .625;
	},
	text: "super jumping",
};
uberunlock = 70;
unlocks[uberunlock-1] = {
	get: function(){
		obj_camera.controlshake = 5;
		flight = true;
	},
	hide: true,
	text: "UBER MODE",
};
bruhlaunchtime = 0;
bruhlaunch = false;

//88


vbuff = obj_camera.vbuff_cat;
vbuff_air = obj_camera.vbuff_cat_jump;
anim_walk = [
	load_vbuff("cat_step1"),
	vbuff,
	load_vbuff("cat_step2"),
	vbuff,
];
tex = sprite_get_texture(sp_tex_cat,0);


setup_3d_object();
hitground = function() {
	with obj_hitmeow {
		if point_distance_3d(x,y,z,obj_cat.x,obj_cat.y,obj_cat.z)<20 {
			hitmeow(999);
		}
	}
}
onground = function(){
	airtime = 0;
	if !prevgrounded && zsprev>0 {
		squish = .1;
		sfx_play(snd_grounded,,false);
	}
	grounded = true;
	prevgrounded = true;
	//grounded = true;
	if state=="flying" {
		screenshake(1);
		state = "walking";
		audio_play_sound(snd_land,0,false);
		var s = instance_create(x,y,z,obj_shockwave);
		s.type = 1;
		hitground();
	}
	zsp = min(zsp,0);
}
zsprev = 0;
fric = .8;
fric_def = fric;
jholdtimer = 0;

squish = 1;
grounded = false;
prevgrounded = false;
grav    = .015;
airgrav = .008
walktimer = 0;
zang = 0;
walkdir = 0;
launchtimer = 0;
launchtime = 90;
airtime = 0;
coyotetime = 8;
jumpbuffer = 0;
jumpbuffer_time = 8;

state = "walking";
points = 0;

grounded = true;

meowtimer = 0;
meowtime = 13;
meowind = 0;
shake = 0;

image_xscale = 1/10;
image_yscale = image_xscale;