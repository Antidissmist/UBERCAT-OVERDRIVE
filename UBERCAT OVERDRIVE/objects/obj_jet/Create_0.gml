

event_inherited();
height = 7;

//path=-1
path = pt_jet1;
zstart = -300-random(80);
z = zstart;

aem = audio_emitter_create();
audio_emitter_falloff(aem,global.falloff_dist,global.falloff_max,global.falloff_factor);
audio_play_sound_on(aem,snd_jet,true,0,2);

onpath = false;
pathperc = 0;
pspeed = .02;
hitcatspeed = .004;
if path_exists(path) {
	onpath = true;
	pspeed = 1 / path_get_length(path);
	
	pathperc = random(1);
	x = path_getx(path,pathperc);
	y = path_gety(path,pathperc);
	while place_meeting(x,y,obj_jet) { //do not get stuck
		pathperc = random(1);
		x = path_getx(path,pathperc);
		y = path_gety(path,pathperc);
	}
}
velocity = pspeed;
xprev = x;
yprev = y;
zprev = z;
zangdiff = 0;
hittimer = 0;
hittime = 75;
zangtarg = 0;



sprite_index = sp_car_tex;
vbuff = obj_camera.vbuff_jet;
tex = sprite_get_texture(sp_jettex,0);

zang = random(360);

image_xscale = 1/7;
image_yscale = image_xscale;

shake = 0;
squish = 1;
grounded = true;

crash = function() {
	shake = .2;
	squish = 2.5;
	
	hittimer = hittime;
	zangtarg = zang+random_range(400,750)*choose(-1,1);
}
hitmeow = function() {
	//hit by player
	
	screenshake(1);
	crash();
	var p;
	var v;
	repeat(8) {
		p = particle_create(x,y,z,sp_yeet_trail);
		v = random_range(.5,.7);
		p.scale = random_range(3,6)/12;
		p.xsp = random_range(-v,v);
		p.ysp = random_range(-v,v);
		p.zsp = random_range(-v,v);
		p.image_index = irandom(2);
		p.image_speed = random_range(.8,1.1);
	}
	yeet();	
	onpath = false;
	
	obj_cat.points += 4;
	collectnum("+"+string(4));
	
}
