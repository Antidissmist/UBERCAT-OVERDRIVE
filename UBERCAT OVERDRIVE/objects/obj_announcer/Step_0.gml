

if showtext!=text {
	if readtimer<=0 {
		showtext += string_char_at(text,string_length(showtext)+1);
		readtimer = 2;
	}
	else {
		readtimer--
	}
}
else {
	if lifetimer>0 {
		lifetimer--
	}
	else {
		fadeout--
		if fadeout<=0 {
			instance_destroy();
		}
	}
}

image_alpha = fadeout/fadetime;