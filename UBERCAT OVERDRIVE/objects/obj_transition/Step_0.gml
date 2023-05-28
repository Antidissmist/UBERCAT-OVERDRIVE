

if !playing_animation {
	timer += countspeed;


	if state==0 {
	
		if timer>=.5 {
			if animmode!=-1 && !played_animation {
				play_animation();
				timer = .5;
			}
			else {
				onhalfway();
				if goesto!=room {
					room_goto(goesto);
				}
				state = 1;
			}
		}
	}
	else {
	
	
		if timer>1 {
			onfinish();
			instance_destroy();
		}
	
	}
}