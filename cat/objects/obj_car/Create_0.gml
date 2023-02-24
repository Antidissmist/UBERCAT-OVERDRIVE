

event_inherited();
height = 7;

//path=-1

onpath = false;
pathperc = 0;
pspeed = .02;
hitcatspeed = .004;
if path_exists(path) {
	onpath = true;
	pathperc = random(1);
	x = path_getx(path,pathperc);
	y = path_gety(path,pathperc);
	pspeed = 1 / path_get_length(path);
}
velocity = pspeed;
xprev = x;
yprev = y;
zangdiff = 0;
hittimer = 0;
hittime = 75;
zangtarg = 0;



sprite_index = sp_car_tex;
vbuff = obj_camera.vbuff_car;
tex = sprite_get_texture(sp_car_tex,0);

zang = random(360);

image_xscale = 1/10;
image_yscale = image_xscale;

shake = 0;
squish = 1;
grounded = true;

crash = function() {
	shake = .2;
	squish = 2.5;
	if z>=0 {
		zsp = -.25;
	}
	
	hittimer = hittime;
	zangtarg = zang+random_range(400,750)*choose(-1,1);
}
hitmeow = function(meowpower) {
	//hit by player
	
	if meowpower>=1 {
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
	}
	
	if meowpower>=2 {
		yeet();
		
		if z>=0 {
			decal_create(x,y,z);
		}
		
		
		onpath = false;
	}
	
}
