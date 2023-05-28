

event_inherited();
height = 7;

sprite_index = sp_tex_man1;
vbuff = obj_camera.vbuff_man_stand;
tex = sprite_get_texture(sp_tex_man1,0);
tex_flip = sprite_get_texture(sp_tex_man_flip,0);
tex_scared = sprite_get_texture(sp_tex_man_scared,0);

aem = audio_emitter_create();
audio_emitter_falloff(aem,global.falloff_dist,global.falloff_max,global.falloff_factor);

zang = random(360);

image_xscale = 1/10;
image_yscale = image_xscale;

walktimer = 0;
walkdir = 0;
walkdir_targ = 0;
walkchange = 3;
walkspeed = .15;
runspeed = .35;
runspeed_increase = .12;

state = "walking";
vbuff_air = obj_camera.vbuff_man_air;
anim_walk = [
	obj_camera.vbuff_man_step,
	vbuff,
	obj_camera.vbuff_man_step,
	vbuff,
];

shake = 0;
squish = 1;
grounded = true;
scarelevel = 0;
moneytimer = 0;
moneytime = 300;
runtime = 0;
rundir = 0;

hitmeow = function(mpower) {
	
	//regular
	if mpower<=0 {
		shake = .2;
		squish = 1.2;
		if z>=0 {
			zsp = -.12;
		}
	}
	//powerful
	else {
		shake = .2;
		squish = 2.5;
		if z>=0 {
			zsp = -.25;
		}
		runspeed += runspeed_increase;
	}
	
	zang = PLAYERDIR+90;
	
	instance_create(x,y,z-height-4,obj_alert);
	if mpower>=1 {
		
		if moneytimer<=0 {
			instance_create(x,y,z,obj_money)
			moneytimer = moneytime;
		}
		screenshake(.4);
		state = "running";
	}
	scarelevel = mpower;
	
	
	if mpower>=2 {
		
		var p;
		var v;
		repeat(8) {
			p = particle_create(x,y,z,sp_yeet_trail);
			v = random_range(.5,.7);
			p.scale = random_range(3,6)/20;
			p.xsp = random_range(-v,v);
			p.ysp = random_range(-v,v);
			p.zsp = random_range(-v,v);
			p.image_index = irandom(2);
			p.image_speed = random_range(.8,1.1);
		}
		
		if z>=0 {
			decal_create(x,y,z);
		}
		
		yeet();
		audio_play_sound_on(aem,snd_man_scream,false,0,2);
	}
	
}
