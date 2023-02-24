


shake = lerp(shake,0,.2);
squish = lerp(squish,1,.2);

zsp += .015;
z += zsp;

var pground = grounded;
if z>0 {
	z = 0;
	zsp = 0;
	grounded = true;
	scarelevel = 0;
}
else {
	grounded = false;
}

if !pground && grounded {
	squish = .3;
}


if state=="walking" {
	walktimer++
	
	if floor(walktimer % 3)==0 {
		walkdir_targ += random_range(-walkchange,walkchange);
	}
	walkdir = lerp_angle(walkdir,walkdir_targ,.1);
	
	xsp = lengthdir_x(1,walkdir)*walkspeed;
	ysp = lengthdir_y(1,walkdir)*walkspeed;
	
	var mdir = point_direction(0,0,xsp,ysp)+90;
	if grounded {
		zang = lerp_angle(zang,mdir,.2);
	}
	
	if place_solid(x+xsp,y+ysp,z) {
		walkdir_targ += random_range(160,200)*choose(-1,1);
	}
	
}
else if state=="running" {
	walktimer += 1.5;
	
	var rdir = PLAYERDIR+180;
	
	xsp = lengthdir_x(1,rdir)*runspeed;
	ysp = lengthdir_y(1,rdir)*runspeed;
	
	
	var mdir = point_direction(0,0,xsp,ysp)+90;
	if grounded {
		zang = lerp_angle(zang,mdir,.2);
	}
	
	
	if PLAYERDIST>50 {
		state = "walking";
	}
}

if moneytimer>0 {
	moneytimer--
}


move3d();
get_yeet();