/// @desc move


var mobile = obj_camera.mouselock && !won;
var hpress = (keyboard_check(ord("D"))-keyboard_check(ord("A")))*mobile;
var vpress = (keyboard_check(ord("S"))-keyboard_check(ord("W")))*mobile;


if instance_exists(riding) {
	hpress = 0;
	vpress = 0;
	grounded = true;
	
	x = riding.x+riding.ride_xoff;
	y = riding.y+riding.ride_yoff;
	z = riding.z+riding.ride_zoff;
	
}

//grounded = place_solid(x,y,z+.05);
if grounded {
	airtime = 0;
	/*if !prevgrounded && zsprev>0 {
		squish = .1;
		audio_play_sound(snd_grounded,0,false);
	}*/
	if state=="flying" {
		with obj_hyperline {
			instance_destroy();
		}
		audio_play_sound(snd_land,0,false);
		var s = instance_create(x,y,z,obj_shockwave);
		s.type = 1;
		hitground();
	}
	audio_stop_sound(snd_flight);
	state = "walking";
	zsp = min(zsp,0);
}
else {
	airtime++
}


//interactions
	
if state=="walking" {
	
	
	if firstlaunch && flight && !bruhlaunch {
		bruhlaunchtime++
		if bruhlaunchtime > 800 {
			bruhlaunch = true;
			var a = announce("hold space to launch");
			a.lifetimer = 240;
			a = announce("hold w and mouse to fly");
			a.lifetimer = 240;
		}
	}
	
		
		
	//walking controls
	var yaw = obj_camera.yaw;
	var lx = 0;
	var ly = 0;
	if vpress!=0 {
		lx += lengthdir_x(vpress,yaw);
		ly += lengthdir_y(vpress,yaw);
	}
	if hpress!=0 {
		lx += lengthdir_x(hpress,yaw+90);
		ly += lengthdir_y(hpress,yaw+90);
	}
	
	if lx!=0 || ly!=0 {
		var wdir = point_direction(0,0,lx,ly);
		xsp += lengthdir_x(1,wdir)*walkspeed;
		ysp += lengthdir_y(1,wdir)*walkspeed;
	}


	if (hpress!=0 || vpress!=0) {
		walkdir = point_direction(0,0,xsp,ysp);
		walktimer++
	}
	else {
		walktimer = 0;
	}
	if !grounded {
		walktimer = 0;
		audio_stop_sound(snd_charge);
	}
		
		
		
	//meow
	if mouse_check_button_pressed(mb_left) && canmeow && mobile {
		meowtimer = meowtime;
		meowind = irandom(sprite_get_number(sp_meow)-1);
		shake = .1;
			
		var p = instance_create(x,y,z,obj_meowrange);
		p.image_angle = zang;
		p.meowpower = meowpower;
		p.meow();
			
		if meowpower==0 {
			audio_play_sound(snd_meow,0,false);
		}
		else if meowpower==1 {
			screenshake(.4);
			audio_play_sound(snd_meow_powerful,0,false);
		}
		else if meowpower>=2 {
			screenshake(.6);
			audio_play_sound(snd_meow_thunderous,0,false);
		}
			
	}
		
		
	var jumppress = keyboard_check_pressed(vk_space)*mobile;
	if flight {
		jumppress = keyboard_check_released(vk_space)*mobile;
	}
	if jumppress {
		jumpbuffer = jumpbuffer_time;
	}
	var jhold = keyboard_check(vk_space)*mobile;
	if !jhold {
		launchtimer = 0;
		jholdtimer = 0;
	}
	else {
		jholdtimer++
	}
		
		
		
		
	//jump
	if canjump && (grounded || airtime<coyotetime) && (jumppress || jumpbuffer>0) {
		jumpbuffer = 0;
		airtime += coyotetime;
		zsp = -jumpspd;
		squish = 1.3;
		audio_play_sound(snd_jump,0,false);
		audio_stop_sound(snd_charge);
		with riding {
			unmounttimer = unmounttime;
			other.xsp += xsp;
			other.ysp += ysp;
			other.zsp += zsp;
		}
		riding = noone;
	}
	
	//takeoff
	else if grounded && jhold && flight && jholdtimer>8 {
			
			
		if !audio_is_playing(snd_charge) {
			audio_play_sound(snd_charge,0,false);
		}
			
			
		xsp *= .6;
		ysp *= .6;
			
		launchtimer++
		screenshake( min(((jholdtimer-8)/launchtime), 1.5) );
		squish = .2;
		shake = .5;
		if interval(3) {
			instance_create(x,y,z,obj_shockwave);
		}
		if launchtimer>launchtime {
			
			if firstlaunch {
				announce("reach for the moon").lifetimer = 500;
				firstlaunch = false;
			}
			
			audio_stop_sound(snd_charge);
			audio_play_sound(snd_takeoff,0,false);
			audio_play_sound(snd_flight,0,true);
			
			state = "flying";
			screenshake(2);
			launchtimer = 0;
			zsp = -2;
				
			var s = instance_create(x,y,z,obj_shockwave);
			s.type = 1;
			var s = instance_create(x,y,z,obj_shockwave);
			s.type = 1;
			s.wait = 10;
		}
	}
		
	fric = lerp(fric,fric_def,.1);
	xsp *= fric;
	ysp *= fric;
	if !grounded {
		zsp += grav;
	}
		
		
	obj_camera.fovtarg = obj_camera.fov_def;
	lasering = false;
}
	
