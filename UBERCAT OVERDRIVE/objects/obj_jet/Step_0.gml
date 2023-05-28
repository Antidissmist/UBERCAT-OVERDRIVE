


shake = lerp(shake,0,.2);
squish = lerp(squish,1,.2);




//path
if onpath && hittimer<=0 {
	xprev = x;
	yprev = y;
	zprev = z;
	velocity = lerp(velocity,pspeed,.05);
	pathperc = (pathperc+velocity) % 1;
	var tx = path_getx(path,pathperc);
	var ty = path_gety(path,pathperc);
	
	if place_meeting_3d(tx,ty,z,obj_jet) {
		crash();
		exit;
	}
	
	x = tx;
	y = ty;
	var mdir = point_direction(xprev,yprev,x,y)+90;
	zangdiff += angle_difference(zang,mdir)/4;
	zangdiff = clamp(zangdiff,-25,25);
	zangdiff = lerp(zangdiff,0,.1);
	zang = lerp_angle(zang,mdir,.2);
	
	xsp = x-xprev;
	ysp = y-yprev;
	zsp = z-zprev;
}

if hittimer>0 {
	hittimer--
	zang = lerp(zang,zangtarg,.2);
	velocity = 0;
}

if place_meeting_3d(x,y,z,obj_cat) && onpath {
	hitmeow();
}

var p = particle_create(x,y,z-.5,sp_trail_white);
//v = random_range(.5,.7);
p.scale = random_range(3,6)/80;
//p.xsp = random_range(-v,v);
//p.ysp = random_range(-v,v);
//p.zsp = random_range(-v,v);
//p.image_index = irandom(2);
p.image_speed = random_range(.8,1.1);


get_yeet();


audio_emitter_position(aem,x,y,z);
audio_emitter_velocity(aem,xsp*global.listener_speedmult,ysp*global.listener_speedmult,zsp*global.listener_speedmult);

