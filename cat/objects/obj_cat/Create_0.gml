


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

scalepostoroom();

unlocks = [];
unlocks[5] = {
	get: function(){
		canmeow = true;
	},
	text: "meowing unlocked",
};
unlocks[9] = {
	get: function(){
		canjump = true;
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
unlocks[70] = {
	get: function(){
		flight = true;
	},
	text: "UBER MODE",
};

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
onground = function(){
	if !prevgrounded {
		//squish = .1;
	}
	//grounded = true;
	if state=="flying" {
		screenshake(1);
		state = "walking";
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

state = "walking";
points = 0;


meowtimer = 0;
meowtime = 13;
meowind = 0;
shake = 0;


image_xscale = 1/10;
image_yscale = image_xscale;