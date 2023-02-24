


canmeow = false;
canjump = false;
jumplevel = 0;
jumpspd = .42;
meowpower = 0;
walkspeed = .075;
walklevel = 0;
flight = false;

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
unlocks[35] = {
	get: function(){
		meowpower = 2;
	},
	text: "thunderous meowing",
};
unlocks[42] = {
	get: function(){
		jumplevel = 1;
		jumpspd = .625;
	},
	text: "super jumping",
};
unlocks[60] = {
	get: function(){
		flight = true;
	},
	text: "SUPER MODE",
};



vbuff = obj_camera.vbuff_cat
anim_walk = [
	load_vbuff("cat_step1"),
	vbuff,
	load_vbuff("cat_step2"),
	vbuff,
];
tex = sprite_get_texture(sp_tex_cat,0);


setup_3d_object();
zsprev = 0;
fric = .8;
fric_def = fric;

squish = 1;
grounded = false;
grav = .015;
walktimer = 0;
zang = 0;
walkdir = 0;

state = "walking";
points = 0;


meowtimer = 0;
meowtime = 13;
meowind = 0;
shake = 0;


image_xscale = 1/10;
image_yscale = image_xscale;