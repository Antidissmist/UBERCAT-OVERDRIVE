


if wait>0 {
	wait--
	exit;
}

scalew += .1;

var m = 0;
if type==1 {
	m = 1;
}


if state==0 {
	scalez += .1;
	if scalez>(1+(m*3)) {
		state = 1;
	}
}
else if state==1 {
	scalez -= .2;
	if scalez<=0 {
		instance_destroy();
	}
}

