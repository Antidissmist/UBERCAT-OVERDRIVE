/// @desc move


var hpress = keyboard_check(ord("D"))-keyboard_check(ord("A"));
var vpress = keyboard_check(ord("S"))-keyboard_check(ord("W"));

var prevgrounded = grounded;
grounded = z>=0 || place_solid(x,y,z+.05);
if !prevgrounded && grounded && zsprev>0 {
	squish = .1;
}
if grounded {
	state = "walking";
}


//interactions
if obj_camera.mouselock {
	
	if state=="walking" {
		
		
		//walking controls
		var yaw = obj_camera.yaw;
		if vpress!=0 {
			xsp += lengthdir_x(vpress,yaw)*walkspeed;
			ysp += lengthdir_y(vpress,yaw)*walkspeed;
		}
		if hpress!=0 {
			xsp += lengthdir_x(hpress,yaw+90)*walkspeed;
			ysp += lengthdir_y(hpress,yaw+90)*walkspeed;
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
		}
		
		
		
		//meow
		if mouse_check_button_pressed(mb_left) && canmeow {
			meowtimer = meowtime;
			meowind = irandom(sprite_get_number(sp_meow)-1);
			shake = .1;
			
			var p = instance_create_depth(x,y,0,obj_meowrange);
			p.image_angle = zang;
			p.z = z+.5;
			p.height = 1;
			p.meowpower = meowpower;
			p.meow();
			
			if meowpower>=1 {
				screenshake(.4);
			}
			else if meowpower>=2 {
				screenshake(.6);
			}
			
		}
		
		
		var jumppress = keyboard_check_pressed(vk_space);
		if flight {
			jumppress = keyboard_check_released(vk_space);
		}
		var jhold = keyboard_check(vk_space);
		if !jhold {
			launchtimer = 0;
			jholdtimer = 0;
		}
		else {
			jholdtimer++
		}
		
		
		
		if canjump && grounded && jumppress {
			zsp = -jumpspd;
			squish = 1.3;
		}
		else if grounded && jhold && flight && jholdtimer>8 {
			
			
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
		
	}
	
	//flying
	else if state=="flying" {
		
		
		var p = particle_create(x,y,z,sp_trail_white);
		//v = random_range(.5,.7);
		p.scale = random_range(3,6)/80;
		//p.xsp = random_range(-v,v);
		//p.ysp = random_range(-v,v);
		//p.zsp = random_range(-v,v);
		//p.image_index = irandom(2);
		p.image_speed = random_range(.8,1.1);
		
		
		if vpress!=0 {
			var accel = .1*-vpress;
			xsp += obj_camera.vecx*accel;
			ysp += obj_camera.vecy*accel;
			zsp += obj_camera.vecz*accel;
		}
		
		
		var vel = point_distance_3d(0,0,0, xsp,ysp,zsp);
		zsp += airgrav * (1/(vel)); //fall if slowing down
		
		
		obj_camera.fovtarg = 70+(vel*20);
		
		
		var f = .98
		xsp *= f;
		ysp *= f;
		zsp *= f;
		
	}
	
}


zang = lerp_angle(zang,walkdir,.2);
shake = lerp(shake,0,.2);
squish = lerp(squish,1,.2);


zsprev = zsp;
move3d();




var pl = instance_place_3d(x,y,z,obj_catfood);
if pl!=noone {
	var prevpoints = points;
	pl.collect();
	for(var i=prevpoints+1; i<=points && i<alen(unlocks); i++) {
		var k = unlocks[i];
		if is_struct(k) {
			method(id,k.get)();
			announce(k.text);
		}
	}
}

if meowtimer>0 {
	meowtimer--
}
