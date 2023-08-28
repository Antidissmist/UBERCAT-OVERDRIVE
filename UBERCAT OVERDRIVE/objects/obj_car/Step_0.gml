


shake = lerp(shake,0,.2);
squish = lerp(squish,1,.2);

zsp += .015;
z += zsp;

var pground = grounded;
if place_solid(x,y,z+0.1) && !blowaway {
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


xprev = x;
yprev = y;
zprev = z;

//path
if onpath && hittimer<=0 {
	velocity = lerp(velocity,pspeed,.05);
	pathperc = (pathperc+velocity) % 1;
	var tx = path_getx(path,pathperc);
	var ty = path_gety(path,pathperc);
	
	if place_meeting_3d(tx,ty,z,obj_car) {
		crash();
		exit;
	}
	
	
	//dudes
	if place_meeting(x,y,obj_man) {
		
		var list = instplacelist;
		ds_list_clear(list);
		instance_place_list(x,y,obj_man,list,false);
		var len = dsize(list);
		var c;
		for(var i=0; i<len; i++) {
			c = list[| i];
			if c.collides && c.bonktimer==0 && rectangle_in_rectangle( 0,z-height,1,z, 0,c.z-c.height,1,c.z) {
				c.hitmeow();
				c.xsp += xsp;
				c.ysp += ysp;
				c.zsp += zsp-1;
				c.bonktimer = 15;
			}
		}
		
	}
	
	
	var playermeeting = place_meeting_3d(x,y,z,obj_cat) && !instance_exists(obj_cat.riding) && unmounttimer<=0;
	if playermeeting {//&& obj_cat.z>=zstart {
		z = min(z,obj_cat.z-obj_cat.height);
		zsp = min(zsp,-.3)
		velocity = min(velocity,hitcatspeed);
		obj_cat.squish = -.2;
		var pdir = PLAYERDIR;
		obj_cat.xsp += lengthdir_x(5,zang-90)+lengthdir_x(1,pdir);
		obj_cat.ysp += lengthdir_y(5,zang-90)+lengthdir_y(1,pdir);
		obj_cat.fric = 1.05;
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
	
	
	if !blowaway && unmounttimer<=0 && !instance_exists(obj_cat.riding) && obj_cat.state=="walking" && place_meeting_3d(x,y,z,obj_cat) && obj_cat.zsp>0 && obj_cat.z<-1 {
		obj_cat.riding = id;
		sfx_play(snd_carmount);
	}
}


if unmounttimer>0 {
	unmounttimer--
}


get_yeet();

var axsp = x-xprev;
var aysp = y-yprev;
var azsp = z-zprev;
if audio_emitter_exists(aem) {
	audio_emitter_position(aem,x,y,z);
	audio_emitter_velocity(aem,axsp*global.listener_speedmult,aysp*global.listener_speedmult,azsp*global.listener_speedmult);
}

