/// @desc move


var hpress = keyboard_check(ord("D"))-keyboard_check(ord("A"));
var vpress = keyboard_check(ord("S"))-keyboard_check(ord("W"));

var prevgrounded = grounded;
grounded = z>=0 || place_solid(x,y,z+.1);
if !prevgrounded && grounded && zsprev>0 {
	squish = .1;
}

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

//interactions
if obj_camera.mouselock {
	if state=="walking" {
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
		
		if canjump && grounded && keyboard_check_pressed(vk_space) {
			zsp = -jumpspd;
			squish = 1.3;
		}
	}
}

zang = lerp_angle(zang,walkdir,.2);
shake = lerp(shake,0,.2);
squish = lerp(squish,1,.2);


fric = lerp(fric,fric_def,.1);
xsp *= fric;
ysp *= fric;
//zsp *= f;
if !grounded {
	zsp += grav;
}

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
