


shake = lerp(shake,0,.2);
squish = lerp(squish,1,.2);

zsp += .015;
z += zsp;

var pground = grounded;
if z>=zstart {
	z = zstart;
	zsp = 0;
	grounded = true;
}
else {
	grounded = false;
}

if !pground && grounded {
	squish = .3;
}

if !grounded {
	zang = lerp(zang,zangtarg,.2);
}
else {
	zang = zangtarg;
}


get_yeet();