//flying
else if state=="flying" {
		
		
		
	//laser
	/*if mouse_check_button(mb_left) && mobile {  //screw this
		
		var cx = obj_camera.vecx;
		var cy = obj_camera.vecy;
		var cz = obj_camera.vecz;
		var lsp = 1;
		if !lasering {
			lsp = 1;
		}
		lasering = true;
		
		laserx = lerp(laserx,cx,lsp);
		lasery = lerp(lasery,cy,lsp);
		laserz = lerp(laserz,cz,lsp);
		
		
		var p;
		var lstep = 3;
		var lx,ly,lz;
		for(var i=0; i<100; i++) {
			lx = x+laserx*lstep*i;
			ly = y+lasery*lstep*i;
			lz = z+laserz*lstep*i;
			p = particle_create(
				lx,
				ly,
				lz,
				sp_trail_white);
			//v = random_range(.5,.7);
			p.scale = random_range(3,6)/80;
			//p.xsp = random_range(-v,v);
			//p.ysp = random_range(-v,v);
			//p.zsp = random_range(-v,v);
			//p.image_index = irandom(2);
			p.image_speed = random_range(.8,1.1);
			
			yeet_place(lx,ly,lz);
		}
	}
	else {
		lasering = false;
	}*/
	
	
	
	
	//meow
	if mouse_check_button_pressed(mb_left) && canmeow && mobile {
		meowtimer = meowtime;
		meowind = irandom(sprite_get_number(sp_meow)-1);
		shake = .1;
		audio_play_sound(snd_meow_thunderous,0,false);
		
		
		with obj_hitmeow {
			if point_distance_3d(x,y,z,obj_cat.x,obj_cat.y,obj_cat.z)<40 {
				hitmeow();
			}
		}
			
		var p = instance_create(x,y,z,obj_meowrange);
		p.image_angle = zang;
		p.meowpower = 999;
		p.scale = 3;
		p.meow();
			
		screenshake(.6);
			
	}
	
	
		
		
	if z<-500 {
		
		var pdir = point_direction_3d(x,y,z, obj_moon.x,obj_moon.y,obj_moon.z);
		
		var yaw = pdir[0];
		var pitch = -pdir[1];
		
		var vaccel = .025;
		var plx = lengthdir_x(1,pitch);
		var ply = lengthdir_x(1,pitch);
		xsp += lengthdir_x(vaccel,yaw) *plx;
		ysp += lengthdir_y(vaccel,yaw) *ply;
		zsp += lengthdir_y(vaccel,pitch);
		
		if point_distance_3d(x,y,z, obj_moon.x,obj_moon.y,obj_moon.z)<(obj_moon.radius+4) {
			win_game();
		}
		
	}
		
		
	if vpress!=0 {
		var accel = .1*-vpress;
		xsp += obj_camera.vecx*accel;
		ysp += obj_camera.vecy*accel;
		zsp += obj_camera.vecz*accel;
	}
		
		
	var vel = point_distance_3d(0,0,0, xsp,ysp,zsp);
	zsp += airgrav * (1/(vel)); //fall if slowing down
	
	if !audio_is_playing(snd_flight) {
		audio_play_sound(snd_flight,0,true);
	}
	audio_sound_gain(snd_flight, (vel>1)*.6  ,2);
		
		
	obj_camera.fovtarg = 70+(vel*20);
		
		
	var f = .98
	xsp *= f;
	ysp *= f;
	zsp *= f;
	
	
	
	/*var p = particle_create(x,y,z,sp_trail_white);
	//v = random_range(.5,.7);
	p.scale = random_range(3,6)/80;
	//p.xsp = random_range(-v,v);
	//p.ysp = random_range(-v,v);
	//p.zsp = random_range(-v,v);
	//p.image_index = irandom(2);
	p.image_speed = random_range(.8,1.1);*/
	
	//log(vel)
	if vel>1 {
		var p;
		var r = 10;
		repeat(5) {
			p = instance_create(
				x+random_range(-r,r),
				y+random_range(-r,r),
				z+random_range(-r,r),
				obj_hyperline
			)
			p.image_xscale = vel*20;
			p.image_yscale = 2;
			p.image_speed = 0;
			p.lifetimer = 15;
			p.dobillboard = false;
		}
	}
	
		
}
	



