


if lifetimer>0 {
	lifetimer--
}
else {
	fadeout--
	if fadeout<=0 {
		instance_destroy();
	}
}


image_alpha = fadeout/fadetime;


y -= 1;