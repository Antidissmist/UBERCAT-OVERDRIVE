


shake = lerp(shake,0,.2);
squish = lerp(squish,1,.2);

zsp += .015;
z += zsp;

var pground = grounded;
if z>0 {
	z = 0;
	zsp = 0;
	grounded = true;
}
else {
	grounded = false;
}

if !pground && grounded {
	squish = .3;
}


//path
if onpath && hittimer<=0 {
	xprev = x;
	yprev = y;
	velocity = lerp(velocity,pspeed,.05);
	pathperc = (pathperc+velocity) % 1;
	var tx = path_getx(path,pathperc);
	var ty = path_gety(path,pathperc);
	
	if place_solid(tx,ty,z,obj_car) {
		crash();
		exit;
	}
	var playermeeting = place_solid(x,y,z,obj_cat);
	if playermeeting && obj_cat.z>=zstart {
		z = min(z,obj_cat.z-obj_cat.height);
		zsp = min(zsp,-.3)
		velocity = min(velocity,hitcatspeed);
		obj_cat.squish = -.2;
		var pdir = PLAYERDIR;
		obj_cat.xsp += lengthdir_x(5,zang-90)+lengthdir_x(1,pdir);
		obj_cat.ysp += lengthdir_y(5,zang-90)+lengthdir_y(1,pdir);
		obj_cat.fric = 1;
		if !onplayer {
			audio_play_sound(snd_carbeep,0,false);
			audio_play_sound(snd_grounded,0,false);
		}
		onplayer = true;
		
	}
	if !playermeeting {
		onplayer = false;
	}
	
	x = tx;
	y = ty;
	var mdir = point_direction(xprev,yprev,x,y)+90;
	zangdiff += angle_difference(zang,mdir)/4;
	zangdiff = clamp(zangdiff,-25,25);
	zangdiff = lerp(zangdiff,0,.1);
	zang = lerp_angle(zang,mdir,.2);
}

if hittimer>0 {
	hittimer--
	zang = lerp(zang,zangtarg,.2);
	velocity = 0;
}


get_yeet();