zang = lerp_angle(zang,walkdir,.2);
shake = lerp(shake,0,.2);
squish = lerp(squish,1,.2);


zsprev = zsp;
prevgrounded = grounded;
if !won {
	move3d();
}



var pl = instance_nearest(x,y,obj_catfood)
if pl!=noone {
	var cdist = point_distance_3d(x,y,z,pl.x,pl.y,pl.z);
	if cdist<6 {
		with pl {
			lerping = true;
			xstart = x;
			ystart = y;
			zstart = z;
		}
	}
	if cdist<1 {
		var prevpoints = points;
		pl.collect();
		for(var i=prevpoints+1; i<=points && i<alen(unlocks); i++) {
			var k = unlocks[i];
			if is_struct(k) {
				method(id,k.get)();
				audio_play_sound(snd_unlock,0,false);
				announce(k.text);
			}
		}
	}
}

if meowtimer>0 {
	meowtimer--
}
if jumpbuffer>0 {
	jumpbuffer--
}



if won {
	wintimer++
	
	if random(1)<.2 {
		audio_play_sound(snd_moonexplosion,0,false,.5,,random_range(.8,1.1));
	}
	
	screenshake(2);
	var p;
	var v;
	var r = 5;
	repeat(3) {
		p = particle_create(
			x+random_range(-r,r),
			y+random_range(-r,r),
			z+random_range(-r,r),
			sp_yeet_trail);
		v = random_range(.5,.7);
		p.scale = random_range(3,6)/12;
		p.xsp = random_range(-v,v);
		p.ysp = random_range(-v,v);
		p.zsp = random_range(-v,v);
		p.image_index = irandom(2);
		p.image_speed = random_range(.8,1.1);
	}
	
	
	if wintimer>300 {
		fadeout += .025;
		if fadeout>1 {
			room_goto(rm_finish);
		}
	}
}



